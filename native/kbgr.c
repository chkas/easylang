/*	kbgr.c

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

#include <SDL3/SDL.h>
#include <SDL3_ttf/SDL_ttf.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//#define bool int
//#define true 1
//#define false 0
#define swap(a, b) { int _h = a; a = b; b = _h; }
#define min(a, b) ((a) < (b) ? (a) : (b))

#ifdef RUN
unsigned short sysconfig;
//#define M_PI 3.1415926
#endif

extern int sys_error;

static int gx, gy;
static SDL_Window* window;
static SDL_Renderer* renderer = NULL;
static TTF_Font* font;
static SDL_Color fcol;
static SDL_Color bcol;
static SDL_Texture *display;

static unsigned short SZ = 500;
static double FX;
static double FMX;
static double FMY;
static unsigned short botleft;

static const char* fontname;

static void errx(const char* s) {
	fprintf(stderr, "Error: %s", s);
	fprintf(stderr, " - %s\n", SDL_GetError());
	exit(1);
}

static bool exists(const char* name) {
	struct stat buffer;
	return (stat (name, &buffer) == 0);
}

double textsize;

void gr_textsize(double sz) {
	if (fontname == NULL) return;
	textsize = sz;
	if (font) TTF_CloseFont(font);
	int h = (int)(FX * sz + 0.5);
	font = TTF_OpenFont(fontname, h);
	if (font == NULL) errx("Could not open font");
}

static int linew;
static int linew2;
static int grpen;

void gr_linewidth(double w) {
	linew = FX * w + 0.5;
	linew2 = 0.5 * FX * w + 0.5;
}

void gr_color(int r, int g, int b) {
	fcol.r = r;
	fcol.g = g;
	fcol.b = b;
	SDL_SetRenderDrawColor(renderer, r, g, b, 255);
}
void gr_sys(unsigned short h);

void gr_backcolor(int r, int g, int b) {
	bcol.r = r;
	bcol.g = g;
	bcol.b = b;
	gr_sys(11);
}

#define SMPL_RATE 32768
static void SDLCALL new_audio_cb(void *userdata, SDL_AudioStream *stream, int additional, int total);

static SDL_AudioDeviceID audio_dev;
static char do_animate;

static bool got_sigint;

void handle_sigint(int sig) {
	exit(1);
}
void gr_init(const char* progname, int mask) {

	signal(SIGINT, handle_sigint);

	if (mask == 1024) {
		// only print
		return;
	}
	bcol.r = 255;
	bcol.g = 255;
	bcol.b = 255;
	bcol.a = 255;
	fcol.a = 255;
	SDL_Init(0);
	if (mask & 128) {
		if (!SDL_InitSubSystem(SDL_INIT_VIDEO)) errx("InitSub");
		SDL_DisplayID disp = SDL_GetPrimaryDisplay();
		const SDL_DisplayMode* dm = SDL_GetCurrentDisplayMode(disp);
		if (dm == NULL) errx("dm");
		SZ = min(dm->w, dm->h);

		SZ = SZ * 9 / 10 / 100 * 100;
		FX = SZ / 100.0;
		FMX = FX;
		FMY = FX;

		window = SDL_CreateWindow(progname, SZ, SZ, SDL_WINDOW_RESIZABLE);
		renderer = SDL_CreateRenderer(window, 0);

		if (renderer == NULL) errx("Renderer NULL");

		SDL_SetRenderDrawBlendMode(renderer,SDL_BLENDMODE_BLEND);
		display = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, SZ, SZ);
		SDL_SetRenderTarget(renderer, display);

		SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
		SDL_RenderClear(renderer);

		gr_color(0, 0, 0);
		gr_linewidth(1);
		SDL_RaiseWindow(window);
	}
	if (mask & 256) {
		if (!SDL_Init(SDL_INIT_AUDIO)) errx("SDL_INIT_AUDIO");
		const SDL_AudioSpec spec = { SDL_AUDIO_F32LE, 1, SMPL_RATE };
		SDL_AudioStream *stream = SDL_OpenAudioDeviceStream(SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK, &spec, new_audio_cb, NULL);
		audio_dev = SDL_GetAudioStreamDevice(stream);
		//SDL_ResumeAudioDevice(SDL_GetAudioStreamDevice(stream));
	}
	if (mask & 512) {

// #ifdef __linux__

		const char* fontnames[] = {
#ifdef _WIN32
			"c:\\Windows\\Fonts\\courbd.ttf",
			"c:\\Windows\\Fonts\\cour.ttf"
#elif __APPLE__
			"/Library/Fonts/Arial Unicode.ttf"
#else
			"/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf",
			"/usr/share/fonts/truetype/ttf-bitstream-vera/VeraMoBd.ttf",
#endif
		};

		int n = sizeof(fontnames) / sizeof(fontnames[0]);
		int i;
		for (i = 0; i < n; i++) {
			if (exists(fontnames[i])) break;
		}
		if (i == n) errx("No font found");
		fontname = fontnames[i];
		TTF_Init();
		gr_textsize(8);
	}
	if (mask & 32) do_animate = 1;
	botleft = true;
	if (sysconfig & 1) botleft = false;
	grpen = 0;
	//gx = 0;
	//gy = FX * 100;
}

double inv(double y) {
	if (botleft) return 100 - y;
	return y;
}

static void line(float x1, float y1, float x2, float y2) {
	SDL_RenderLine(renderer, x1, y1, x2, y2);
}

static void circle(float x0, float y0, float lw) {

	if (lw < 5.5) {
		if (lw > 4.5) {
			SDL_RenderPoint(renderer, x0, y0 - 2);
			SDL_RenderLine(renderer, x0 - 1, y0 - 1, x0 + 1, y0 - 1);
			SDL_RenderLine(renderer, x0 - 2, y0, x0 + 2, y0);
			SDL_RenderLine(renderer, x0 - 1, y0 + 1, x0 + 1, y0 + 1);
			SDL_RenderPoint(renderer, x0, y0 + 2);
		}
		else if (lw > 3.5) {
			SDL_RenderLine(renderer, x0 - 1, y0 - 1, x0 + 1, y0 - 1);
			SDL_RenderLine(renderer, x0 - 1, y0, x0 + 1, y0);
			SDL_RenderLine(renderer, x0 - 1, y0 + 1, x0 + 1, y0 + 1);
		}
		else if (lw > 2.5) {
			SDL_RenderPoint(renderer, x0, y0 - 1);
			SDL_RenderLine(renderer, x0 - 1, y0, x0 + 1, y0);
			SDL_RenderPoint(renderer, x0, y0 + 1);
		}
		else if (lw > 1.5) {
			SDL_RenderLine(renderer, x0, y0, x0 + 1, y0);
			SDL_RenderLine(renderer, x0, y0 + 1, x0 + 1, y0 + 1);
		}
		else {
			SDL_RenderPoint(renderer, x0, y0);
		}
		return;
	}

	float rad = lw / 2;
	rad -= 1;
	float f = 1 - rad;
	float fx = 0;
	float fy = -2 * rad;
	float x = 0;
	float y = rad;

	x0 -= 1;
	y0 -= 1;
	line(x0 - rad, y0, x0 + rad, y0);

	while(x < y) {
		if (f >= 0) {
			y -= 1;
			fy += 2;
			f += fy;
		}
		x++;
		fx += 2;
		f += fx + 1;
		line(x0 - x, y0 - y, x0 + x, y0 - y);
		line(x0 - y, y0 - x, x0 + y, y0 - x);
		line(x0 - y, y0 + x, x0 + y, y0 + x);
		line(x0 - x, y0 + y, x0 + x, y0 + y);
	}
}

static void thline(float x1, float y1, float x2, float y2) {
	if (y1 == y2) {
		if (x1 > x2) swap(x1, x2);
		SDL_FRect r = {.x = x1, .y = y1 - linew2, .w = x2 - x1, .h = linew};
		SDL_RenderFillRect(renderer, &r);
	}
	else if (x1 == x2) {
		if (y1 > y2) swap(y1, y2);
		SDL_FRect r = {.x = x1 - linew2, .y = y1, .w = linew, .h = y2 - y1};
		SDL_RenderFillRect(renderer, &r);
	}
	else {
		bool steep = fabsf(y2 - y1) > fabsf(x2 - x1);
		if(steep) {
			swap(x1, y1);
			swap(x2, y2);
		}
		if(x1 > x2) {
			swap(x1, x2);
			swap(y1, y2);
		}
		float dx = x2 - x1;
		float dy = fabsf(y2 - y1);

		float error = dx / 2;
		float ystep = (y1 < y2) ? 1 : -1;

		while (x1 <= x2) {

			if (steep)
				circle(y1, x1, linew);
			else
				circle(x1, y1, linew);

			error -= dy;
			if (error < 0) {
				y1 += ystep;
				error += dx;
			}
			x1 += 1;
		}
	}
}
float transx;
float transy;

#define scx(h) (FX * (h + transx))
#define scy(h) (FX * (inv(h + transy)))
#define sc(h) (FX * h)

static void gr_circle(double fx, double fy, double rad) {
	circle(scx(fx), scy(fy), sc(rad * 2));
}

static void gr_rect(double fx, double fy, double fw, double fh) {
	float x = scx(fx);
	float y = scy(fy);
	float h = sc(fh);
	if (botleft) y -= h;
	SDL_FRect r = {.x = x, .y = y, .w = sc(fw), .h = sc(fh) };
	SDL_RenderFillRect(renderer, &r);

}
static void gr_line(double fx, double fy, double fx2, double fy2) {
	float x = scx(fx);
	float y = scy(fy);
	float x2 = scx(fx2);
	float y2 = scy(fy2);

	circle(x, y, linew);
	if (x == x2 && y == y2) return;
	thline(x, y, x2, y2);
	circle(x2, y2, linew);
	grpen = 1;
	gx = x2;
	gy = y2;
}

void gr_lineto(double fx, double fy) {
	float x = scx(fx);
	float y = scy(fy);
	if (grpen) {
		circle(gx, gy, linew);
		if (gx == x && gy == y) return;
		thline(gx, gy, x, y);
		circle(x, y, linew);
	}
	else grpen = 1;
	gx = x;
	gy = y;
}

void gr_curve(double* val, int len) {
	fprintf(stderr, "curve not implemented yet\n");
}
void gr_translate(double x, double y) {
	transx = x;
	transy = y;
}
void gr_rotate(double w) {
	fprintf(stderr, "rotate not implemented yet\n");
}
void gr_scale(double w) {
	fprintf(stderr, "scale not implemented yet\n");
}

void gr_polygon(double* val, int len) {

	int i, j;
	int n = len / 2;
	if (n < 2) return;

	int nxs, k;
	float* vx = (float*)alloca(sizeof(float) * n);
	float* vy = (float*)alloca(sizeof(float) * n);

	for (i = 0;	i < n; i++) {
		vx[i] = scx(val[i * 2]);
		vy[i] = scy(val[i * 2 + 1]);
	}
	float* xs = (float*)alloca(sizeof(float) * n);
	float y;
	float y0 = vy[0], y1 = y0;
	for (i = 1;	i < n; i++) {
		y = vy[i];
		if (y < y0) y0 = y;
		if (y > y1) y1 = y;
	}

	if (y0 < 0) y0 = 0;
	//if (y1 >= sc(100)) y1 = sc(100) - 1;

	for (y = y0; y <= y1; y++) {
		nxs = 0;
		j = n - 1;
		for (i = 0; i < n; i++) {
			if ((vy[i] < y && y <= vy[j]) || (vy[j] < y && y <= vy[i])) {

				xs[nxs]= (vx[i] + (y - vy[i]) / (vy[j] - vy[i]) * (vx[j] - vx[i]));
				nxs++;
				for (k = nxs - 1; k && xs[k - 1] > xs[k]; k--) {
					swap(xs[k - 1], xs[k]);
				}
			}
			j = i;
		}
		for (i = 0; i < nxs; i += 2) {
			line(xs[i], y, xs[i + 1], y);
		}
	}
}


void text(float x, float y, const char* str) {

	SDL_Surface* s = TTF_RenderText_Solid(font, str, strlen(str), fcol);
	SDL_Texture* t = SDL_CreateTextureFromSurface(renderer, s);
	float th, tw;
	SDL_GetTextureSize(t, &tw, &th);

	//kc?
	float h;
	if (botleft) h = sc(textsize);
	else h = sc(textsize / 4);

	SDL_FRect r = { x, y - h, tw, th };
	SDL_RenderTexture(renderer, t, NULL, &r);

	SDL_DestroyTexture(t);
	SDL_DestroySurface(s);
}

void gr_text(double fx, double fy, const char* str) {
	float x = scx(fx);
	float y = scy(fy);
	text(x, y, str);
}

SDL_Surface* backgr = NULL;

void gr_sys(unsigned short h) {

	if (h == 11) {	// clear
		grpen = 0;
		if (backgr) {
			SDL_Texture* t = SDL_CreateTextureFromSurface(renderer, backgr);
			SDL_RenderTexture(renderer, t, NULL, NULL);
			SDL_DestroyTexture(t);
		}
		else {
			SDL_SetRenderDrawColor(renderer, bcol.r, bcol.g, bcol.b, 255);
			SDL_RenderClear(renderer);
			SDL_SetRenderDrawColor(renderer, fcol.r, fcol.g, fcol.b, 255);
		}
	}
	else if (h == 2) {	// set_background
		if (backgr != NULL) SDL_DestroySurface(backgr);
		backgr = SDL_RenderReadPixels(renderer, NULL);
	}
	else if (h == 3) {	// set_foreground color
		gr_color(0, 0, 0);
	}
	else if (h == 4) {	// set_background color
		gr_color(bcol.r, bcol.g, bcol.b);
	}
	else if (h == 13) {
		grpen = 0;
	}
	else {
		fprintf(stderr, "** sys %d not handled\n", h);
	}
}

void evt_mouse(int id, double x, double y);
void evt_func(int id, const char* s);

static void handle_event(SDL_Event* evt) {
	switch (evt->type) {
		case SDL_EVENT_MOUSE_BUTTON_DOWN:
			evt_mouse(0, evt->button.x / FMX, inv(evt->button.y / FMY));
			break;
		case SDL_EVENT_MOUSE_BUTTON_UP:
			evt_mouse(1, evt->button.x / FMX, inv(evt->button.y / FMY));
			break;
		case SDL_EVENT_MOUSE_MOTION:
			evt_mouse(2, evt->motion.x / FMX, inv(evt->motion.y / FMY));
			break;
		case SDL_EVENT_KEY_UP:
		case SDL_EVENT_KEY_DOWN: {
			// printf("SDL_KEYDOWN: %s\n", SDL_GetKeyName(SDL_GetKeyFromScancode(evt->key.keysym.scancode)));
			const char* s = SDL_GetKeyName(SDL_GetKeyFromScancode(evt->key.scancode, SDL_GetModState(), true));
			char b[2];
			const char* kn = b;
			if (s[1] == 0) {
				b[0] = s[0];
				b[1] = 0;
				if  (!(SDL_GetModState() & SDL_KMOD_SHIFT)) b[0] += 'a' - 'A';
			}
			else {
				if (strcmp(s, "Right") == 0) kn = "ArrowRight";
				else if (strcmp(s, "Left") == 0) kn = "ArrowLeft";
				else if (strcmp(s, "Up") == 0) kn = "ArrowUp";
				else if (strcmp(s, "Down") == 0) kn = "ArrowDown";
				else if (strcmp(s, "Space") == 0) kn = " ";
			}
			if (evt->type == SDL_EVENT_KEY_DOWN) evt_func(2, kn);
			else  evt_func(3, kn);
			break;
		}
		case SDL_EVENT_USER:
			evt_func(1, 0);
			break;
		case SDL_EVENT_QUIT:
			exit(0);

		case SDL_EVENT_WINDOW_RESIZED:	{
			if (true)	{
//			if (evt>window.windowID == (SDL_GetWindowID(window)))	{
				FMX = evt->window.data1 / 100.0;
				FMY = evt->window.data2 / 100.0;
//				printf("f:%f\n", FMX, FMY);
			}
			break;
		}
	}
}

void gr_sleep(double sec) {
	SDL_Event evt;
	int msec = sec * 1000;

	if (renderer) {
		while (SDL_PollEvent(&evt)) handle_event(&evt);
		SDL_SetRenderTarget(renderer, NULL);
 		SDL_RenderTexture(renderer, display, NULL, NULL);
		SDL_RenderPresent(renderer);
		SDL_SetRenderTarget(renderer, display);
	}
	SDL_Delay(msec);
}


unsigned timer_id;

unsigned timer_func(void *userdata, unsigned id, unsigned interval) {
	
	SDL_Event ev;
	SDL_UserEvent uev;

	uev.type = SDL_EVENT_USER;
	uev.code = 0;

	ev.type = SDL_EVENT_USER;
	ev.user = uev;
	SDL_PushEvent(&ev);
	return 0;
}

void gr_timer(double s) {
	if (timer_id != 0) SDL_RemoveTimer(timer_id);
	if (s >= 0) {
		timer_id = SDL_AddTimer((unsigned)(1000.0 * s) , timer_func, NULL);
	}
}


void gr_event_loop(void) {

	if (!renderer) return;

	SDL_Event evt;

	if (do_animate) {
		SDL_SetRenderVSync(renderer, 1);
		while (true) {

			SDL_SetRenderTarget(renderer, NULL);
		 	SDL_RenderTexture(renderer, display, NULL, NULL);
			SDL_RenderPresent(renderer);
			SDL_SetRenderTarget(renderer, display);

			while (SDL_PollEvent(&evt)) handle_event(&evt);
			evt_func(0, 0);
		}
	}
	else {
		while (true) {
			SDL_SetRenderTarget(renderer, NULL);
		 	SDL_RenderTexture(renderer, display, NULL, NULL);
			SDL_RenderPresent(renderer);
			SDL_SetRenderTarget(renderer, display);

			SDL_WaitEvent(&evt);
			handle_event(&evt);
		}
	}
}

static double angle;
static double incr;
static int aud_attack;
static int smpl_cnt;

static void audio_cb(float *out, int len) {

	if (smpl_cnt <= 0) SDL_PauseAudioDevice(audio_dev);
	for (int i = 0; i < len; i += 1) {
		float h = sin(angle);
		if (aud_attack < 2048) {
			h *= aud_attack / 2048;
			aud_attack += 1;
		}
		else if (smpl_cnt < 2048) {
			h *= smpl_cnt / 2048;
		}
		out[i] = h;
		angle += incr;
		smpl_cnt -= 1;
	}
}
static void SDLCALL new_audio_cb(void *userdata, SDL_AudioStream *stream, int additional, int total) {
	if (additional > 0) {
		Uint8 *data = SDL_stack_alloc(Uint8, additional);
		if (data) {
			audio_cb((float*)data, additional / sizeof(float));
			SDL_PutAudioStreamData(stream, data, additional);
			SDL_stack_free(data);
		}
	}
}

void sound(double freq, double sec) {

	if (freq == 0 || sec == 0) {
		smpl_cnt = 2048;
		//SDL_PauseAudioDevice(audio_dev);
		return;
	}
	aud_attack = 0;
	incr = freq * 2 * M_PI / SMPL_RATE;
	smpl_cnt = sec * SMPL_RATE * 2;
	SDL_ResumeAudioDevice(audio_dev);
}


void gr_sound(double* val, int len) {
	if (len == 0) sound(0, 0);
	else sound(val[0], val[1] / 2);
//kc TODO
}

void gr_mouse_cursor(int id) {
}

void gr_stop(void) {
}

void gr_print(const char* s) {
	printf("%s\n", s);
}
void gr_write(const char* s) {
	printf("%s", s);
	fflush(stdout);
}
void gr_debline(int line, int mode) {
	printf("** LINE: %d **\n", line);
}
void gr_debout(const char* s) {}
char gr_input(char* buf) {

	char* p = fgets(buf, 65536, stdin);
	if (p != NULL) {
		int h = strlen(buf);
		if (h > 0 && buf[h - 1] == '\n') {
			h -= 1;
			buf[h] = 0;
		}
		return 0;
	}
	buf[0] = 0;
	return 1;
}
void gr_circseg(double x, double y, double rad, double a, double b) {
	printf("** gcircseg is not implemented\n");
}
void gr_exit(void) { exit(1); }
void gr_step(void) {}
void gr_info(int h) {}
void gr_key_sync(char* buf) {
	buf[0] = 0;
}

#ifdef RUN

void evt_mouse(int id, double x, double y) {}
void evt_func(int id, const char* s) {}
int sys_error;

int main(int argc, char* argv[]) {
	gr_init("SDL3-Test", 512 | 256 | 128);

	gr_color(0, 0, 0);

	gr_linewidth(0.5);
	gr_line(0, 0, 20, 90);

	gr_linewidth(0.2);
	gr_lineto(30, 90);

	gr_text(20, 20, "SDL3");

	gr_color(0, 0, 255);
	grpen = 0;
	gr_lineto(1, 1);
	gr_lineto(1, 99);
	gr_lineto(99, 99);
	gr_lineto(99, 1);
	gr_lineto(1, 1);

	gr_color(0, 255, 0);
	gr_line(10, 10, 90, 90);

	gr_linewidth(20);
	gr_line(30, 50, 30, 50);

	gr_linewidth(2);
	gr_line(10, 50, 50, 60);

	gr_color(255, 0, 0);
	double v[] = { 10, 50, 20, 0, 10, -15 };
  	gr_polygon(v, 4);

	sound(440, 0.2);

gr_sys(2);
gr_color(255, 255, 0);
gr_rect(0,0, 80,80);
gr_sleep(1);
gr_sys(11);

	gr_linewidth(0.5);
	gr_color(0, 0, 0);
	gr_line(20, 90, 20, 90);

	gr_color(128, 0, 0);
	gr_circle(50, 50, 3);

	gr_color(0, 129, 0);
	gr_rect(10, 10, 20, 10);
	gr_event_loop();
	return 0;
}
#endif


