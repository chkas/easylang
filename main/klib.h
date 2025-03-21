/*	klib.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <stdarg.h>

static void pr(const char *fmt, ... ) {
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stdout, fmt, ap);
	fprintf(stdout, "\n");
    va_end(ap);
}

#ifdef _WIN32

#include <windows.h>
#include <malloc.h>
static char *strsep(char **str, const char *sep)
{
	char *s = *str, *end;
	if (!s) return NULL;
	end = s + strcspn(s, sep);
	if (*end) *end++ = 0;
	else end = 0;
	*str = end;
	return s;
}

#define M_PI 3.14159265358979323846

#else

#include <sys/time.h>

#endif

typedef unsigned short ushort;
typedef unsigned int uint;
typedef unsigned char byte;

static void (*out_of_memf)(void);

static void* _realloc(void* p, unsigned long sz) {

	void* pn = realloc(p, sz);
	if (pn == NULL) {
		if (out_of_memf) (*out_of_memf)();
		fprintf(stderr, "realloc(%lu) failed\n", sz);
		exit(1);
	}
	return pn;
}
// -----------------------------------------------------------------------

inline static double sys_time(void) {
#ifdef _WIN32
	return GetTickCount() / 1000.0;
#else
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (double)(tv.tv_sec + tv.tv_usec / 1000000.0);
#endif
}

// --------------------------------------------------------------------
struct str {
	union {
		struct {
			char* p;
			uint len;
			ushort spc;
		};
		char d[16];
	};
};
typedef struct str STR;

// #define IS_PTR 1
#define IS_PTR 127

inline static void str_init(struct str* s) {
	s->d[0] = 0;
	s->d[15] = 0;
}

// str_init_const(&s, "\0Hello world");

inline static void str_init_const(struct str* s, char* p) {
	uint len = strlen(p + 1);
	if (len > 15) {
		s->d[15] = IS_PTR;
		s->len = len;
		s->spc = 0;
		s->p = p;
	}
	else {
		memcpy(s->d, p + 1, len + 1);
		s->d[15] = 0;
	}
}

inline static void str_free(struct str* s) {

	if (s->d[15] == IS_PTR) {
		if (s->p[0] > 0) {
			s->p[0] -= 1;
			if (s->p[0] == 0) free(s->p);
		}
	}
	s->d[0] = 0;
	s->d[15] = 0;
}

inline static const char* str_ptr(struct str* s) {
	if (s->d[15] == 0) return s->d;
	else return s->p + 1;
}

inline static uint str_len(struct str* s) {
	if (s->d[15] == 0) return strlen(s->d);
	else return s->len;
}

inline static struct str str_str(struct str* s) {
	struct str r;
	if (s->d[15] == IS_PTR && s->p[0] != 0) {
		if ((byte)s->p[0] == 255) {
			r = *s;
			s->p[0] = (char)128;
			s->p = strdup(s->p);
			return r;
		}
		s->p[0] += 1;
	}
	r = *s;
	return r;
}

inline static void str_append_n(struct str* d, const char* s, uint ls) {
	const ushort spc_inc = 30;
	uint ld = str_len(d);

	if (ls + ld < 15 && d->d[15] == 0) {
		memcpy(d->d + ld, s, ls);
		*(d->d + ld + ls) = 0;
		return;
	}
	if (d->d[15] == IS_PTR) {
		uint spc;
		if  (d->p[0] != 1) {
			char* p = d->p;
			if (p[0] > 1) p[0] -= 1;
			spc = ls + ld + spc_inc;
			d->p = _realloc(NULL, spc);
			d->p[0] = 1;

			// strcpy(d->p + 1, p + 1);
			// todo test
			memcpy(d->p + 1, p + 1, ld);
		}
		else {
			spc = d->len + d->spc;
			if (ls + ld + 2 > spc) {
				spc = ls + ld + spc_inc;
				d->p = _realloc(d->p, spc);
			}
		}
		d->spc = spc - (ls + ld);
	}
	else {
		char* p = _realloc(NULL, ls + ld + spc_inc);
		strcpy(p + 1, d->d);
		p[0] = 1;
		d->p = p;
		d->spc = spc_inc;
		d->d[15] = IS_PTR;
	}
	memcpy(d->p + ld + 1, s, ls);
	*(d->p + ld + 1 + ls) = 0;
	d->len = ls + ld;
}

inline static void str_append(struct str* d, const char* s) {
	uint ls = strlen(s);
	str_append_n(d, s, ls);
}
/*
inline static int str_cmp(struct str* a, struct str* b) {
	const char* pa = str_ptr(a);
	const char* pb = str_ptr(b);
	if (pa == pb) return 0;
	return strcmp(pa, pb);
}
*/
inline static int str_cmp(struct str* a, struct str* b) {
	return strcmp(str_ptr(a), str_ptr(b));
}

inline static void str_append_c(struct str* s, char c) {
	char buf[2];
	buf[0] = c;
	buf[1] = 0;
	str_append(s, buf);
}

inline static void str_append_str(struct str* dest, struct str* src) {
	str_append_n(dest, str_ptr(src), str_len(src));
}

inline static struct str str(const char* p) {
	struct str r;
	str_init(&r);
	str_append(&r, p);
	return r;
}
/*
inline static struct str str_num(int d) {
	struct str r;
	str_init(&r);
	sprintf(r.d, "%d", d);
	return r;
}
*/
#if 0
inline static struct str str_numfx(double f, int sc, int spc) {
	char fmt[8];
	char buf[32];
	if (sc < 0) sc = 0;
	else if (sc > 20) sc = 20;
	if (spc < 0) spc = 0;
	else if (spc > 30) spc = 30;

	double fa = fabs(f);
	if (fa < 9007199254740992 &&  (double)(long long)f == f) {
		if (f == 0) f = 0;					// get rid off -0
		sprintf(fmt, "%%%d.20g", spc);
	}
	else if (fa <= 10e9 && fa >= 1e-9) sprintf(fmt, "%%%d.%df", spc, sc);
	else sprintf(fmt, "%%%d.%dg", spc, sc);
	struct str r;
	str_init(&r);
	sprintf(buf, fmt, f);
	str_append(&r, buf);
	return r;
}
#else
inline static struct str str_numfx(double f, int sc, int spc, int hex) {
	char fmt[8];
	char buf[32];
	if (sc < 0) sc = 0;
	else if (sc > 20) sc = 20;
	if (spc < 0) spc = 0;
	else if (spc > 30) spc = 30;

	double fa = fabs(f);
	if (fa < 9007199254740992 &&  (double)(long long)f == f) {
		if (hex) sprintf(fmt, "%%0%dllx", spc);
		else sprintf(fmt, "%%%dlld", spc);
		sprintf(buf, fmt, (long long)f);
	}
	else {
		if (hex) sprintf(fmt, "%%a");
		else if (fa <= 10e9 && fa >= 1e-9) sprintf(fmt, "%%%d.%df", spc, sc);
		else sprintf(fmt, "%%%d.%dg", spc, sc);
		sprintf(buf, fmt, f);
	}
	struct str r;
	str_init(&r);
	str_append(&r, buf);
	return r;
}
#endif
inline static struct str str_numf(double f, int hex) {
	return str_numfx(f, 2, 0, hex);
}

inline static struct str str_add(struct str* a, struct str* b) {

	struct str r;
	str_init(&r);
	str_append_str(&r, a);
	str_append_str(&r, b);
	return r;
}

inline static uint uchlen(byte lb) {
	if ((lb & 0x80) == 0) return 1;
	if ((lb & 0xe0) == 0xc0) return 2;
	if ((lb & 0xf0) == 0xe0) return 3;
	if ((lb & 0xf8) == 0xf0) return 4;
	return 5;
}

inline static int str_ulen(const char* p) {
	uint i = 0;
	uint ind = 0;
	while (i < strlen(p)) {
		i += uchlen(p[i]);
		ind++;
	}
	return ind;
}

inline static int str_upos(const char* p, int start, int nchars, int max) {
	int i = start;
	int ind = 0;
	while (i < max && ind < nchars) {
		i += uchlen(p[i]);
		ind++;
	}
	return i;
}


inline static struct str str_substr(struct str* s, int a, int l) {
	// utf8 safe, therefor slow
	//
	int sl = str_len(s);
	int ca = str_upos(str_ptr(s), 0, a, sl);
	int cb = str_upos(str_ptr(s), ca, l, sl);

	struct str r;
	str_init(&r);
	str_append_n(&r, str_ptr(s) + ca, cb - ca);

	return r;
}

/*
inline static struct str cstr_substr(struct str* s, int a, int l) {
	struct str r;
	str_init(&r);
	uint sl = str_len(s);
	if (a < 0) {
		a = sl + a;
		if (a < 0) a = 0;
	}
	if (a > sl) return r;
	if (a + l > sl || l < 0) {
		l = sl - a;
	}
	str_append_n(&r, str_ptr(s) + a, l);
	return r;
}
*/

/*
inline static void pr(char* format, ...) {
	char buf[128];
	va_list args;
	va_start(args, format);
	vsprintf(buf, format, args);
	va_end(args);
	fprintf(stderr, "%s\n", buf);
}
*/
