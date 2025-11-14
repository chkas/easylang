/*	kfunc.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

#if defined(__EMSCRIPTEN__)

#include <emscripten.h>
#include "emscripten/em_math.h"

#include "kbasw.h"

#elif defined(__RUN__) || defined(__NOSDL__)

#include "../native/kbgr_nosdl.c"

#elif defined(__SDL__)

#include "../native/kbgr.c"

#endif

S struct {
	double mouse_x;
	double mouse_y;
	const char* key0;
	char key[16];
	short num_scale;
	short num_space;
	const char* args;
	ND* proc;
	char sys_error;
	ushort slow;
	uint input_data_pos;
	int randseed;
	ushort radians;
	ushort arrbase;
} rt;

S volatile int stop_flag;

// -------------------------------------------

S double* rt_nums;
S STR* rt_strs;
S ARR* rt_arrs;

S double* rtl_nums;
S STR* rtl_strs;
S ARR* rtl_arrs;

S double* gnum(short ind) {
	if (ind >= 0) return rtl_nums + ind;
	return rt_nums - ind - 1;
}
S STR* gstr(short ind) {
	if (ind >= 0) return rtl_strs + ind;
	return rt_strs - ind - 1;
}
S ARR* garr(short ind) {
	if (ind >= 0) return rtl_arrs + ind;
	return rt_arrs - ind - 1;
}

S void out_of_bounds(ND* nd);
S void out_of_mem(ND* nd);
S void free_rt();

// ----------------------------------------------------------------------

#define vf(nd) (*(nd)->vf)(nd)
#define numf(nd) (*(nd)->numf)(nd)
#define intf(nd) (*(nd)->intf)(nd)
#define strf(nd) (*(nd)->strf)(nd)
#define arrf(nd) (*(nd)->arrf)(nd)

// -------------------------------  for performance
//perf
S double op_add_varfl(ND* nd) {
	return rtl_nums[nd->v1] + (double)nd->cfl32;
}
S double op_add_varvar(ND* nd) {
	return rtl_nums[nd->v1] + rtl_nums[nd->v2];
}
S double op_sub_varvar(ND* nd) {
	return rtl_nums[nd->v1] - rtl_nums[nd->v2];
}

S void op_ass_var(ND* nd) {
	double* p = gnum(nd->v1);
	*p = rt_nums[nd->v2];
}
S void op_ass_lvar(ND* nd) {
	double* p = gnum(nd->v1);
	*p = rtl_nums[nd->v2];
}
S void op_ass_fl(ND* nd) {
	double* p = gnum(nd->v1);
	*p = (double)nd->cfl32;
}
S void op_assp_fl(ND* nd) {
	double* p = gnum(nd->v1);
	*p += (double)nd->cfl32;
}

S int arrind(ARR* arr, int ind, ND* nd) {
	int h = ind - arr->base;
	if (h < 0 || h >= arr->len) {
#if 0
		// handle negative indices
		h = arr->len + h + 1;
		if (h < 0 || h >= arr->len) {
			out_of_bounds(nd);
			return 0;
		}
#else
		out_of_bounds(nd);
		return 0;
#endif
	}
	return h;
}

S double op_vnumael_lvar(ND* nd) {
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, rtl_nums[nd->v2], nd);
	return *(arr->pnum + h);
}

//  int_funcs  --------------------------------------------------

S double op_error(ND* nd) {
	return rt.sys_error;
}
S double op_sys_time(ND* nd) {
	return sys_time();
}

S double randf(void) {
	double f;

#ifdef __EMSCRIPTEN__
	if (rt.randseed == -1) {
//		f = emscripten_random();  // is only float
		f = emscripten_math_random();
	}
	else f = ((double)rand() / 0x80000000);
#else
	if (rt.randseed == -1) {
		rt.randseed = time(0);
		srand(rt.randseed);
		rand();
	}
	f = ((double)rand() / 0x80000000);
#endif
	return f;
}
S double op_random(ND* nd) {
	long long range = (long long)numf(nd->le);
	if (range < 1) return randf();

	if (range <= 0x80000000) {
		long long max = (0x80000000 / range) * range;
		int h;
		do {
			h = randf() * 0x80000000;
		} while (h >= max);
		return h % range + rt.arrbase;
	}
	else return (long long)(randf() * range) + rt.arrbase;
}

S double op_numlog(ND* nd) {
	return intf(nd->le);
}
S double op_abs(ND* nd) {
	return fabs(numf(nd->le));
}
S double op_sign(ND* nd) {
	double h = numf(nd->le);
	if (h > 0) return 1;
	if (h < 0) return -1;
	return 0;
}
S double op_floor(ND* nd) {
	return floor(numf(nd->le));
}

S double op_strcode(ND* nd) {
	STR s = strf(nd->le);
	const char* utf8 = str_ptr(&s);
	int nb, cp;
	if (!(utf8[0] & 0x80)) {
		nb = 1;
		cp = utf8[0];
	}
	else if ((utf8[0] & 0xe0) == 0xc0) {
		nb = 2;
		cp = utf8[0] & 0x1f;
	}
	else if ((utf8[0] & 0xf0) == 0xe0) {
		nb = 3;
		cp = utf8[0] & 0x0f;
	}
	else if ((utf8[0] & 0xf8) == 0xf0) {
		nb = 4;
		cp = utf8[0] & 0x07;
	}
	else return -1;

	for (int i = 1; i < nb; i++) {
        cp = (cp << 6) | (utf8[i] & 0x3f);
    }
    return cp;
}

S double op_strlen(ND* nd) {
	STR s = strf(nd->le);
	int h = str_ulen(str_ptr(&s));
	str_free(&s);
	return h;
}

S double op_mouse_x(ND* nd) {
	return rt.mouse_x;
}
S double op_mouse_y(ND* nd) {
	return rt.mouse_y;
}
S double op_randomf(ND* nd) {
	return randf();
}

S double op_pi(ND* nd) {
	return M_PI;
}
S double op_sqrt(ND* nd) {
	return sqrt(numf(nd->le));
}
S double op_log10(ND* nd) {
	return log10(numf(nd->le));
}
S double op_sin(ND* nd) {
	double h = numf(nd->le);
	if (rt.radians) return sin(h);
	if (h >= 360 || h <= -360) h = fmod(h, 360);
	return sin(h / 180. * M_PI);

//	return sin(numf(nd->le) / 180. * M_PI);
// not supported in emscripten
// return __sinpi(numf(nd->le) / 180.);
}
S double op_cos(ND* nd) {
	double h = numf(nd->le);
	if (rt.radians) return cos(h);
	if (h >= 360 || h <= -360) h = fmod(h, 360);
	return cos(h / 180. * M_PI);
//	return cos(numf(nd->le) / 180. * M_PI);
}
S double op_tan(ND* nd) {
	double h = numf(nd->le);
	if (!rt.radians) h = h / 180. * M_PI;
	return tan(h);
}
S double op_asin(ND* nd) {
	double h = asin(numf(nd->le));
	if (rt.radians) return h;
	return  h * 180 / M_PI;
}
S double op_acos(ND* nd) {
	double h = acos(numf(nd->le));
	if (rt.radians) return h;
	return  h * 180 / M_PI;
}
S double op_atan(ND* nd) {
	double h = atan(numf(nd->le));
	if (rt.radians) return h;
	return  h * 180 / M_PI;
}
S double op_atan2(ND* nd) {
	double h = atan2(numf(nd->le), numf(nd->ri));
	if (rt.radians) return h;
	return  h * 180 / M_PI;
}
S double op_pow(ND* nd) {
	return pow(numf(nd->le), numf(nd->ri));
}

S double op_higher(ND* nd) {
	double a = numf(nd->le);
	double b = numf(nd->ri);
	return a > b ? a : b;
}
S double op_lower(ND* nd) {
	double a = numf(nd->le);
	double b = numf(nd->ri);
	return a < b ? a : b;
}

S double op_number(ND* nd) {
	STR s = strf(nd->le);
	char *p;
	const char *ps = str_ptr(&s);
	double d = strtod(ps, &p);
	rt.sys_error = 0;
	if (p == ps || *p != 0) {
		rt.sys_error = 1;

		if (p == ps) d = 0.0 / 0.0;
	}
	str_free(&s);
	return d;
}

S double op_strcompare(ND* nd) {
	STR s1 = strf(nd->le);
	STR s2 = strf(nd->ri);
	double h = str_cmp(&s1, &s2);
	str_free(&s1);
	str_free(&s2);
	return h;
}

S double op_vnumaelael(ND* nd) {
	ARR* arr = garr(nd->v1);
	ND* ndx = nd->ri;
	int h = arrind(arr, numf(ndx->ex), nd);
	arr = arr->parr + h;
	h = arrind(arr, numf(ndx->ex2), nd);
	return *(arr->pnum + h);
}

S double op_arrlen(ND* nd) {
	ARR* arr = garr(nd->v1);
	return arr->len;
}
S double op_arrarrael_len(ND* nd) {
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	arr = arr->parr + h;
	return arr->len;
}

S void free_arr_members(ARR* a, int i0) {
	if (a->typ == ARR_STR) {
		for (int i = i0; i < a->len; i++) {
			str_free(a->pstr + i);
		}
	}
	else if (a->typ == ARR_ARR) {
		for (int i = i0; i < a->len; i++) {
			free_arr_members(a->parr + i, 0);
			free((a->parr + i)->p);
		}
	}
}

S void free_arr(ARR* a) {
	free_arr_members(a, 0);
	free(a->p);
	a->p = NULL;
}

S void arrs_init(ARR* arrs, int n_arr) {
	memset(arrs, 0, n_arr * sizeof(ARR));
	for (int i = 0; i < n_arr; i++) {
		arrs[i].base = rt.arrbase;
	}
}

S void arr_len(ND* nd, unsigned int sz, int typ) {
	ND* ndx = nd + 1;
	ARR* arr = garr(nd->v1);
	arr->typ = typ;
    if (typ > ARR_ARR) {
		arr->typ = ARR_ARR;
		int h = arrind(arr, numf(ndx->ex), nd);
		arr = arr->parr + h;
		typ = typ - (ARR_AEL - ARR_NUM );
	}

	long h = (long)numf(nd->ri);
	if (h == arr->len) return;
	if (h < 0) {
		h = arr->len + h;
		if (h < 0) h = 0;
	}

	void* p;
	if (h > arr->len) {
		p = realloc(arr->p, h * sz);
		if (p == NULL) {
			out_of_mem(nd);
			return;
		}
		arr->p = p;
		arr->typ = typ;
		if (typ == ARR_ARR) {
			arrs_init(arr->parr + arr->len, h - arr->len);
		}
		else {
			memset((char*)arr->p + sz * arr->len, 0, (h - arr->len) * sz);
		}
	}
	else {
		free_arr_members(arr, h);
		if (h) {
			p = realloc(arr->p, h * sz);
			if (p == NULL) {
				out_of_mem(nd);
				return;
			}
		}
		else {
			free(arr->p);
			p = NULL;
		}
		arr->p = p;
	}
	arr->len = h;
}

S void op_numarr_len(ND* nd) {
	arr_len(nd, sizeof(double), ARR_NUM);
}
S void op_strarr_len(ND* nd) {
	arr_len(nd, sizeof(STR), ARR_STR);
}

S void op_arrarr_len(ND* nd) {
	arr_len(nd, sizeof(ARR), ARR_ARR);
}

S void op_arrnumarrel_len(ND* nd) {
	arr_len(nd, sizeof(double), ARR_AEL);
}

S void op_arrstrarrel_len(ND* nd) {
	arr_len(nd, sizeof(STR), ARR_AELSTR);
}
S void op_arrbase(ND* nd) {
	ARR* arr = garr(nd->v1);
	arr->base = 1;
	int h = (int)numf(nd->ri);
	if (h <= 127 && h >= -128) arr->base = (char)h;
}
S void op_arrbase2(ND* nd) {
	ND* ndx = nd + 1;
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(ndx->ex), nd);
	arr = arr->parr + h;
	arr->base = 1;
	h = (int)numf(nd->ri);
	if (h <= 127 && h >= -128) arr->base = (char)h;
}

// -------------------------------------------------------------

S ARR* arrael_append(ND* nd, int arrtyp, int sz) {
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	arr = arr->parr + h;
	arr->typ = arrtyp;
	arr->len += 1;
	void* p = realloc(arr->p, arr->len * sz);
	if (p == NULL) {
		arr->len -= 1;
		out_of_mem(nd);
		return NULL;
	}
	arr->p = p;
	return arr;
}

S void op_numarrael_append(ND* nd) {
	ND* ndx = nd + 1;
	double h = numf(ndx->ex);
	ARR* arr = arrael_append(nd, ARR_NUM, sizeof(double));
	*(arr->pnum + arr->len - 1) = h;
}

S void op_strarrael_append(ND* nd) {
	ND* ndx = nd + 1;
	STR s = strf(ndx->ex);
	ARR* arr = arrael_append(nd, ARR_STR, sizeof(STR));
	*(arr->pstr + arr->len - 1) = s;
}

// -------------------------------------------------------------

S ARR* arr_append(ND* nd, int arrtyp, int sz) {
	ARR* arr = garr(nd->v1);
	arr->typ = arrtyp;
	arr->len += 1;
	void* p = realloc(arr->p, arr->len * sz);
	if (p == NULL) {
		arr->len -= 1;
		out_of_mem(nd);
		return NULL;
	}
	arr->p = p;
	return arr;
}

S void op_numarr_append(ND* nd) {
	double h = numf(nd->ri);
	ARR* arr = arr_append(nd, ARR_NUM, sizeof(double));
	if (arr) *(arr->pnum + arr->len - 1) = h;
}

S void op_strarr_append(ND* nd) {
	STR s = strf(nd->ri);
	ARR* arr = arr_append(nd, ARR_STR, sizeof(STR));
	if (arr) *(arr->pstr + arr->len - 1) = s;
}

S void op_arrarr_append(ND* nd) {
	ARR h = arrf(nd->ri);
	ARR* arr = arr_append(nd, ARR_ARR, sizeof(ARR));
	*(arr->parr + arr->len - 1) = h;
}

S void op_arrarr_ass(ND* nd) {
	ARR a = arrf(nd->ri);
	ARR* arr = garr(nd->v1);
	free_arr(arr);
	*arr = a;
}

// ------------ num factor --------------------------

S double op_const_fl(ND* nd) {
	return nd->cfl;
}

S double op_negf(ND* nd) {
	return -numf(nd->le);
}
S double op_vnum(ND* nd) {
	return rt_nums[nd->v1];
}
S double op_lvnum(ND* nd) {
	return rtl_nums[nd->v1];
}

S double op_vnumael(ND* nd) {
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	return *(arr->pnum + h);
}

// -------------- expressions ------------------------------------


S double op_mult(ND* nd) {
	return numf(nd->le) * numf(nd->ri);
}
S double op_div(ND* nd) {
	return numf(nd->le) / numf(nd->ri);
}
S double op_divi(ND* nd) {
	return floor(numf(nd->le) / numf(nd->ri));
}
S double op_add(ND* nd) {
	return numf(nd->le) + numf(nd->ri);
}
S double op_sub(ND* nd) {
	return numf(nd->le) - numf(nd->ri);
}

S double op_mod(ND* nd) {
	double a = numf(nd->le);
	double b = numf(nd->ri);
	double r = fmod(a, b);
	if ((r < 0 && b > 0) || (b < 0 && r > 0)) {
		r += b;		// as in Julia, Python
	}
	return r;
}
S double op_mod1(ND* nd) {	// as in Julia
	double a = numf(nd->le) - 1;
	double b = numf(nd->ri);
	double r = fmod(a, b);
	if ((r < 0 && b > 0) || (b < 0 && r > 0)) {
		r += b;		// as in Julia, Python
	}
	return r + 1;
}
S double op_divi1(ND* nd) {	// as in Julia fld1
	double a = numf(nd->le) - 1;
	double b = numf(nd->ri);
	return floor(a / b) + 1;
}

// ------------------------------------


//#define ulong unsigned long long
#define llong long long
S double op_bitand(ND* nd) {
	llong a = (llong)numf(nd->le);
	llong b = (llong)numf(nd->ri);
	return a & b;
}
S double op_bitor(ND* nd) {
	llong a = (llong)numf(nd->le);
	llong b = (llong)numf(nd->ri);
	return a | b;
}
S double op_bitxor(ND* nd) {
	llong a = (llong)numf(nd->le);
	llong b = (llong)numf(nd->ri);
	return a ^ b;
}
S double op_bitnot(ND* nd) {
	llong a = (llong)numf(nd->le);
	return (~a) & 9007199254740991;
}
S double op_bitshift(ND* nd) {
	llong a = (llong)numf(nd->le);
	int b = numf(nd->ri);
	//if (b >= 0) return (a << b) & 9007199254740991;
	if (b >= 0) {
		if (a >= 0) return (a << b) & 9007199254740991;
		return a << b;
	}
	else return a >> (-b);
}

// ------------------------------------

S double time_start;

S STR op_lstr(ND* nd) {
	uint ind = nd->str;
	STR r;
	str_init_const(&r, cstrs_p + ind);
	return r;
}

S STR op_numstr(ND* nd) {
	return str_numfx(numf(nd->le), rt.num_scale, rt.num_space, sysconfig & 8);
}

S STR op_numarrstr(ND* nd) {
	STR str;
	str_init(&str);
	str_append(&str, "[ ");
	ARR arr = arrf(nd->le);
	for (int i = 0; i < arr.len; i++) {
		double f = arr.pnum[i];
		STR s = str_numfx(f, rt.num_scale, rt.num_space, sysconfig & 8);
		str_append(&str, str_ptr(&s));
		str_free(&s);
		str_append(&str, " ");
	}
	free(arr.pnum);
	str_append(&str, "]");
	return str;
}

S STR op_strarrstr(ND* nd) {
	STR str;
	str_init(&str);
	str_append(&str, "[ ");
	ARR arr = arrf(nd->le);
	for (int i = 0; i < arr.len; i++) {
		str_append(&str, "\"");
		const char* p = str_ptr(arr.pstr + i);
		str_append(&str, p);
		str_append(&str, "\" ");
	}
	for (int i = 0; i < arr.len; i++) {
		str_free(arr.pstr + i);
	}
	free(arr.pstr);
	str_append(&str, "]");
	return str;
}

S STR op_strjoin(ND* nd) {
	STR str;
	str_init(&str);

	ARR arr = arrf(nd->le);
	STR s = strf(nd->ri);
	int i;
	for (i = 0; i < arr.len - 1; i++) {
		str_append(&str, str_ptr(arr.pstr + i));
		str_free(arr.pstr + i);
		str_append(&str, str_ptr(&s));
	}
	if (arr.len > 0) {
		str_append(&str, str_ptr(arr.pstr + i));
		str_free(arr.pstr + i);
	}
	free(arr.pstr);
	str_free(&s);
	return str;
}
S void xnumarrarrstr(STR* str, ARR* a) {
	//str_append(str, "[\n");
	str_append(str, "[ ");
	for (int i = 0; i < a->len; i++) {
		//str_append(str, " [");
		str_append(str, "[");
		double* pf = (a->parr + i)->pnum;
		int len = (a->parr + i)->len;
		for (int j = 0; j < len; j++) {
			STR s = str_numfx(pf[j], rt.num_scale, rt.num_space, sysconfig & 8);
			str_append(str, " ");
			str_append(str, str_ptr(&s));
			str_free(&s);
		}
		//str_append(str, " ]\n");
		str_append(str, " ] ");
	}
	str_append(str, "]");
}

S STR op_numarrarrstr(ND* nd) {
	STR str;
	str_init(&str);
	ARR arr = arrf(nd->le);
	xnumarrarrstr(&str, &arr);
	return str;
}

S void xstrarrarrstr(STR* str, ARR* a) {
	str_append(str, "[ ");
	//str_append(str, "[\n");
	for (int i = 0; i < a->len; i++) {
		//str_append(str, " [");
		str_append(str, "[");
		STR* p = (a->parr + i)->pstr;
		int len = (a->parr + i)->len;
		for (int j = 0; j < len; j++) {
			str_append(str, " \"");
			str_append(str, str_ptr(&p[j]));
			str_append(str, "\"");
		}
		//str_append(str, " ]\n");
		str_append(str, " ] ");
	}
	str_append(str, "]");
}

S STR op_strarrarrstr(ND* nd) {
	STR str;
	str_init(&str);
	ARR* a = garr(nd->v1);
	xstrarrarrstr(&str, a);
	return str;
}

S STR op_vstr(ND* nd) {
	return str_str(rt_strs + nd->v1);
}
S STR op_lvstr(ND* nd) {
	return str_str(rtl_strs + nd->v1);
}

S STR op_vstrael(ND* nd) {
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	return str_str(arr->pstr + h);
}
S STR op_vstraelael(ND* nd) {
	ARR* arr = garr(nd->v1);
	ND* ndx = nd->ri;
	int h = arrind(arr, numf(ndx->ex), nd);
	arr = arr->parr + h;
	h = arrind(arr, numf(ndx->ex2), nd);
	return str_str(arr->pstr + h);
}

S STR op_substr(ND* nd) {
	ND* ndx = nd + 1;
	STR s = strf(nd->le);

	int a = (int)numf(nd->ri) - rt.arrbase;
	//if (a < 0) a = str_ulen(str_ptr(&s)) + a + 1;
	int l = (int)numf(ndx->ex);
	if (a < 0) {
		l += a;
		a = 0;
	}
	STR r = str_substr(&s, a, l);
	str_free(&s);
	return r;
}

S STR op_sysfunc(ND* nd) {
	STR s = strf(nd->le);
	STR r;
	str_init(&r);
	const char* p = str_ptr(&s);
	if (strcmp(p, "lang") == 0) {
#ifdef __EMSCRIPTEN__
		int h = EM_ASM_INT({
			return lang.charCodeAt(0) + 256 * lang.charCodeAt(1);
		});
		r.d[0] = h % 256;
		r.d[1] = h / 256;
		r.d[2] = 0;
#else
		strcpy(r.d, "en");
#endif
	}
	else if (strcmp(p, "creator") == 0) {
		str_init_const(&r, "\0christof.kaser@gmail.com");
	}
	else if (strcmp(p, "1") == 0) {
		double h = sys_time() - time_start;
		if (h >= 0 && h < 10e11) sprintf(r.d, "%.2f", h);
	}
	else if (strcmp(p, "argc") == 0) {
		int i = 0;
		p = rt.args;
		if (*p != 0) {
			i = 1;
			while (1) {
				p = strchr(p, '&');
				if (p == NULL) break;
				p += 1;
				i += 1;
			}
		}
		sprintf(r.d, "%d", i);
	}
	else if (strncmp(p, "arg:", 4) == 0) {
		int h = atoi(p + 4) - 1;
		p = rt.args;
		const char* p0 = p;

		int i = 0;
		while (1) {
			p0 = p;
			p = strchr(p, '&');
			if (i == h) {
				if (p == NULL) h = strlen(p0);
				else h = p - p0;
				break;
			}
			if (p == NULL) {
				h = 0;
				break;
			}
			p += 1;
			i += 1;
		}
		str_append_n(&r, p0, h);
	}
	str_free(&s);
	return r;
}

S STR op_time_str(ND* nd) {
	STR str;
	char buf[20];
	str_init(&str);
	time_t v =  (long long)numf(nd->le);
	struct tm* tinfo = localtime(&v);
	strftime(buf, 20, "%Y-%m-%d %H:%M:%S", tinfo);
	str_append(&str, buf);
	return str;
}

S STR op_strchar(ND* nd) {
	STR str;
	str_init(&str);

	int code = (int)numf(nd->le);

	if (code <= 0x7f) {
		str.d[0] = code;
		str.d[1] = 0;
	}
	else if (code <= 0x7ff) {
		str.d[0] = 0xC0 | (code >> 6);
		str.d[1] = 0x80 | (code & 0x3f);
		str.d[2] = 0;
	}
	else if (code <= 0xffff) {
		str.d[0] = 0xe0 | (code >> 12);
		str.d[1] = 0x80 | ((code >> 6) & 0x3f);
		str.d[2] = 0x80 | (code & 0x3f);
		str.d[3] = 0;
	}
	else if (code <= 0x10ffff) {
		str.d[0] = 0xf0 | (code >> 18);
		str.d[1] = 0x80 | ((code >> 12) & 0x3f);
		str.d[2] = 0x80 | ((code >> 6) & 0x3f);
		str.d[3] = 0x80 | (code & 0x3f);
		str.d[4] = 0;
	}
	return str;
}

S STR op_keyb_key(ND* nd) {
	if (rt.key0) return str(rt.key0);
	return str(rt.key);
}

S STR op_stradd(ND* nd) {
	STR s1 = strf(nd->le);
	STR s2 = strf(nd->ri);
	STR r = str_add(&s1, &s2);
	str_free(&s1);
	str_free(&s2);
	return r;
}

// ------------------- log expr ---------------


S int op_eqf(ND* nd) {
	return numf(nd->le) == numf(nd->ri);
}
S int op_neqf(ND* nd) {
	return numf(nd->le) != numf(nd->ri);
}
S int op_lef(ND* nd) {
	return numf(nd->le) <= numf(nd->ri);
}
S int op_ltf(ND* nd) {
	return numf(nd->le) < numf(nd->ri);
}
S int op_gef(ND* nd) {
	return numf(nd->le) >= numf(nd->ri);
}
S int op_gtf(ND* nd) {
	return numf(nd->le) > numf(nd->ri);
}

S int op_ltx(ND* nd) {
	return rtl_nums[nd->v1] < (double)nd->cfl32;
}
S int op_lex(ND* nd) {
	return rtl_nums[nd->v1] <= (double)nd->cfl32;
}
S int op_gtx(ND* nd) {
	return rtl_nums[nd->v1] > (double)nd->cfl32;
}
S int op_gex(ND* nd) {
	return rtl_nums[nd->v1] >= (double)nd->cfl32;
}
S int op_eqx(ND* nd) {
	return rtl_nums[nd->v1] == (double)nd->cfl32;
}
S int op_neqx(ND* nd) {
	return rtl_nums[nd->v1] != (double)nd->cfl32;
}



S int op_eqs(ND* nd) {
	return op_strcompare(nd) == 0;
}
S int op_neqs(ND* nd) {
	return op_strcompare(nd) != 0;
}

S int op_and(ND* nd) {
	return intf(nd->le) && intf(nd->ri);
}
S int op_or(ND* nd) {
	return intf(nd->le) || intf(nd->ri);
}
S int op_not(ND* nd) {
	return !intf(nd->le);
}

S int op_eqarr(ND* nd) {
	ARR a1 = arrf(nd->le);
	ARR a2 = arrf(nd->ri);
	int h = -1;
	if (a1.len == a2.len) {
		h = 0;
		while (h < a1.len) {
			if (a1.pnum[h] != a2.pnum[h]) break;
			h += 1;
		}
	}
	free(a1.pnum);
	free(a2.pnum);
	return h == a1.len;
}
S int op_neqarr(ND* nd) {
	return !op_eqarr(nd);
}

// ---------------------- statements -------------------------

S void op_nop(ND* nd) {
}
S void op_flass(ND* nd) {
	double* p = gnum(nd->v1);
	*p = numf(nd->ri);
}
S void op_flassp(ND* nd) {
	double* p = gnum(nd->v1);
	*p += numf(nd->ri);
}
S void op_flassm(ND* nd) {
	double* p = gnum(nd->v1);
	*p -= numf(nd->ri);
}
S void op_flasst(ND* nd) {
	double* p = gnum(nd->v1);
	*p *= numf(nd->ri);
}
S void op_flassd(ND* nd) {
	double* p = gnum(nd->v1);
	*p /= numf(nd->ri);
}

S void op_strass(ND* nd) {
	STR s = strf(nd->ri);
	STR* ps = gstr(nd->v1);
	str_free(ps);
	*ps = s;
}

S void op_strassp(ND* nd) {
	STR* ps = gstr(nd->v1);
	STR s = strf(nd->ri);
	str_append_str(ps, &s);
	str_free(&s);
}

S void op_flael_ass(ND* nd) {
	ND* ndx = nd + 1;
	double n = numf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	*(arr->pnum + h) = n;
}

S void op_flael_assp(ND* nd) {
	ND* ndx = nd + 1;
	double n = numf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	*(arr->pnum + h) += n;
}

S void op_flael_assm(ND* nd) {
	ND* ndx = nd + 1;
	double n = numf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	*(arr->pnum + h) -= n;
}

S void op_flael_asst(ND* nd) {
	ND* ndx = nd + 1;
	double n = numf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	*(arr->pnum + h) *= n;
}

S void op_flael_assd(ND* nd) {
	ND* ndx = nd + 1;
	double n = numf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	*(arr->pnum + h) /= n;
}

S void op_strael_ass(ND* nd) {
	ND* ndx = nd + 1;
	STR s = strf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	str_free(arr->pstr + h);
	*(arr->pstr + h) = s;
}

S void op_strael_assp(ND* nd) {
	ND* ndx = nd + 1;
	STR s = strf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	str_append_str(arr->pstr + h, &s);
	str_free(&s);
}

S void exec_sequ(ND* nd) {
	while (nd && !stop_flag) {
		(*(nd->vf))(nd);
		nd = nd->next;
	}
}

S void op_while(ND* nd) {
	while (intf(nd->le)) {
		exec_sequ(nd->ri);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}
}

S void op_repeat(ND* nd) {
	ND* ndx = nd + 1;
	while (1) {
		exec_sequ(nd->ri);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		if (intf(nd->le)) break;
		exec_sequ(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}
}
S void op_for(ND* nd) {
	ND* ndx = nd + 1;
	double to = numf(nd->ri);
	double* pfro = gnum(nd->v1);
	*pfro = numf(ndx->ex2);
	while (*pfro <= to) {
		exec_sequ(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pfro += 1;
	}
}

S void op_fordown(ND* nd) {
	ND* ndx = nd + 1;
	double to = numf(nd->ri);
	double* pfro = gnum(nd->v1);
	*pfro = numf(ndx->ex2);
	while (*pfro >= to) {
		exec_sequ(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pfro -= 1;
	}
}
S void op_for_range(ND* nd) {
	ND* ndx = nd + 1;
	double to = numf(nd->ri);
	double* pfro = gnum(nd->v1);
	*pfro = 0;
	while (*pfro < to) {
		exec_sequ(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pfro += 1;
	}
}

S void op_for_to(ND* nd) {
	ND* ndx = nd + 1;
	double to = numf(nd->ri);
	double* pfro = gnum(nd->v1);
	*pfro = 1;
	while (*pfro <= to) {
		exec_sequ(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pfro += 1;
	}
}

S void op_forstep(ND* nd) {
	ND* ndx = nd + 1;
	double to = numf(nd->ri);
	double* pfro = gnum(nd->v1);
	*pfro = numf(ndx->ex2);
	double step = numf(ndx->ex3);

	while (1) {
		if (step > 0 && (*pfro > to)) break;
		if (step < 0 && (*pfro < to)) break;
		exec_sequ(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pfro += step;
	}
}
S void op_for_in(ND* nd) {
	ND* ndx = nd + 1;
	double* pnum = gnum(nd->v1);
	ARR arr = arrf(nd->ri);
	int ind = 0;
	double old = *pnum;
	while (ind < arr.len) {
		*pnum = arr.pnum[ind];
		exec_sequ(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		ind += 1;
	}
	if (ind == arr.len) *pnum = old;
	free(arr.pnum);
}

S void op_break(ND* nd) {
	stop_flag = nd->v1;
}

S void op_if(ND* nd) {
	if (intf(nd->le)) {
		exec_sequ(nd->ri);
	}
}
S void op_if_else(ND* nd) {
	ND* ndx = nd->ri;
	if (intf(nd->le)) {
		exec_sequ(ndx->ex);
	}
	else {
		exec_sequ(ndx->ex2);
	}
}

S void op_callsubr(ND* nd) {
	exec_sequ(nd->le->ex);
	stop_flag = 0;
}

S void op_print(ND* nd);

// -------------------------------------------------------

S void op_swapnum(ND* nd) {
	double* p1 = gnum(nd->v1);
	double* p2 = gnum(nd->v2);
	double tmp = *p1;
	*p1 = *p2;
	*p2 = tmp;
}
S void op_swapnumael(ND* nd) {
	ND* ndx = nd + 1;
	ARR* arr = garr(nd->v1);
	ARR* arr2 = garr(ndx->vx2);
	int h1 = arrind(arr, numf(nd->ri), nd);
	int h2 = arrind(arr2, numf(ndx->ex), nd);
	double tmp = *(arr->pnum + h1);
	*(arr->pnum + h1) = *(arr2->pnum + h2);
	*(arr2->pnum + h2) = tmp;
}

S void op_swapnumaelael(ND* nd) {
	ND* ndx = nd + 1;
	ARR* arr1 = garr(nd->v1);
	ARR* arr2 = garr(nd->v1a);
	int h1 = arrind(arr1, numf(nd->ri), nd);
	arr1 = arr1->parr + h1;
	h1 = arrind(arr1, numf(ndx->ex), nd);
	int h2 = arrind(arr2, numf(ndx->ex2), nd);
	arr2 = arr2->parr + h2;
	h2 = arrind(arr2, numf(ndx->ex3), nd);
	double tmp = *(arr1->pnum + h1);
	*(arr1->pnum + h1) = *(arr2->pnum + h2);
	*(arr2->pnum + h2) = tmp;
}

S void op_swapstr(ND* nd) {
	STR* p1 = gstr(nd->v1);
	STR* p2 = gstr(nd->v2);
	STR h = *p1;
	*p1 = *p2;
	*p2 = h;
}

S void op_swapstrael(ND* nd) {
	ND* ndx = nd + 1;
	ARR* arr = garr(nd->v1);
	ARR* arr2 = garr(ndx->vx2);
	int h1 = arrind(arr, numf(nd->ri), nd);
	int h2 = arrind(arr2, numf(ndx->ex), nd);
	STR h = *(arr->pstr + h1);
	*(arr->pstr + h1) = *(arr2->pstr + h2);
	*(arr2->pstr + h2) = h;
}

S void op_swaparr(ND* nd) {
	ARR* a1 = garr(nd->v1);
	ARR* a2 = garr(nd->v2);
	ARR h = *a1;
	*a1 = *a2;
	*a2 = h;
}

S void op_swaparrael(ND* nd) {
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	ARR* a1 = arr->parr + h;
	ND* ndx = nd + 1;
	ARR* a2 = garr(ndx->vx);
	ARR tmp = *a1;
	*a1 = *a2;
	*a2 = tmp;
}

S void op_swaparraelx(ND* nd) {
	ND* ndx = nd + 1;
	ARR* arr = garr(nd->v1);
	ARR* arr2 = garr(ndx->vx2);
	int h = arrind(arr, numf(nd->ri), nd);
	ARR* a1 = arr->parr + h;
	h = arrind(arr2, numf(ndx->ex), nd);
	ARR* a2 = arr2->parr + h;
	ARR tmp = *a1;
	*a1 = *a2;
	*a2 = tmp;
}

// -------------------------------------------------------
S ARR o_arrx(ND* nd, int typ, int sz) {
	ARR* arr = garr(nd->v1);

	ARR res;
	if (typ >= ARR_AEL) {
		typ -= 3;
		int h = arrind(arr, numf(nd->ri), nd);
		arr = arr->parr + h;
	}

	res.len = arr->len;
	res.p = realloc(NULL, res.len * sz);
	res.typ = typ;
	res.base = arr->base;
	if (res.p == NULL) {
		out_of_mem(nd);
		res.len = 0;
	}
	for (int i = 0; i < res.len; i++) {
		if (typ == ARR_NUM) res.pnum[i] = arr->pnum[i];
		else res.pstr[i] = str_str(arr->pstr + i);
	}
	return res;
}

S ARR op_vnumarr(ND* nd) {
	return o_arrx(nd, ARR_NUM, sizeof(double));
}

S ARR op_vnumarrael(ND* nd) {
	return o_arrx(nd, ARR_AEL, sizeof(double));
}

S ARR op_vstrarr(ND* nd) {
	return o_arrx(nd, ARR_STR, sizeof(STR));
}

S ARR op_vstrarrael(ND* nd) {
	return o_arrx(nd, ARR_AELSTR, sizeof(STR));
}

S ARR op_varrarr(ND* nd) {
	ARR* arr = garr(nd->v1);
	ARR res;
	res.len = arr->len;
	res.typ = ARR_ARR;
	res.base = arr->base;
	res.p = realloc(NULL, res.len * sizeof(ARR));
	if (res.p == NULL) {
		out_of_mem(nd);
		res.len = 0;
	}
	for (int i = 0; i < res.len; i++) {
		ARR* a = arr->parr + i;
		ARR r;
		r.len = a->len;
		r.typ = a->typ;
		r.base = a->base;
		if (r.typ == ARR_STR) {
			r.p = realloc(NULL, r.len * sizeof(STR));
		}
		else {
			r.p = realloc(NULL, r.len * sizeof(double));
		}
		if (r.p == NULL) {
			out_of_mem(nd);
			r.len = 0;
		}
		for (int j = 0; j < r.len; j++) {
			if (r.typ == ARR_NUM) r.pnum[j] = a->pnum[j];
			else r.pstr[j] = str_str(a->pstr + j);
		}
		res.parr[i] = r;
	}
	return res;
}

S ARR o_arr_init(ND* nd0, int typ, int sz) {
	ARR res;
	res.len = 0;
	res.typ = typ;
	res.base = rt.arrbase;
	ND* nd = nd0->le;
	while (nd) {
		res.len += 1;
		nd = nd->next;
	}
	res.p = realloc(NULL, res.len * sz);
	if (res.p == NULL) {
		out_of_mem(nd);
		res.len = 0;
		goto exit;
	}
	int i = 0;
	nd = nd0->le;
	while (nd) {
		if (typ == ARR_NUM) res.pnum[i] = numf(nd);
		else if (typ == ARR_STR) res.pstr[i] = strf(nd);
		else res.parr[i] = arrf(nd);
		i += 1;
		nd = nd->next;
	}
	exit:
	return res;
}

S ARR op_numarr_init(ND* nd) {
	return o_arr_init(nd, ARR_NUM, sizeof(double));
}
S ARR op_strarr_init(ND* nd) {
	return o_arr_init(nd, ARR_STR, sizeof(STR));
}
S ARR op_arrarr_init(ND* nd) {
	return o_arr_init(nd, ARR_ARR, sizeof(ARR));
}

//kc
S ARR op_numstrarr(ND* nd) {
	ARR arr = arrf(nd->le);
	ARR res;
	res.typ = ARR_STR;
	res.base = arr.base;
	res.len = arr.len;
	res.pstr = realloc(NULL, arr.len * sizeof(STR));
	if (res.pstr == NULL) {
		res.len = 0;
		return res;
	}
	for (int i = 0; i < arr.len; i++) {
		double f = arr.pnum[i];
		res.pstr[i] = str_numfx(f, rt.num_scale, rt.num_space, sysconfig & 8);
	}
	free(arr.pnum);
	return res;
}
S double op_strpos(ND* nd) {

	STR s1 = strf(nd->le);
	STR s2 = strf(nd->ri);
	int s2len = str_len(&s2);
	const char* p = str_ptr(&s1);
	const char* p2 = str_ptr(&s2);

	int i = 0;
	int ind = 0;
	while (p[i]) {
		if (strncmp(p + i, p2, s2len) == 0) {
			break;
		}
		i += uchlen(p[i]);
		ind += 1;
	}
	if (p[i] == 0) ind = -1;
	str_free(&s1);
	str_free(&s2);
	return ind + rt.arrbase;
}

S ARR op_strchars(ND* nd) {
	STR s = strf(nd->le);
	const char* p = str_ptr(&s);

	ARR res;
	res.len = str_ulen(p);
	res.typ = ARR_STR;
	res.base = rt.arrbase;
	res.p = realloc(NULL, res.len * sizeof(STR));
	if (res.p == NULL) {
		out_of_mem(nd);
		res.len = 0;
		goto exit;
	}

	int ind = 0;
	int i = 0;
	int l;
	while (ind < res.len) {
		l = uchlen(p[i]);
		str_init(res.pstr + ind);

		int h = 0;
		while (h < l) {
			res.pstr[ind].d[h] = p[i + h];
			h++;
		}
		res.pstr[ind].d[h] = 0;
		i += l;
		ind++;
	}
	exit:
	str_free(&s);
	return res;
}

S int arrstrapp(ARR* parr, char* str) {
	parr->len += 1;
	STR* p = realloc(parr->p, parr->len * sizeof(STR));
	if (p == NULL) {
		parr->len = 0;
		free(parr->p);
		return 0;
	}
	parr->pstr = p;
//	if (parr->p == NULL) return 1;
	str_init(parr->pstr + parr->len - 1);
	str_append(parr->pstr + parr->len - 1, str);
	return 1;
}

S ARR op_strtok(ND* nd) {
	STR s1 = strf(nd->le);
	STR s2 = strf(nd->ri);
	const char* s2p = str_ptr(&s2);

	ARR res;
	res.len = 0;
	res.typ = ARR_STR;
	res.base = rt.arrbase;
	res.p = NULL;
	char* dup = strdup(str_ptr(&s1));
	if (dup == NULL) {
		out_of_mem(nd);
		goto exit;
	}
	char* tok = strtok(dup, s2p);
	while (tok) {
		if (arrstrapp(&res, tok) == 0) goto exit;
		tok = strtok(NULL, s2p);
	}
	exit:
	free(dup);
	str_free(&s1);
	str_free(&s2);
	return res;
}

S ARR op_strsplit(ND* nd) {
	STR s2 = strf(nd->ri);
	const char* s2p = str_ptr(&s2);
	if (*s2p == 0) {
		str_free(&s2);
		return op_strchars(nd);
	}
	STR s1 = strf(nd->le);
	ARR res;
	res.typ = ARR_STR;
	res.base = rt.arrbase;
	res.p = NULL;
	res.len = 0;
	const char* s1p = str_ptr(&s1);
	if (*s1p == 0) goto exit; // empty array for strsplit "" ..
	char* dup = strdup(s1p);
	if (dup == NULL) {
		out_of_mem(nd);
		goto exit;
	}
	char* str = dup;
	while (1) {
		char* tk = strstr(str, s2p);
		if (tk != NULL) *tk = 0;
		if (arrstrapp(&res, str) == 0) goto exit;
		if (tk == NULL) break;
		str = tk + strlen(s2p);
	}
	free(dup);
	exit:
	str_free(&s1);
	str_free(&s2);
	return res;
}

S void op_strarr_ass(ND* nd) {
	ARR a = arrf(nd->ri);
	ARR* arr = garr(nd->v1);
	if (arr->p != NULL) {
		for (int i = 0; i < arr->len; i++) {
			str_free(&arr->pstr[i]);
		}
		free(arr->p);
	}
	*arr = a;
}

// -------------------------------------------------------------------------------------

S STR op_input(ND* nd) {
	char buf[65536];
	if (input_data == NULL) {
		rt.sys_error = gr_input(buf);
	}
	else {
		if (rt.input_data_pos < input_data_size) {
			rt.sys_error = 0;
			strcpy(buf, input_data + rt.input_data_pos);
			rt.input_data_pos += strlen(input_data + rt.input_data_pos) + 1;
		}
		else {
			rt.sys_error = 1;
			buf[0] = 0;
		}
	}
	return str(buf);
}

S void op_print(ND* nd) {
	STR s = strf(nd->le);
	gr_print(str_ptr(&s));
	str_free(&s);
}

S void op_write(ND* nd) {
	STR s = strf(nd->le);
	gr_write(str_ptr(&s));
	str_free(&s);
}

S void op_sys(ND* nd) {
//	if (nd->v1 <= 10) {
	gr_sys(nd->v1);
//	}
}

//------------------------------------------------------------------

S void op_sleep(ND* nd) {
	rt.key[0] = 0;
	rt.mouse_x = -1;
	rt.mouse_y = -1;
	gr_sleep(numf(nd->le));
}
S void op_timer(ND* nd) {
	gr_timer(numf(nd->le));
}
S void op_linewidth(ND* nd) {
	gr_linewidth(numf(nd->le));
}

S void op_textsize(ND* nd) {
	gr_textsize(numf(nd->le));
}

S int geticol(double cf) {
	int c = (int)(cf * 255 + 0.5);
	if (c < 0) c = 0;
	else if (c > 255) c = 255;
	return c;
}
S void op_color3(ND* nd) {
	ND* ndx = nd + 1;
	int red = geticol(numf(nd->le));
	int green = geticol(numf(nd->ri));
	int blue = geticol(numf(ndx->ex));
	gr_color(red, green, blue);
}
S void op_gcircle(ND* nd) {
	ND* ndx = nd + 1;
	gr_circle(numf(nd->le), numf(nd->ri), numf(ndx->ex));
}
S void op_grect(ND* nd) {
	ND* ndx = nd + 1;
	gr_rect(numf(nd->le), numf(nd->ri), numf(ndx->ex), numf(ndx->ex2));
}
S void op_gline(ND* nd) {
	ND* ndx = nd + 1;
	gr_line(numf(nd->le), numf(nd->ri), numf(ndx->ex), numf(ndx->ex2));
}
S void op_co_rotate(ND* nd) {
	gr_rotate(numf(nd->le) / 180. * M_PI);
}
S void op_co_scale(ND* nd) {
	gr_scale(numf(nd->le));
}
S void op_lineto(ND* nd) {
	gr_lineto(numf(nd->le), numf(nd->ri));
}
S void op_co_translate(ND* nd) {
	gr_translate(numf(nd->le), numf(nd->ri));
}
S void op_gcircseg(ND* nd) {
	ND* ndx = nd + 1;
	gr_circseg(numf(nd->le), numf(nd->ri), numf(ndx->ex), numf(ndx->ex2), numf(ndx->ex3));
}
S void op_gtext(ND* nd) {
	ND* ndx = nd + 1;
	STR s = strf(ndx->ex);
	gr_text(numf(nd->le), numf(nd->ri), str_ptr(&s));
	str_free(&s);
}

S void op_polygon(ND* nd) {
	ARR arr = arrf(nd->le);
	gr_polygon(arr.pnum, arr.len);
	free(arr.pnum);
}

S void op_curve(ND* nd) {
	ARR arr = arrf(nd->le);
	gr_curve(arr.pnum, arr.len);
	free(arr.pnum);
}

S void op_sound(ND* nd) {
	ARR arr = arrf(nd->le);
	gr_sound(arr.pnum, arr.len);
	free(arr.pnum);
}

S void op_background(ND* nd) {
	int h = (int)numf(nd->le);
	if (h >= 0 && h < 1000) {
		int blue = (int)(h % 10 * 28.4);
		h = h / 10;
		int green = (int)(h % 10 * 28.4);
		int red = (int)(h / 10 * 28.4);
		gr_backcolor(red, green, blue);
	}
	else if (h == -1) {
		// image
		gr_sys(2);
	}
	else gr_backcolor(0, 0, 0);
}

S void op_color(ND* nd) {
	int h = (int)numf(nd->le);
	if (h >= 0 && h < 1000) {
		int blue = h % 10 * 28.4;
		h = h / 10;
		int green = h % 10 * 28.4;
		int red = h / 10 * 28.4;
		gr_color(red, green, blue);
	}
	else if (h == -1) {
		// foreground
		gr_sys(3);
	}
	else if (h == -2) {
		// background
		gr_sys(4);
	}
	else gr_color(0, 0, 0);
}

S void op_random_seed(ND* nd) {
	int h = (int)numf(nd->le);
	rt.randseed = h;
	srand(h);
}

S void op_numfmt(ND* nd) {
	rt.num_space = (int)numf(nd->le);
	rt.num_scale = (int)numf(nd->ri);
}

S void op_mouse_cursor(ND* nd) {
	gr_mouse_cursor((int)numf(nd->le));
}


// -----------------------------------------

S void op_arr_ass(ND* nd) {
	ARR a = arrf(nd->ri);
	ARR* arr = garr(nd->v1);
	if (arr->p != NULL) free(arr->p);
	*arr = a;
}

//---------------------------

S void o_aelael_ass(ND* nd, ushort typ) {
	double f;
	STR s;
	ND* ndx = nd + 1;
	if (typ != 1) f = numf(ndx->ex2);
	else s = strf(ndx->ex2);

	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	arr = arr->parr + h;
	h = arrind(arr, numf(ndx->ex), nd);

	if (typ == 0) {
		*(arr->pnum + h) = f;
	}
	else if (typ == 2) {
		*(arr->pnum + h) += f;
	}
	else if (typ == 3) {
		*(arr->pnum + h) -= f;
	}
	else if (typ == 4) {
		*(arr->pnum + h) *= f;
	}
	else if (typ == 5) {
		*(arr->pnum + h) /= f;
	}
	else { // typ = 1
		str_free(arr->pstr + h);
		*(arr->pstr + h) = s;
	}
}

S void op_flaelael_ass(ND* nd) {
	// f[i][j] = 2
	o_aelael_ass(nd, 0);
}
S void op_straelael_ass(ND* nd) {
	o_aelael_ass(nd, 1);
}
S void op_flaelael_assp(ND* nd) {
	o_aelael_ass(nd, 2);
}
S void op_flaelael_assm(ND* nd) {
	o_aelael_ass(nd, 3);
}
S void op_flaelael_asst(ND* nd) {
	o_aelael_ass(nd, 4);
}
S void op_flaelael_assd(ND* nd) {
	o_aelael_ass(nd, 5);
}

S void op_arrael_ass(ND* nd) {
	ND* ndx = nd + 1;
	ARR a = arrf(ndx->ex);
	ARR* arr = garr(nd->v1);
	int h = arrind(arr, numf(nd->ri), nd);
	arr = arr->parr + h;
	if (arr->p != NULL) free(arr->p);
	*arr = a;
}

//  -------------------------------------------------------------

S void exec_slow(ND* nd);
S void exec_sequ_slow(ND* sq);

S void exsq(ND* sq) {
	if (sq) {
		if (rt.slow == 0) exec_sequ(sq);
		else exec_sequ_slow(sq);
	}
}

void evt_func(int id, const char* v) {

	if (id == 0) {
		exsq(seq.animate);
	}
	else if (id == 1) {
		exsq(seq.timer);
	}
	else if (id == 2) {
		rt.key0 = v;
		strncpy(rt.key, v, sizeof(rt.key) - 1);
		exsq(seq.key_down);
		rt.key0 = NULL;
	}
	else if (id == 3) {
		rt.key0 = v;
		strncpy(rt.key, v, sizeof(rt.key) - 1);
		exsq(seq.key_up);
		rt.key0 = NULL;
	}
#ifdef __EMSCRIPTEN__
	else if (id == 5) {
		// input
		*input_str = 0;
		strncat(input_str, v, 1024);
	}
	else if (id == 6) {
		// input_cancel
		*input_str = 0;
		input_str = NULL;
	}
	else if (id >= 10 && id <= 12) {
		// debug step:31, over:32, out:33
		rt.slow = 31 + id - 10;
	}
#endif
	stop_flag = 0;
}

void evt_mouse(int id, double x, double y) {
	rt.mouse_x = x;
#ifdef __EMSCRIPTEN__
	if (grbotleft) rt.mouse_y = 100 - y;
	else rt.mouse_y = y;
#else
	rt.mouse_y = y;
#endif
	if (id == 0) {
		// on phones it's sometimes >= 100 or < 0
		if (x > 99.99609375) rt.mouse_x = 99.99609375;
		else if (x < 0) rt.mouse_x = 0;
		if (y > 99.99609375) rt.mouse_y = 99.99609375;
		else if (y < 0) rt.mouse_y = 0;

		exsq(seq.mouse_down);
	}
	else if (id == 1) exsq(seq.mouse_up);
	else exsq(seq.mouse_move);

	stop_flag = 0;
}


S ND* init_params(double* nums, STR* strs, ARR* arrs, ND* nd, ND* ndp) {
	int ind = 0;
	ushort ifl = 0;
	ushort istr = 0;
	ushort iarr = 0;

	while (nd) {
		if (ind == 8) {
			ndp = ndp->bxnd;
			ind = 0;
		}
		int t = ndp->bx[ind];
		if (t == PAR_NUM) {
			nums[ifl] = numf(nd);
			ifl += 1;
		}
		else if (t == PAR_STR) {
			strs[istr] = strf(nd);
			istr += 1;
		}
		else if (t == PAR_ARR) {
			arrs[iarr] = arrf(nd);
			iarr += 1;
		}
		else if (t == PAR_RNUM) {
			nums[ifl] = *(gnum(nd->v1));
			ifl += 1;
		}
		else if (t == PAR_RSTR) {
			STR* pstr = gstr(nd->v1);
			strs[istr] = *pstr;
			istr += 1;
			// otherwise problems with global str variables
			str_init(pstr);
		}
		else if (t == PAR_RARR) {
			ARR* arr = garr(nd->v1);
			if (nd->ri) {
				int h = arrind(arr, numf(nd->ri), nd);
				arr = arr->parr + h;
			}
			arrs[iarr] = *arr;
			iarr += 1;
			// otherwise problems with global arr variables
			arr->p = 0;
			arr->len = 0;
		}
		else {
			// TODO delete
			internal_error(__LINE__);
		}
		ind += 1;
		nd = nd->next;
	}
	return ndp;
}

S void exit_params(double* nums, STR* strs, ARR* arrs, ND* nd, ND* ndp, int n_str, int n_arr) {
	ushort ind = 0;
	ushort ifl = 0;
	ushort istr = 0;
	ushort iarr = 0;

	while (nd) {
		int t = ndp->bx[ind];

		if (t == PAR_NUM) ifl += 1;
		else if (t == PAR_STR) {
			str_free(strs + istr);
			istr += 1;
		}
		else if (t == PAR_ARR) {
			ARR* a = arrs + iarr;
			if (a->p) free_arr(a);
			iarr += 1;
		}
		else if (t == PAR_RNUM) {
			*(gnum(nd->v1)) = nums[ifl];
			ifl += 1;
		}
		else if (t == PAR_RSTR) {
			*(gstr(nd->v1)) = strs[istr];
			// don't free reference strs
			str_init(&strs[istr]);
			istr += 1;
		}
		else  {
			// PAR_RARR
			ARR* arr = garr(nd->v1);
			if (nd->ri) {
				int h = arrind(arr, numf(nd->ri), nd);
				arr = arr->parr + h;
			}
			if (arr->p != NULL) free(arr->p);
			*arr = arrs[iarr];
			// don't free reference arrs
			arrs[iarr].p = NULL;
			iarr += 1;
		}
		ind += 1;
		if (ind == 8) {
			ndp = ndp->bxnd;
			ind = 0;
		}
		nd = nd->next;
	}
	for (int is = 0; is < n_str; is++) {
		str_free(strs + is);
	}
	for (int ia = 0; ia < n_arr; ia++) {
		ARR* a = arrs + ia;
		if (a->p) free_arr(a);
	}
}

S void op_callproc(ND* nd0) {

	ND* ndp = nd0->le;
	double* nums = NULL;
	STR* strs = NULL;
	ARR* arrs = NULL;
	byte n_num = ndp->bx0;
	byte n_str = ndp->bx1;
	byte n_arr = ndp->bx2;

	if (n_num) {
		nums = alloca(n_num * sizeof(double));
		memset(nums, 0, n_num * sizeof(double));
	}
	if (n_str) {
		strs = alloca(n_str * sizeof(STR));
		memset(strs, 0, n_str * sizeof(STR));
	}
	if (n_arr) {
		arrs = alloca(n_arr * sizeof(ARR));
		arrs_init(arrs, n_arr);
	}
	ndp = init_params(nums, strs, arrs, nd0->ri, ndp);

	double* rtl_nums_caller = rtl_nums;
	STR* rtl_strs_caller = rtl_strs;
	ARR* rtl_arrs_caller = rtl_arrs;
	rtl_nums = nums;
	rtl_strs = strs;
	rtl_arrs = arrs;

	ND* proc_caller = rt.proc;
	rt.proc = nd0->le;

	if (rt.slow == 0) exec_sequ(ndp->bxnd);
	else {
		if (rt.slow >= 32) rt.slow += 1;
		exec_sequ_slow(ndp->bxnd);
		if (rt.slow > 32) rt.slow -= 1;
	}
	stop_flag = 0;

	rt.proc = proc_caller;

	rtl_nums = rtl_nums_caller;
	rtl_strs = rtl_strs_caller;
	rtl_arrs = rtl_arrs_caller;

	exit_params(nums, strs, arrs, nd0->ri, nd0->le, n_str, n_arr);
}

S ND* funcnd;

S void op_return(ND* nd) {
	funcnd = nd->le;
	stop_flag = 9999;
}
S double op_callfunc(ND* nd0) {
	ND* ndp = nd0->le;
	double* nums = NULL;
	STR* strs = NULL;
	ARR* arrs = NULL;
	byte n_num = ndp->bx0;
	byte n_str = ndp->bx1;
	byte n_arr = ndp->bx2;

	if (n_num) {
		nums = alloca(n_num * sizeof(double));
		memset(nums, 0, n_num * sizeof(double));
	}
	if (n_str) {
		strs = alloca(n_str * sizeof(STR));
		memset(strs, 0, n_str * sizeof(STR));
	}
	if (n_arr) {
		arrs = alloca(n_arr * sizeof(ARR));
		arrs_init(arrs, n_arr);
	}

	ndp = init_params(nums, strs, arrs, nd0->ri, ndp);

	double* rtl_nums_caller = rtl_nums;
	STR* rtl_strs_caller = rtl_strs;
	ARR* rtl_arrs_caller = rtl_arrs;
	rtl_nums = nums;
	rtl_strs = strs;
	rtl_arrs = arrs;

	ND* proc_caller = rt.proc;
	rt.proc = nd0->le;

	funcnd = NULL;
	if (rt.slow == 0) exec_sequ(ndp->bxnd);
	else {
		if (rt.slow >= 32) rt.slow += 1;
		exec_sequ_slow(ndp->bxnd);
		if (rt.slow > 32) rt.slow -= 1;
	}
	stop_flag = 0;

	double retval = 0;
	if (funcnd) {
		retval = numf(funcnd);
		funcnd = NULL;
	}
	rt.proc = proc_caller;
	rtl_nums = rtl_nums_caller;
	rtl_strs = rtl_strs_caller;
	rtl_arrs = rtl_arrs_caller;

	exit_params(nums, strs, arrs, nd0->ri, nd0->le, n_str, n_arr);

	return retval;
}
S void callfunc(ND* nd0, double* ret, STR* retstr, ARR* retarr) {
	ND* ndp = nd0->le;
	double* nums = NULL;
	STR* strs = NULL;
	ARR* arrs = NULL;
	byte n_num = ndp->bx0;
	byte n_str = ndp->bx1;
	byte n_arr = ndp->bx2;

	if (ndp->bx0) {
		nums = alloca(n_num * sizeof(double));
		memset(nums, 0, n_num * sizeof(double));
	}
	if (n_str) {
		strs = alloca(n_str * sizeof(STR));
		memset(strs, 0, n_str * sizeof(STR));
	}
	if (n_arr) {
		arrs = alloca(n_arr * sizeof(ARR));
		arrs_init(arrs, n_arr);
	}

	ndp = init_params(nums, strs, arrs, nd0->ri, ndp);

	double* rtl_nums_caller = rtl_nums;
	STR* rtl_strs_caller = rtl_strs;
	ARR* rtl_arrs_caller = rtl_arrs;
	rtl_nums = nums;
	rtl_strs = strs;
	rtl_arrs = arrs;

	ND* proc_caller = rt.proc;
	rt.proc = nd0->le;

	funcnd = NULL;
	if (rt.slow == 0) exec_sequ(ndp->bxnd);
	else {
		if (rt.slow >= 32) rt.slow += 1;
		exec_sequ_slow(ndp->bxnd);
		if (rt.slow > 32) rt.slow -= 1;
	}
	stop_flag = 0;

	if (funcnd) {
		if (ret) *ret = numf(funcnd);
		else if (retstr) *retstr = strf(funcnd);
		else if (retarr) {
			*retarr = arrf(funcnd);
		}
		funcnd = NULL;
	}
	rt.proc = proc_caller;
	rtl_nums = rtl_nums_caller;
	rtl_strs = rtl_strs_caller;
	rtl_arrs = rtl_arrs_caller;

	exit_params(nums, strs, arrs, nd0->ri, nd0->le, n_str, n_arr);
}

/*
// reduces max call stack by half

S double op_callfunc(ND* nd0) {
	double retval = 0;
	callfunc(nd0, &retval, NULL, NULL);
	return retval;
}
*/

S STR op_callfunc_str(ND* nd0) {
	STR retval;
	str_init(&retval);
	callfunc(nd0, NULL, &retval, NULL);
	return retval;
}
S ARR op_callfunc_arr(ND* nd0) {
	ARR retval;
	retval.len = 0;

	retval.typ = ARR_NUM;
	retval.base = rt.arrbase;
	retval.p = NULL;
	callfunc(nd0, NULL, NULL, &retval);
	return retval;
}

S double op_fastcall(ND* nd0) {

#ifdef __EMSCRIPTEN__

	ND* nd = nd0->ri;
	byte n = nd0->le->bx3 + 96;
	double a[4];
	int i = 0;
	while (nd) {
		if (i == 4) {
			internal_error(__LINE__);
			return 0;
		}
		a[i++] = numf(nd);
		nd = nd->next;
	}

	double r;
	if (i == 0) {
		r = EM_ASM_DOUBLE(
			{ return fastinst.exports[String.fromCharCode($0)]() }, n);
	}
	else if (i == 1) {
		r = EM_ASM_DOUBLE(
			{ return fastinst.exports[String.fromCharCode($0)]($1) }, n, a[0]);
	}
	else if (i == 2) {
		r = EM_ASM_DOUBLE(
			{ return fastinst.exports[String.fromCharCode($0)]($1, $2) }, n, a[0], a[1]);
	}
	else if (i == 3) {
		r = EM_ASM_DOUBLE(
			{ return fastinst.exports[String.fromCharCode($0)]($1, $2, $3) }, n, a[0], a[1], a[2]);
	}
	else {	// if (i == 4)
		r = EM_ASM_DOUBLE(
			{ return fastinst.exports[String.fromCharCode($0)]($1, $2, $3, $4) }, n, a[0], a[1], a[2], a[3]);
	}
	return r;

#else
	return op_callfunc(nd0);
#endif
}

#define sl_as(ps, s) str_append(ps, s)

S void sl_anf(STR* ps, double h) {
	STR s = str_numf(h, sysconfig & 8);
	str_append(ps, str_ptr(&s));
	str_free(&s);
}

S const char* vexf(ushort typ) {
	if (typ < VAR_NUMARR) return vex(typ);
	if (typ == VAR_NUMARR) return "[]";
	else if (typ == VAR_STRARR) return "$[]";
	else if (typ == VAR_NUMARRARR) return "[][]";
	else if (typ == VAR_STRARRARR) return "$[][]";
	else return "";
}
S void dbg_debv(STR* ps, struct proc* fu, double* nums, STR* strs, ARR* arrs) {

	if (fu->vname_p == NULL) return;
	struct vname *p = fu->vname_p;
	while (p < fu->vname_p + fu->vname_len) {
		if (p->typ == VAR_SUBR) {
			p += 1;
			continue;
		}
		sl_as(ps, p->name);
		sl_as(ps, vexf(p->typ));
		sl_as(ps, ":");

		if (p->typ == VAR_NUM) sl_anf(ps, nums[p->id]);
		else if (p->typ == VAR_STR) {
			sl_as(ps, "\"");
			sl_as(ps, str_ptr(strs + p->id));
			sl_as(ps, "\"");
		}
		else {
			ARR* a = arrs + p->id;
			if (a->len > 1000) {
				sl_as(ps, "[ ");
				sl_anf(ps, a->len);
				sl_as(ps, " items ");
				sl_as(ps, " ]");
			}
			else if (p->typ == VAR_NUMARR) {
				sl_as(ps, "[ ");
				for (int i = 0; i < a->len; i++) {
					sl_anf(ps, a->pnum[i]);
					sl_as(ps, " ");
				}
				sl_as(ps, "]");
			}
			else if (p->typ == VAR_STRARR) {
				sl_as(ps, "[ ");
				for (int i = 0; i < a->len; i++) {
					sl_as(ps, "\"");
					sl_as(ps, str_ptr(a->pstr + i));
					sl_as(ps, "\" ");
				}
				sl_as(ps, "]");
			}
			else if (p->typ == VAR_NUMARRARR) {
				STR str;
				str_init(&str);
				xnumarrarrstr(&str, a);
				sl_as(ps, str_ptr(&str));
			}
			else if (p->typ == VAR_STRARRARR)  {
				STR str;
				str_init(&str);
				xstrarrarrstr(&str, a);
				sl_as(ps, str_ptr(&str));
			}
		}
		sl_as(ps, "\n");
		p += 1;
	}
}

S void dbg_outvars(void) {
	STR s;
	str_init(&s);
	dbg_debv(&s, proc_p, rt_nums, rt_strs, rt_arrs);
	//struct proc* f = proc_p;
	struct proc* p = proc_p + 1;	//kc without global
	while (p < proc_p + proc_len) {
		if (p->start == rt.proc) {
			sl_as(&s, "----- Local scope -----\n");
			dbg_debv(&s, p, rtl_nums, rtl_strs, rtl_arrs);
			break;
		}
		p += 1;
	}
	sl_as(&s, "\n");
	gr_debout(str_ptr(&s));
	str_free(&s);
}

S void dbg_delay(void) {
	if (rt.slow && rt.slow < 31) {
		gr_sleep(rt.slow *  0.1);
	}
}

S void dbg_line(ND* nd) {
	if (rt.slow && rt.slow < 33) {
		int i = 0;
		while (i < opline_len && opline_p[i].nd != nd) i++;
		if (i == opline_len) {
			internal_error(__LINE__);
			return;
		}
		gr_debline(opline_p[i].line, 0);
		dbg_outvars();
		if (rt.slow == 32 || rt.slow == 31) {
			gr_step();
		}
		else {
			dbg_delay();
		}
	}
}

S void dbg_dispvars(void) {
	if (rt.slow < 33) {
		dbg_outvars();
		dbg_delay();
	}
}

S void exec_sequ_slow(ND* nd) {
	while (nd && !stop_flag) {
		dbg_line(nd);
		exec_slow(nd);
		if (nd->vf != op_if && nd->vf != op_if_else) dbg_dispvars();
		nd = nd->next;
	}
}

S void op_while_slow(ND* nd) {
	if (rt.slow >= 32) rt.slow += 1;
	while (intf(nd->le)) {
		dbg_delay();
		exec_sequ_slow(nd->ri);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		dbg_line(nd);
	}
	if (rt.slow > 32) rt.slow -= 1;
}

S void op_repeat_slow(ND* nd) {
	if (rt.slow >= 32) rt.slow += 1;
	ND* ndx = nd + 1;
	dbg_delay();
	while (1) {
		exec_sequ_slow(nd->ri);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		dbg_line(nd->le);
		if (intf(nd->le)) break;
		dbg_delay();
		exec_sequ_slow(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}
	if (rt.slow > 32) rt.slow -= 1;
}

S void op_if_slow(ND* nd) {
	dbg_delay();
	if (intf(nd->le)) {
		exec_sequ_slow(nd->ri);
	}
}

S void op_if_else_slow(ND* nd) {
	dbg_delay();
	ND* ndx = nd->ri;
	if (intf(nd->le)) {
		exec_sequ_slow(ndx->ex);
	}
	else {
		exec_sequ_slow(ndx->ex2);
	}
}

S void op_callsubr_slow(ND* nd) {
	if (rt.slow >= 32) rt.slow += 1;
	exec_sequ_slow(nd->le->ex);
	if (rt.slow > 32) rt.slow -= 1;
	stop_flag = 0;
}

// ---------------------------------------------------
S void xop_for_slow(ND* nd, double inc, int start) {
	if (rt.slow >= 32) rt.slow += 1;
	ND* ndx = nd + 1;
	double to = numf(nd->ri);
	double* pfro = gnum(nd->v1);
	if (start >= 0) *pfro = start;
	else *pfro = numf(ndx->ex2);
	if (start == 0) to -= 1;
	while (1) {
		if (inc > 0 && *pfro > to) break;
		if (inc < 0 && *pfro < to) break;
		dbg_delay();
		exec_sequ_slow(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pfro += inc;
		dbg_line(nd);
	}
	if (rt.slow > 32) rt.slow -= 1;
}


S void op_for_slow(ND* nd) {
	xop_for_slow(nd, 1, -1);
}
S void op_fordown_slow(ND* nd) {
	xop_for_slow(nd, -1, -1);
}

S void op_forstep_slow(ND* nd) {
	ND* ndx = nd + 1;
	double step = numf(ndx->ex3);
	xop_for_slow(nd, step, -1);
}
S void op_for_to_slow(ND* nd) {
	xop_for_slow(nd, 1, 1);
}

S void op_for_range_slow(ND* nd) {
	xop_for_slow(nd, 1, 0);
}

S void op_for_in_slow(ND* nd) {
	if (rt.slow >= 32) rt.slow += 1;
	ND* ndx = nd + 1;
	double* pnum = gnum(nd->v1);
	ARR arr = arrf(nd->ri);
	int ind = 0;
	double old = *pnum;
	while (ind < arr.len) {
		*pnum = arr.pnum[ind];
		dbg_line(nd);
		exec_sequ_slow(ndx->ex);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		ind += 1;
		dbg_delay();
	}
	if (ind == arr.len) *pnum = old;
	free(arr.pnum);
	if (rt.slow > 32) rt.slow -= 1;
}

S void op_for_instr(ND* nd) {
	if (rt.slow >= 32) rt.slow += 1;
	ND* ndx = nd + 1;
	STR* pstr = gstr(nd->v1);
	ARR arr = arrf(nd->ri);
	int ind = 0;

	STR old = *pstr;

	while (ind < arr.len) {
		*pstr = arr.pstr[ind];

		if (rt.slow == 0) exec_sequ(ndx->ex);
		else {
			dbg_line(nd);
			exec_sequ_slow(ndx->ex);
		}
		if (stop_flag) {
			stop_flag -= 1;
			int h = ind + 1;
			while (h < arr.len) {
				str_free(arr.pstr + h);
				h += 1;
			}
			break;
		}
		ind += 1;
		dbg_delay();
		str_free(pstr);
	}
	if (ind == arr.len) *pstr = old;
	else str_free(&old);
	free(arr.pstr);
	if (rt.slow > 32) rt.slow -= 1;
}

//kcc
S void op_for_inarr(ND* nd) {
	if (rt.slow >= 32) rt.slow += 1;
	ND* ndx = nd + 1;
	ARR* parr = garr(nd->v1);
	ARR arrarr = arrf(nd->ri);
	int ind = 0;
	ARR old = *parr;
	while (ind < arrarr.len) {
		*parr = arrarr.parr[ind];

		if (rt.slow == 0) exec_sequ(ndx->ex);
		else {
			dbg_line(nd);
			exec_sequ_slow(ndx->ex);
		}

		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		ind += 1;
		dbg_delay();
		free(parr->parr);
	}
	if (ind == arrarr.len) *parr = old;
	else free(old.parr);
	free(arrarr.parr);
	if (rt.slow > 32) rt.slow -= 1;
}

#if 0
S ARR op_map_number(ND* nd) {
	ARR arr = arrf(nd->le);

	ARR res;
	res.len = arr.len;
	res.typ = ARR_NUM;
	res.base = arr.base;
	res.p = realloc(NULL, res.len * sizeof(double));
	if (res.p == NULL) {
		out_of_mem(nd);
		res.len = 0;
		goto exit;
	}
	rt.sys_error = 0;
	for (int i = 0; i < arr.len; i++) {
		STR s = arr.pstr[i];
		char *p;
		const char *ps = str_ptr(&s);
		double d = strtod(ps, &p);
		if (p == ps || *p != 0) {
			rt.sys_error = 1;
		}
		str_free(&s);
		res.pnum[i] = d;
	}
	exit:
	free(arr.pstr);
	return res;
}
#else
// put only valid numbers in array
S ARR op_map_number(ND* nd) {
	ARR arr = arrf(nd->le);

	ARR res;
	res.len = 0;
	res.typ = ARR_NUM;
	res.base = arr.base;
	res.p = NULL;
	rt.sys_error = 0;
	for (int i = 0; i < arr.len; i++) {
		STR s = arr.pstr[i];
		char *p;
		const char *ps = str_ptr(&s);
		double d = strtod(ps, &p);
		if (p == ps) {
//		if (p == ps || *p != 0) {
			rt.sys_error = 1;
		}
		else {
			res.len += 1;
			res.p = realloc(res.p, res.len * sizeof(double));
			if (res.p == NULL) {
				out_of_mem(nd);
				res.len = 0;
				goto exit;
			}
			res.pnum[res.len - 1] = d;
		}
		str_free(&s);
	}
	exit:
	free(arr.pstr);
	return res;
}
#endif

S void exec_slow(ND* nd) {
	void (*vf)(ND*) = nd->vf;
	if (vf == op_while) vf = op_while_slow;
	else if (vf == op_if) vf = op_if_slow;
	else if (vf == op_if_else) vf = op_if_else_slow;
	else if (vf == op_callsubr) vf = op_callsubr_slow;
	else if (vf == op_for) vf = op_for_slow;
	else if (vf == op_fordown) vf = op_fordown_slow;
	else if (vf == op_forstep) vf = op_forstep_slow;
	else if (vf == op_for_range) vf = op_for_range_slow;
	else if (vf == op_for_to) vf = op_for_to_slow;
	else if (vf == op_for_in) vf = op_for_in_slow;
	else if (vf == op_repeat) vf = op_repeat_slow;
	(*(vf))(nd);
}


S void free_rt(void) {
	free(rt_nums);
	int i;
	for (i = 0; i < proc_p->varcnt[1]; i++) {
		str_free(rt_strs + i);
	}
	free(rt_strs);
	for (int ia = 0; ia < proc_p->varcnt[2]; ia++) {
		free_arr(rt_arrs + ia);
	}
	free(rt_arrs);
	out_of_memf = NULL;
	parse_clean();
}

// ------------ exceptions ----------------



S void except(ND* nd, const char* s) {
	char b[36];
	strcpy(b, "*** ERROR: ");
	strcat(b, s);
	gr_print(b);

	gr_info(1);
	int i = 0;
	while (i < opline_len) {
		if (opline_p[i].nd == nd) {
			gr_debline(opline_p[i].line, 1);
			break;
		}
		i++;
	}
	dbg_outvars();

	free_rt();
	gr_exit();
}

S void out_of_bounds(ND* nd) {
	except(nd, "index out of bounds");
}

S void out_of_mem(ND* nd) {
	except(nd, "out of memory");
}

S void out_of_mem0(void) {
	out_of_mem(NULL);
}

// -------------------------------------------------------

S void init_rt(void) {

	int h;
	out_of_memf = out_of_mem0;
	h = proc_p->varcnt[0] * sizeof(double);
	rt_nums = (double*)_realloc(NULL, h);
	memset(rt_nums, 0, h);
	h = proc_p->varcnt[1] * sizeof(STR);
	rt_strs = (STR*)_realloc(NULL, h);
	memset(rt_strs, 0, h);

	h = proc_p->varcnt[2] * sizeof(ARR);
	rt_arrs = (ARR*)_realloc(NULL, h);

	time_start = sys_time();

	rt.mouse_x = 0;
	rt.mouse_y = 0;

	rt.num_scale = 2;
	rt.num_space = 0;
	rt.key[0] = 0;
	rt.key0 = NULL;

	rt.sys_error = 0;
	rt.proc = NULL;

	rt.input_data_pos = 0;
	stop_flag = 0;
	rt.randseed = -1;
	rt.radians = 0;
	if (sysconfig & 2) rt.radians = 1;
	rt.arrbase = 1;
	if (sysconfig & 4) rt.arrbase = 0;
	arrs_init(rt_arrs, proc_p->varcnt[2]);
}
