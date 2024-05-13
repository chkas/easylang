/*	kalib.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <sys/stat.h>
#include <stdio.h>

#define bool int
#define true 1
#define false 0
#define swap(a, b) { int _h = a; a = b; b = _h; }
#define min(a, b) ((a) < (b) ? (a) : (b))

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
	fprintf(stderr, "%s\n", s);
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
static int grline;

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
void gr_backcolor(int r, int g, int b) {
	bcol.r = r;
	bcol.g = g;
	bcol.b = b;
}

#define FREQ 32768
static void audio_cb(void*, Uint8*, int);
static SDL_AudioDeviceID dev;
static char do_animate;

void gr_init(const char* progname, int mask) {

	if (mask == 512) {
		// only print
		return;
	}
	bcol.r = 255;
	bcol.g = 255;
	bcol.b = 255;
	bcol.a = 255;
	fcol.a = 255;
	SDL_Init(0);
	if (mask & 64) {
		SDL_InitSubSystem(SDL_INIT_VIDEO);
		SDL_DisplayMode dm;
		SDL_GetCurrentDisplayMode(0, &dm);
		SZ = min(dm.w, dm.h);

		SZ = SZ * 9 / 10 / 100 * 100;
		FX = SZ / 100.0;
		FMX = FX;
		FMY = FX;

		window = SDL_CreateWindow(progname, 50, 50, SZ, SZ, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
		renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_PRESENTVSYNC|SDL_RENDERER_ACCELERATED);

		if (renderer == NULL) errx("Renderer NULL");

		SDL_SetRenderDrawBlendMode(renderer,SDL_BLENDMODE_BLEND);
		display = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, SZ, SZ);
		SDL_SetRenderTarget(renderer, display);

		SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
		SDL_RenderClear(renderer);

		gr_color(0, 0, 0);
		gr_linewidth(1);
	}
	if (mask & 128) {
		SDL_InitSubSystem(SDL_INIT_AUDIO);
		SDL_AudioSpec want, have;
		want.freq = FREQ;
		want.format = AUDIO_F32;
		want.channels = 1;
		want.samples = 2048;
		want.callback = audio_cb;
		want.userdata = NULL;

		dev = SDL_OpenAudioDevice(NULL, 0, &want, &have, SDL_AUDIO_ALLOW_FORMAT_CHANGE);
		if (dev == 0) {
			SDL_Log("Failed to open audio: %s", SDL_GetError());
		}
		if (have.format != want.format) { /* we let this one thing change. */
			SDL_Log("Audioformat: %d %d", want.format, have.format);
		}
		SDL_PauseAudioDevice(dev, 1);
	}
	if (mask & 256) {

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
	if (mask & 16) do_animate = 1;
	botleft = true;
	grline = 0;
	gx = 0;
	gy = FX * 100;
}

double inv(double y) {
	if (botleft) return 100 - y;
	return y;
}

void gr_move(double x, double y) {
	gx = FX * x;
	gy = FX * inv(y);
	grline = 1;
}

void gr_rect(double cx, double cy) {
	double h = (int)(FX * cy) + 1;
	double y;
	if (botleft) y = gy - h;
	else y = gy;
	SDL_Rect r = {.x = gx, .y = y, .w = (int)(FX * cx) + 1, .h = (int)(FX * cy) + 1};
	SDL_RenderFillRect(renderer, &r);
}

static void line(int x1, int y1, int x2, int y2) {
	SDL_RenderDrawLine(renderer, x1, y1, x2, y2);
}

static void circle(int x0, int y0, int lw) {

	if (lw < 6) {
		if (lw == 5) {
			SDL_RenderDrawPoint(renderer, x0, y0 - 2);
			SDL_RenderDrawLine(renderer, x0 - 1, y0 - 1, x0 + 1, y0 - 1);
			SDL_RenderDrawLine(renderer, x0 - 2, y0, x0 + 2, y0);
			SDL_RenderDrawLine(renderer, x0 - 1, y0 + 1, x0 + 1, y0 + 1);
			SDL_RenderDrawPoint(renderer, x0, y0 + 2);
		}
		else if (lw == 4) {
			SDL_RenderDrawLine(renderer, x0 - 1, y0 - 1, x0 + 1, y0 - 1);
			SDL_RenderDrawLine(renderer, x0 - 1, y0, x0 + 1, y0);
			SDL_RenderDrawLine(renderer, x0 - 1, y0 + 1, x0 + 1, y0 + 1);
		}
		else if (lw == 3) {
			SDL_RenderDrawPoint(renderer, x0, y0 - 1);
			SDL_RenderDrawLine(renderer, x0 - 1, y0, x0 + 1, y0);
			SDL_RenderDrawPoint(renderer, x0, y0 + 1);
		}
		else if (lw == 2) {
			SDL_RenderDrawLine(renderer, x0, y0, x0 + 1, y0);
			SDL_RenderDrawLine(renderer, x0, y0 + 1, x0 + 1, y0 + 1);
		}
		else {
			SDL_RenderDrawPoint(renderer, x0, y0);
		}
		return;
	}

	int rad = lw / 2;
	rad -= 1;
	int f = 1 - rad;
	int fx = 0;
	int fy = -2 * rad;
	int x = 0;
	int y = rad;

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

static void thline(int x1, int y1, int x2, int y2) {
	if (y1 == y2) {
		if (x1 > x2) swap(x1, x2);
		SDL_Rect r = {.x = x1, .y = y1 - linew2, .w = x2 - x1, .h = linew};
		SDL_RenderFillRect(renderer, &r);
	}
	else if (x1 == x2) {
		if (y1 > y2) swap(y1, y2);
		SDL_Rect r = {.x = x1 - linew2, .y = y1, .w = linew, .h = y2 - y1};
		SDL_RenderFillRect(renderer, &r);
	}
	else {
		bool steep = abs(y2 - y1) > abs(x2 - x1);
		if(steep) {
			swap(x1, y1);
			swap(x2, y2);
		}
		if(x1 > x2) {
			swap(x1, x2);
			swap(y1, y2);
		}
		int dx = x2 - x1;
		int dy = abs(y2 - y1);

		int error = dx / 2;
		int ystep = (y1 < y2) ? 1 : -1;

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

void gr_circle(double rad) {
	circle(gx, gy, (int)(FX * rad * 2 + 0.5));
}

void gr_line(double fx, double fy) {
	int x = fx * FX;
	int y = inv(fy) * FX;

	if (grline) {
		circle(gx, gy, linew);
		if (gx == x && gy == y) return;
		thline(gx, gy, x, y);
		circle(x, y, linew);
	}
	else grline = 1;
	gx = x;
	gy = y;
}

void gr_curve(double* val, int len) {
	fprintf(stderr, "curve not implemented yet");
}

void gr_translate(double x, double y) {
	fprintf(stderr, "translate not implemented yet");
}
void gr_rotate(double w) {
	fprintf(stderr, "rotate not implemented yet");
}

void gr_polygon(double* val, int len) {

	int i, j;
	int n = len / 2;
	if (n < 2) return;

	int nxs;
	int* vx = (int*)alloca(sizeof(int) * n);
	int* vy = (int*)alloca(sizeof(int) * n);

	for (i = 0;	i < n; i++) {
		vx[i] = (int)(FX * val[i * 2]);
		vy[i] = (int)(FX * inv(val[i * 2 + 1]));
	}
	int* xs = (int*)alloca(sizeof(int) * n);
	int y, k;
	int y0 = vy[0], y1 = y0;
	for (i = 1;	i < n; i++) {
		y = vy[i];
		if (y < y0) y0 = y;
		if (y > y1) y1 = y;
	}

	if (y0 < 0) y0 = 0;
	if (y1 >= 100 * FX) y1 = 100 * FX - 1;

	for (y = y0; y <= y1; y++) {
		nxs = 0;
		j = n - 1;
		for (i = 0; i < n; i++) {
			if ((vy[i] < y && y <= vy[j]) || (vy[j] < y && y <= vy[i])) {

				xs[nxs]= (int)rint(vx[i] + ((double)y - vy[i]) / ((double)vy[j] - vy[i]) * ((double)vx[j] - vx[i]));
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


void gr_sleep(double sec) {
	int msec = sec * 1000;
	SDL_SetRenderTarget(renderer, NULL);
 	SDL_RenderCopy(renderer, display, NULL, NULL);
	SDL_RenderPresent(renderer);
	SDL_Delay(msec);
	SDL_SetRenderTarget(renderer, display);
}

void gr_text(const char* str) {
	SDL_Surface* s = TTF_RenderUTF8_Solid(font, str, fcol);
	SDL_Texture* t = SDL_CreateTextureFromSurface(renderer, s);
	int th, tw;
	SDL_QueryTexture(t, NULL, NULL, &tw, &th);

	int h;
//	if (botleft) h = FX * textsize - FX * textsize / 24;
	if (botleft) h = FX * textsize;
//	else h = FX * textsize / 8;
	else h = FX * textsize / 4;

	SDL_Rect r = { gx, gy - h, tw, th };
	SDL_RenderCopy(renderer, t, NULL, &r);

	SDL_DestroyTexture(t);
	SDL_FreeSurface(s);
	grline = 0;
}

SDL_Surface* backgr = NULL;

void gr_sys(ushort h) {

	if (h == 1) {	// clear
		grline = 0;
		if (backgr) {
			SDL_Texture* t = SDL_CreateTextureFromSurface(renderer, backgr);
			SDL_RenderCopy(renderer, t, NULL, NULL);
			SDL_DestroyTexture(t);
		}
		else {
			SDL_SetRenderDrawColor(renderer, bcol.r, bcol.g, bcol.b, 255);
			SDL_RenderClear(renderer);
			SDL_SetRenderDrawColor(renderer, fcol.r, fcol.g, fcol.b, 255);
		}
	}
	else if (h == 2) {	// set_background
		if (backgr != NULL) SDL_FreeSurface(backgr);
		backgr = SDL_CreateRGBSurfaceWithFormat(0, SZ, SZ, 32, SDL_PIXELFORMAT_ARGB8888);
		if (backgr) {
			SDL_RenderReadPixels(renderer, NULL, SDL_PIXELFORMAT_ARGB8888, backgr->pixels, backgr->pitch);
		}
	}
	else if (h == 3) {	// set_foreground color
		gr_color(0, 0, 0);
	}
	else if (h == 4) {	// set_background color
		gr_color(bcol.r, bcol.g, bcol.b);
	}
	else if (h == 11) botleft = true;
	else if (h == 12) botleft = false;
	else {
		fprintf(stderr, "** sys %d not handled", h);
	}
}

void evt_mouse(int id, double x, double y);
void evt_func(int id, const char* s);

static void handle_event(SDL_Event* evt) {
	switch (evt->type) {
		case SDL_MOUSEBUTTONDOWN:
			evt_mouse(0, evt->button.x / FMX, inv(evt->button.y / FMY));
			break;
		case SDL_MOUSEBUTTONUP:
			evt_mouse(1, evt->button.x / FMX, inv(evt->button.y / FMY));
			break;
		case SDL_MOUSEMOTION:
			evt_mouse(2, evt->motion.x / FMX, inv(evt->motion.y / FMY));
			break;
		case SDL_KEYDOWN: {
			// printf("SDL_KEYDOWN: %s\n", SDL_GetKeyName(SDL_GetKeyFromScancode(evt->key.keysym.scancode)));
			const char* s = SDL_GetKeyName(SDL_GetKeyFromScancode(evt->key.keysym.scancode));
			if (s[1] == 0) {
				char b[2];
				b[0] = s[0];
				b[1] = 0;
				if  (!(SDL_GetModState() & KMOD_SHIFT)) b[0] += 'a' - 'A';
				evt_func(0, b);
			}
			else {
				if (strcmp(s, "Right") == 0) evt_func(0, "ArrowRight");
				else if (strcmp(s, "Left") == 0) evt_func(0, "ArrowLeft");
				else if (strcmp(s, "Up") == 0) evt_func(0, "ArrowUp");
				else if (strcmp(s, "Down") == 0) evt_func(0, "ArrowDown");
				else if (strcmp(s, "Space") == 0) evt_func(0, " ");
				else evt_func(0, s);
			}
			break;
		}
		case SDL_USEREVENT:
			evt_func(2, 0);
			break;
		case SDL_QUIT:
			exit(0);

		case SDL_WINDOWEVENT:	{
			if (true)	{
//			if (evt>window.windowID == (SDL_GetWindowID(window)))	{
				if (evt->window.event == SDL_WINDOWEVENT_RESIZED) {
					FMX = evt->window.data1 / 100.0;
					FMY = evt->window.data2 / 100.0;
//					printf("f:%f\n", FMX, FMY);
				}
			}
			break;
		}
	}
}

unsigned timer_id;

unsigned timer_func(unsigned interval, void *param) {
	
	SDL_Event ev;
	SDL_UserEvent uev;

	uev.type = SDL_USEREVENT;
	uev.code = 0;

	ev.type = SDL_USEREVENT;
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
		while (true) {
			SDL_SetRenderTarget(renderer, NULL);
		 	SDL_RenderCopy(renderer, display, NULL, NULL);
			SDL_RenderPresent(renderer);
			SDL_SetRenderTarget(renderer, display);

			while (SDL_PollEvent(&evt)) {
				handle_event(&evt);
			}
			evt_func(1, 0);
		}
	}
	else {
		while (true) {
			SDL_SetRenderTarget(renderer, NULL);
		 	SDL_RenderCopy(renderer, display, NULL, NULL);
			SDL_RenderPresent(renderer);
			SDL_SetRenderTarget(renderer, display);

			SDL_WaitEvent(&evt);
			handle_event(&evt);
		}
	}
}

static int cb_cnt;
static bool cb_first;
static bool is_beep = false;

static double new_freq;
static double new_sec;
static double angle;
static double incr;

static void audio_cb(void *userdata, Uint8 *stream0, int len0) {

	cb_cnt--;
	float *stream = (float*) stream0;
	int len = len0 / sizeof(float);
	int i = 0;

	while (i < len) {
		stream[i] = sin(angle);
		i++;
		angle += incr;
	}

	if (cb_first) {
		cb_first = false;
		i = 0;
		while (i < len) {
			stream[i] = stream[i] * i / len;
			i++;
		}
	}
	else if (cb_cnt <= 0) {
		i = 0;
		while (i < len) {
			stream[i] = stream[i] * (len - i) / len;
			i++;
		}
		SDL_PauseAudioDevice(dev, 1);

		is_beep = false;
		if (new_freq > 0) {
			incr = new_freq * 2 * M_PI / FREQ;
			cb_first = true;
			cb_cnt = new_sec * FREQ / 1024;
			new_freq = 0;
			SDL_PauseAudioDevice(dev, 0);
			is_beep = true;
		}
	}
}

void gr_beep(double freq, double sec) {

	if (is_beep) {
		cb_cnt = 0;
		new_freq = freq;
		new_sec = sec;
		return;
	}
	if (freq == 0 || sec == 0) return;

	incr = freq * 2 * M_PI / FREQ;
	cb_first = true;
	cb_cnt = sec * FREQ / 1024;
	is_beep = true;
	SDL_PauseAudioDevice(dev, 0);
}


void gr_sound(double* val, int len) {
	if (len == 0) gr_beep(0, 0);
	else gr_beep(val[0], val[1] / 2);
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
void gr_debline(int line) {
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
void gr_circseg(double rad, double a, double b) {
	printf("** gr_arc is not implemented\n");
}
void gr_exit(void) { exit(1); }
void gr_step(void) {}
void gr_info(int h) {}

#ifdef TEST

void evt_mouse(int id, double x, double y) {}
void evt_func(int id, const char* s) {}
int sys_error;

int main(int argc, char* argv[]) {

	gr_init("SDL-Test", 7);

	gr_color(0, 0, 0);

	gr_linewidth(0.5);
	gr_move(20, 90);
	gr_line(20, 90);

	gr_linewidth(0.2);
	gr_move(30, 90);
	gr_line(30, 90);

	gr_move(20, 20);
	gr_text("Hello");

	gr_color(0, 0, 255);
	gr_move(1, 1);
	gr_line(1, 99);
	gr_line(99, 99);
	gr_line(99, 1);
	gr_line(1, 1);

	gr_color(0, 255, 0);
	gr_move(10, 10);
	gr_line(90, 90);

	gr_linewidth(20);
	gr_move(30, 50);
	gr_line(30, 50);

	gr_linewidth(2);
	gr_move(10, 50);
	gr_line(50, 60);

	gr_color(255, 0, 0);
	gr_move(10, 50);
	double v[] = { 20, 0, 10, -15 };
  	gr_fill(v, 4);

	gr_beep(440, 1);

	gr_linewidth(0.5);
	gr_color(0, 0, 0);
	gr_move(20, 90);
	gr_line(20, 90);

	gr_event_loop();
	return 0;
}
#endif


