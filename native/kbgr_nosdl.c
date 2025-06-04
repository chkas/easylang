/*	kalib.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/
#include <stdio.h>

void gr_textsize(double sz) {}
void gr_linewidth(double w) {}
void gr_color(int r, int g, int b) {}
void gr_backcolor(int r, int g, int b) {}

void gr_init(const char* progname, int mask) {}
void gr_move(double x, double y) {}
void gr_rect(double x, double y) {}
void gr_circle(double rad) {}

void gr_line(double fx, double fy) {}
void gr_curve(double* val, int len) {}
void gr_translate(double x, double y) {}
void gr_rotate(double w) {}
void gr_scale(double w) {}
void gr_polygon(double* val, int len) {}


void gr_sleep(double sec) {
/*
	sleep((int)sec);
	useconds_t us = (useconds_t)((sec - (int)sec)  * 1000000);
	usleep(us);
*/
}

static void gr_text(const char* str) {}
static void gr_gtext(double x, double y, const char* str) {}
static void gr_gcircle(double x, double y, double r) {}
static void gr_grect(double x, double y, double w, double h) {}
static void gr_gline(double x, double y, double x2, double y2) {}
static void gr_gcircseg(double x, double y, double rad, double a, double b) {}

void gr_sys(unsigned short h) {}
void gr_timer(double s) {}
void gr_event_loop(void) {}
void gr_beep(double freq, double sec) {}
void gr_sound(double* val, int len) {}

void gr_mouse_cursor(int id) {}
void gr_stop(void) {}

void gr_print(const char* s) {
	printf("%s\n", s);
}
void gr_write(const char* s) {
	printf("%s", s);
	fflush(stdout);
}
void gr_debline(int line, int x) {
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

void gr_exit(void) { exit(1); }
void gr_step(void) {}
void gr_info(int h) {}

