/*	kbasw.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

#include<unistd.h>
static void gr_sleep(double sec) {
	int h = EM_ASM_INT({ return sleep($0)}, sec);
	if (h == -1) usleep((uint)(sec * 1000000));
//	EM_ASM_({ sleep($0)}, sec);
}
static void gr_timer(double sec) {
	EM_ASM_({ setTimer($0)}, sec);
}
static void gr_info(int id) {
	EM_ASM_({ postMessage(['ide', 'info', $0]) }, id);
}
static void gr_debline(int l, int caret) {
	EM_ASM_({ postMessage(['ide', 'selline', $0, $1]) }, l, caret);
}
static void gr_debout(const char* s) {
	EM_ASM_({ postMessage(['ide', 'output', UTF8ToString($0)])}, s);
}
static void gr_print(const char* s) {
	EM_ASM_({ postMessage(['print', UTF8ToString($0) + '\n']) }, s);
	gr_sleep(0.005);
}
static void gr_write(const char* s) {
	EM_ASM_({ postMessage(['print', UTF8ToString($0)]) }, s);
}
static byte grline;
static void gr_color(int r, int g, int b) {
	EM_ASM_({ push([9, $0, $1, $2])}, r, g, b);
}
static void gr_backcolor(int r, int g, int b) {
	EM_ASM_({ push([15, $0, $1, $2])}, r, g, b);
}
static void gr_linewidth(double w) {
	EM_ASM_({ push([8, $0])}, w);
}
static void gr_mouse_cursor(ushort h) {
	EM_ASM_({ push([11, $0])}, h);
}
static void gr_exit(void) {
	EM_ASM(update(); postMessage(['exit']));
	gr_sleep(60);
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
static double grsz;
static double grx;
static double gry;
static char grbotleft;
static double grtxty;

static void gr_init(const char* s, int mask) {
	if (mask & 128) {
		EM_ASM_({ push([7, $0])}, 11);	// gclrear
	}
	EM_ASM_({ postMessage(['init', $0]) }, mask);
	grx = 0;
	gry = 100;
	grbotleft = 1;
	grsz = 100;
	if (sysconfig & 1) {
		gry = 0;
		grbotleft = 0;
	}
	grtxty = 8 * 0.78;
	grline = 0;
}
static void gr_sys(ushort h) {
	if (h >= 11 && h <= 13) {
		// clear, drawgrid, penup
		grline = 0;
	}
	if (h <= 12) EM_ASM_({ push([7, $0])}, h);
}
static void gr_translate(double x, double y) {
	if (grbotleft) y = -y;
	EM_ASM_({ push([13, $0, $1])}, x, y);
}
static void gr_rotate(double w) {
	EM_ASM_({ push([14, $0])}, w);
}
static void gr_scale(double sc) {
	EM_ASM_({ push([17, $0])}, sc);
	grsz /= sc;
	grtxty *= sc;
}
static void gr_textsize(double h) {
	EM_ASM_({ push([10, $0])}, h);
	// all ascii chars are in the box?
	//grtxty = h * 0.78;
	grtxty = h * 78 / grsz;
}
static void gr_text(const char* s) {
	double h = gry;
	if (!grbotleft) h += grtxty;
	EM_ASM_({ push([6, $0, $1, UTF8ToString($2)])}, grx, h, s);
}
static void gr_gtext(double x, double y, const char* s) {
	if (grbotleft) y = grsz - y;
	else y += grtxty;
	EM_ASM_({ push([6, $0, $1, UTF8ToString($2)])}, x, y, s);
}
static void gr_move(double x, double y) {
	grx = x;
	if (grbotleft) gry = grsz - y;
	else gry = y;
	grline = 1;
}
static void gr_line(double x, double y) {
	if (grbotleft) y = grsz - y;
	if (grline) EM_ASM_({ push([2, $0, $1, $2, $3])}, grx, gry, x, y);
	else grline = 1;
	grx = x;
	gry = y;
}
static void gr_rect(double w, double h) {
	double y = gry;
	if (grbotleft) y -= h;
	EM_ASM_({ push([4, $0, $1, $2, $3])}, grx, y, w, h);
}
/*
static void gr_circseg(double rad, double a, double b) {
	EM_ASM_({ push([16, $0, $1, $2, $3, $4])}, grx, gry, rad, a, b);
}
*/
static void gr_gcircseg(double x, double y, double rad, double a, double b) {
	if (grbotleft) y = grsz - y;
	EM_ASM_({ push([16, $0, $1, $2, $3, $4])}, x, y, rad, a, b);
}
static void gr_circle(double r) {
	EM_ASM_({ push([3, $0, $1, $2])}, grx, gry, r);
}
static void gr_gcircle(double x, double y, double r) {
	if (grbotleft) y = grsz - y;
	EM_ASM_({ push([3, $0, $1, $2])}, x, y, r);
}
static void gr_grect(double x, double y, double w, double h) {
	if (grbotleft) y = grsz - y - h;
	EM_ASM_({ push([4, $0, $1, $2, $3])}, x, y, w, h);
}
static void gr_gline(double x, double y, double x2, double y2) {
	if (grbotleft) {
		y = grsz - y;
		y2 = grsz - y2;
	}
	EM_ASM_({ push([2, $0, $1, $2, $3])}, x, y, x2, y2);
}
static void gr_curve(double* val, int len) {
	EM_ASM(list = []);
	for (int i = 0; i < len - 1; i += 2) {
		double h;
		if (grbotleft) h = grsz - val[i + 1];
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
		if (grbotleft) h = grsz - val[i + 1];
		else h = val[i + 1];
		EM_ASM_({
			list.push([$0, $1])
		}, val[i], h);
	}
	EM_ASM(push([5, list]));
}
