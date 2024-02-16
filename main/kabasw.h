#include <unistd.h>

static void do_sleep(double sec) {
	sleep((int)sec);
	useconds_t us = (useconds_t)((sec - (int)sec)  * 1000000);
	usleep(us);
}
static void gr_sleep(double sec) {
	EM_ASM(update());
	do_sleep(sec);
}
static void gr_timer(double sec) {
	EM_ASM_({ setTimer($0)}, sec);
}
static void gr_info(int id) {
	EM_ASM_({ postMessage(['ide', 'info', $0]) }, id);
}
static void gr_debline(int l) {
	EM_ASM_({ postMessage(['ide', 'selline', $0]) }, l);
}
static void gr_debout(const char* s) {
	EM_ASM_({ postMessage(['ide', 'output', UTF8ToString($0)])}, s);
}
static void gr_print(const char* s) {
	EM_ASM_({ postMessage(['print', UTF8ToString($0) + '\n']) }, s);
	do_sleep(0.01);
}
static void gr_write(const char* s) {
	EM_ASM_({ postMessage(['print', UTF8ToString($0)]) }, s);
}
static void gr_color(int r, int g, int b) {
	EM_ASM_({ push([9, $0, $1, $2])}, r, g, b);
}
static void gr_translate(double x, double y) {
	EM_ASM_({ push([13, $0, $1])}, x, y);
}
static void gr_rotate(double w) {
	EM_ASM_({ push([14, $0])}, w);
}
static void gr_backcolor(int r, int g, int b) {
	EM_ASM_({ push([15, $0, $1, $2])}, r, g, b);
}
static byte grline;
static void gr_linewidth(double w) {
	EM_ASM_({ push([8, $0])}, w);
	grline = 0;
}
static void gr_mouse_cursor(ushort h) {
	EM_ASM_({ push([11, $0])}, h);
}
static void gr_exit(void) {
	EM_ASM(update(); postMessage(['exit']));
	sleep(60);
}
static void gr_sound(double* val, int len) {
	EM_ASM(list = []);
	for (int i = 0; i < len; i += 2) {
		EM_ASM_({
			list.push([$0, $1])
		}, val[i], val[i + 1]);
	}
	EM_ASM(postMessage(['sound', list]); list = []);
}
static void gr_step(void) {
	EM_ASM(step());
}
static char* input_str;
static char gr_input(char* buf) {
	*buf = 0;
	input_str = buf;
	EM_ASM(input());
	return input_str == NULL;
}

static double grx;
static double gry;
static int grbotleft;
static double grtxty;

static void gr_init(const char* s, int mask) {
	if (mask & 64) {
		EM_ASM_({ push([7, $0])}, 1);
	}
	EM_ASM_({ postMessage(['init', $0]) }, mask);
	grx = 0;
	gry = 100;
	grbotleft = 1;
	grtxty = 8 * 0.78;
	grline = 0;
}
static void gr_sys(ushort h) {
	if (h < 10) {
		if (h == 1) {
			// clear
			grline = 0;
		}
		EM_ASM_({ push([7, $0])}, h);
	}
	else if (h == 11) grbotleft = 1;
	else if (h == 12) grbotleft = 0;
}
static void gr_textsize(double h) {
	EM_ASM_({ push([10, $0])}, h);
	// all ascii chars are in the box?
	grtxty = h * 0.78;
}
static void gr_text(const char* s) {
	double h = gry;
	if (!grbotleft) h += grtxty;
	EM_ASM_({ push([6, $0, $1, UTF8ToString($2)])}, grx, h, s);
}
static void gr_move(double x, double y) {
	grx = x;
	if (grbotleft) gry = 100 - y;
	else gry = y;
	grline = 1;
}
static void gr_line(double x, double y) {
	if (grbotleft) y = 100 - y;
	if (grline) EM_ASM_({ push([2, $0, $1, $2, $3])}, grx, gry, x, y);
	else grline = 1;
	grx = x;
	gry = y;
}
static void gr_rect(double x, double y) {
	double h = gry;
	if (grbotleft) h -= y;
	EM_ASM_({ push([4, $0, $1, $2, $3])}, grx, h, x, y);
}
static void gr_circseg(double rad, double a, double b) {
	EM_ASM_({ push([16, $0, $1, $2, $3, $4])}, grx, gry, rad, a, b);
}
static void gr_circle(double x) {
	EM_ASM_({ push([3, $0, $1, $2])}, grx, gry, x);
}
static void gr_curve(double* val, int len) {
	EM_ASM(list = []);
	for (int i = 0; i < len - 1; i += 2) {
		double h;
		if (grbotleft) h = 100 - val[i + 1];
		else h = val[i + 1];
		EM_ASM_({
			list.push([$0, $1])
		}, val[i], h);
	}
	EM_ASM(push([12, list]));
}
static void gr_polygon(double* val, int len) {
	EM_ASM(list = []);
	for (int i = 0; i < len; i += 2) {
		double h;
		if (grbotleft) h = 100 - val[i + 1];
		else h = val[i + 1];
		EM_ASM_({
			list.push([$0, $1])
		}, val[i], h);
	}
	EM_ASM(push([5, list]));
}
