/*	kafunc.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns 
    "christof.kaser@gmail.com".
*/

#if defined(__EMSCRIPTEN__)

#include "kabasw.h"

#elif defined(__RUN__) || defined(__NOSDL__)

#include "../native/kabgr_nosdl.c"

#elif defined(__SDL__)

#include "../native/kabgr.c"

#endif 

struct arr {
	union {
		void* p;
		double* pnum;
		struct str* pstr;
		struct arr* parr;
	};
	int len;
	char base;
	char typ;
};

static void arrs_init(struct arr* arrs, int n_arr) {
	memset(arrs, 0, n_arr * sizeof(struct arr));
	for (int i = 0; i < n_arr; i++) {
		arrs[i].base = 1;
	}
}

static struct {
	double mouse_x;
	double mouse_y;
	const char* key;
	short num_scale;
	short num_space;
	const char* args;
	ushort func;
	char sys_error;
	ushort slow;
	ushort sys;
	uint input_data_pos;
} rt;

static volatile int stop_flag;

// -------------------------------------------

static double* rt_nums;
static struct str* rt_strs;
static struct arr* rt_arrs;

static double* rtl_nums;
static struct str* rtl_strs;
static struct arr* rtl_arrs;

static double* gnum(short ind) {
	if (ind >= 0) return rt_nums + ind;
	return rtl_nums - ind - 1;
}
static struct str* gstr(short ind) {
	if (ind >= 0) return rt_strs + ind;
	return rtl_strs - ind - 1;
}
static struct arr* garr(short ind) {
	if (ind >= 0) return rt_arrs + ind;
	return rtl_arrs - ind - 1;
}

static void out_of_bounds(struct op* op);
static void out_of_mem(struct op* op);
static void free_rt();

// ----------------------------------------------------------------------

#define intf(o) ((*((codp + o)->intf))(codp + o))
#define vf(o) ((*((codp + o)->vf))(codp + o))
#define strf(o) ((*((codp + o)->strf))(codp + o))
#define numf(o) ((*((codp + o)->numf))(codp + o))
#define arrf(o) ((*((codp + o)->arrf))(codp + o))


// -------------------------------  for performance

static int op_eqv(struct op* op) {
	return rt_nums[op->o1] == numf(op->o2);
}
static int op_neqv(struct op* op) {
	return rt_nums[op->o1] != numf(op->o2);
}
static int op_ltv(struct op* op) {
	return rt_nums[op->o1] < numf(op->o2);
}
static int op_lev(struct op* op) {
	return rt_nums[op->o1] <= numf(op->o2);
}
static int op_gtv(struct op* op) {
	return rt_nums[op->o1] > numf(op->o2);
}
static int op_gev(struct op* op) {
	return rt_nums[op->o1] >= numf(op->o2);
}

static int op_eqvl(struct op* op) {
	return rtl_nums[op->o1] == numf(op->o2);
}
static int op_neqvl(struct op* op) {
	return rtl_nums[op->o1] != numf(op->o2);
}
static int op_ltvl(struct op* op) {
	return rtl_nums[op->o1] < numf(op->o2);
}
static int op_levl(struct op* op) {
	return rtl_nums[op->o1] <= numf(op->o2);
}
static int op_gtvl(struct op* op) {
	return rtl_nums[op->o1] > numf(op->o2);
}
static int op_gevl(struct op* op) {
	return rtl_nums[op->o1] >= numf(op->o2);
}

static void op_intass16(struct op* op) {
	double* p = gnum(op->o1);
	*p = op->cint16;
}
static void op_intassp16(struct op* op) {
	double* p = gnum(op->o1);
	*p += op->cint16;
}
static void op_ass_var(struct op* op) {
	double* p = gnum(op->o1);
	*p = rt_nums[op->o2];
}
static void op_ass_lvar(struct op* op) {
	double* p = gnum(op->o1);
	*p = rtl_nums[op->o2];
}

static double op_vnumael_var(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = rt_nums[op->o2] - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return 0;
	}
	return *(arr->pnum + h);
}

static double op_vnumael_lvar(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = rtl_nums[op->o2] - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return 0;
	}
	return *(arr->pnum + h);
}

static double op_add_vnum16(struct op* op) {
	return rt_nums[op->o1] + op->cint16;
}
static double op_add_vnum16l(struct op* op) {
	return rtl_nums[op->o1] + op->cint16;
}

//  int_funcs  --------------------------------------------------

static double op_error(struct op* op) {
	return rt.sys_error;
}

static double op_sys_time(struct op* op) {
	return sys_time();
}

static double op_random(struct op* op) {
//#ifdef __EMSCRIPTEN__
#if 0
	double f = (double)emscripten_random();
#else
	double f = ((double)rand() / (RAND_MAX + 1.0));
#endif
	int h = (int)numf(op->o1);
	int r = (int)(f * h);
//kc is this necessary??
	if (r == h) r -= 1;
	return r + 1;
}

static double op_numlog(struct op* op) {
	return intf(op->o1);
}
static double op_abs(struct op* op) {
	return fabs(numf(op->o1));
}
static double op_sign(struct op* op) {
	double h = numf(op->o1);
	if (h > 0) return 1;
	if (h < 0) return -1;
	return 0;
}
static double op_floor(struct op* op) {
	return floor(numf(op->o1));
}

//kc
static double op_str_ord(struct op* op) {
	struct str s = strf(op->o1);
	const char* utf8 = str_ptr(&s);
	if(!(utf8[0] & 0x80)) return utf8[0];
	else if ((utf8[0] & 0xe0) == 0xc0) return (((utf8[0] & 0x1f) << 6) | (utf8[1] & 0x3f));
	else if((utf8[0] & 0xf0) == 0xe0) {
		return (((utf8[0] & 0x0f) << 12) | ((utf8[1] & 0x3f) << 6) | (utf8[2] & 0x3f));
	}
	else
		return -1;
}

static double op_str_len(struct op* op) {
	struct str s = strf(op->o1);
	int h = str_ulen(str_ptr(&s));
	str_free(&s);
	return h;
}

static double op_mouse_x(struct op* op) {
	return rt.mouse_x;
}
static double op_mouse_y(struct op* op) {
	return rt.mouse_y;
}

static double op_randomf(struct op* op) {

//#ifdef __EMSCRIPTEN__
#if 0
	double f = (double)emscripten_random();
#else
	double f = ((double)rand() / RAND_MAX);
#endif
	return f;
}

static double op_pi(struct op* op) {
	return M_PI;
}
static double op_sqrt(struct op* op) {
	return sqrt(numf(op->o1));
}
static double op_logn(struct op* op) {
	return log(numf(op->o1));
}
static double op_sin(struct op* op) {
	return sin(numf(op->o1) / 180. * M_PI);
}
static double op_cos(struct op* op) {
	return cos(numf(op->o1) / 180. * M_PI);
}
static double op_tan(struct op* op) {
	return tan(numf(op->o1) / 180. * M_PI);
}
static double op_asin(struct op* op) {
	return asin(numf(op->o1)) * 180 / M_PI;
}
static double op_acos(struct op* op) {
	return acos(numf(op->o1)) * 180 / M_PI;
}
static double op_atan(struct op* op) {
	return atan(numf(op->o1)) * 180 / M_PI;
}
static double op_atan2(struct op* op) {
	return atan2(numf(op->o1), numf(op->o2)) * 180 / M_PI;
}
static double op_pow(struct op* op) {
	return pow(numf(op->o1), numf(op->o2));
}

static double op_higher(struct op* op) {
	double a = numf(op->o1);
	double b = numf(op->o2);
	return a > b ? a : b;
}
static double op_lower(struct op* op) {
	double a = numf(op->o1);
	double b = numf(op->o2);
	return a < b ? a : b;

}

static double op_number(struct op* op) {
	struct str s = strf(op->o1);
	char *p;
	const char *ps = str_ptr(&s);
	double d = strtod(ps, &p);
	rt.sys_error = 0;
	if (p == ps || *p != 0) {
		rt.sys_error = 1;
	}
	str_free(&s);
	return d;
}

static double op_str_compare(struct op* op) {
	struct str s1 = strf(op->o1);
	struct str s2 = strf(op->o2);
	double h = str_cmp(&s1, &s2);
	str_free(&s1);
	str_free(&s2);
	return h;
}

static double op_vnumaelael(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return 0;
	}
	arr = arr->parr + h;
	h = (int)numf(op->o3) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return 0;
	}
	return *(arr->pnum + h);
}

static double op_arr_len(struct op* op) {
	struct arr* arr = garr(op->o1);
	return arr->len;
}
static double op_arrarrael_len(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return 0;
	}
	arr = arr->parr + h;
	return arr->len;
}

static void free_arr_members(struct arr* a, int i0) {
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

static void free_arr(struct arr* a) {
	free_arr_members(a, 0);
	free(a->p);
	a->p = NULL;
}

static void arr_len(struct op* op, int sz, int typ) {
	struct arr* arr = garr(op->o1);
	arr->typ = typ;
	if (typ >= ARR_AEL) {
		int h = (int)numf(op->o3) - arr->base;
		if (h < 0 || h >= arr->len) {
			out_of_bounds(op);
			return;
		}
		arr = arr->parr + h;
		typ = typ - (ARR_AEL - ARR_NUM);
	}

	int h = (int)numf(op->o2);
	if (h == arr->len) return;
	if (h < 0) {
		h = arr->len + h;
		if (h < 0) h = 0;
	}
	void* p;
	if (h > arr->len) {
		p = realloc(arr->p, h * sz);
		if (p == NULL) {
			out_of_mem(op);
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
		p = realloc(arr->p, h * sz);
		if (p == NULL && h) {
			out_of_mem(op);
			return;
		}
		arr->p = p;
	}
	arr->len = h;
}

static void op_numarr_len(struct op* op) {
	arr_len(op, sizeof(double), ARR_NUM);
}
static void op_strarr_len(struct op* op) {
	arr_len(op, sizeof(struct str), ARR_STR);
}

static void op_arrarr_len(struct op* op) {
	arr_len(op, sizeof(struct arr), ARR_ARR);
}

static void op_arrnumarrel_len(struct op* op) {
	arr_len(op, sizeof(double), ARR_AEL);
}

static void op_arrstrarrel_len(struct op* op) {
	arr_len(op, sizeof(struct str), ARR_AELSTR);
}
static void op_arrbase(struct op* op) {
	struct arr* arr = garr(op->o1);
	arr->base = 1;
	int h = (int)numf(op->o2);
	if (h <= 127 && h >= -128) arr->base = (char)h;
}
static void op_arrbase2(struct op* op) {
	struct arr* arr = garr(op->o1);

	int h = (int)numf(op->o3) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	arr = arr->parr + h;
	arr->base = 1;
	h = (int)numf(op->o2);
	if (h <= 127 && h >= -128) arr->base = (char)h;
}

// -------------------------------------------------------------

static struct arr* arrael_append(struct op* op, int arrtyp, int sz) {
	struct arr* arr = garr(op->o1);
//kc	arr->typ = ARR_ARR;
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return NULL;
	}
	arr = arr->parr + h;
	arr->typ = arrtyp;
	arr->len += 1;
	void* p = realloc(arr->p, arr->len * sz);
	if (p == NULL) {
		out_of_mem(op);
		return NULL;
	}
	arr->p = p;
	return arr;
}

static void op_numarrael_append(struct op* op) {
	double h = numf(op->o3);
	struct arr* arr = arrael_append(op, ARR_NUM, sizeof(double));
	*(arr->pnum + arr->len - 1) = h;
}

static void op_strarrael_append(struct op* op) {
	struct str s = strf(op->o3);
	struct arr* arr = arrael_append(op, ARR_STR, sizeof(struct str));
	*(arr->pstr + arr->len - 1) = s;
}

// -------------------------------------------------------------

static struct arr* arr_append(struct op* op, int arrtyp, int sz) {
	struct arr* arr = garr(op->o1);
	arr->typ = arrtyp;
	arr->len += 1;
	void* p = realloc(arr->p, arr->len * sz);
	if (p == NULL) {
		out_of_mem(op);
		return NULL;
	}
	arr->p = p;
	return arr;
}

static void op_numarr_append(struct op* op) {
	double h = numf(op->o2);
	struct arr* arr = arr_append(op, ARR_NUM, sizeof(double));
	*(arr->pnum + arr->len - 1) = h;
}

static void op_strarr_append(struct op* op) {
	struct str s = strf(op->o2);
	struct arr* arr = arr_append(op, ARR_STR, sizeof(struct str));
	*(arr->pstr + arr->len - 1) = s;
}

static void op_arrarr_append(struct op* op) {
	struct arr h = arrf(op->o2);
	struct arr* arr = arr_append(op, ARR_ARR, sizeof(struct arr));
	*(arr->parr + arr->len - 1) = h;
}

static void op_arrarr_ass(struct op* op) {
	struct arr* arr = garr(op->o1);
	struct arr a = arrf(op->o2);
	free_arr(arr);
	*arr = a;
}

// ------------ double factor --------------------------

static double op_const_fl(struct op* op) {
	return op->cfl;
}
static double op_const_flx(struct op* op) {
	return (op +  1)->cdbl;
}

static double op_negf(struct op* op) {
	return -numf(op->o1);
}
static double op_vnum(struct op* op) {
	return rt_nums[op->o1];
}
static double op_lvnum(struct op* op) {
	return rtl_nums[op->o1];
}

static double op_vnumael(struct op* op) {
//x
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return 0;
	}
	return *(arr->pnum + h);
}

// -------------- expressions ------------------------------------


static double op_mult(struct op* op) {
	return numf(op->o1) * numf(op->o2);
}
static double op_div(struct op* op) {
	return numf(op->o1) / numf(op->o2);
}
static double op_divi(struct op* op) {
	return floor(numf(op->o1) / numf(op->o2));
}
static double op_add(struct op* op) {
	return numf(op->o1) + numf(op->o2);
}
static double op_sub(struct op* op) {
	return numf(op->o1) - numf(op->o2);
}
static double op_mod(struct op* op) {
	double a = numf(op->o1);
	double b = numf(op->o2);
	double r = fmod(a, b);
	if (r < 0) r += b;		// make it positive, as in Julia, Python
	return r;
}
static double op_mod1(struct op* op) {	// as in Julia
	double a = numf(op->o1) - 1;
	double b = numf(op->o2);
	double r = fmod(a, b);
	if (r < 0) r += b;
	return r + 1;
}
static double op_divi1(struct op* op) {	// as in Julia fld1
	double a = numf(op->o1) - 1;
	double b = numf(op->o2);
	return floor(a / b) + 1;
}

// ------------------------------------

static double op_bitand(struct op* op) {
	uint a = (long long)numf(op->o1);
	uint b = (long long)numf(op->o2);
	return a & b;
}
static double op_bitor(struct op* op) {
	uint a = (long long)numf(op->o1);
	uint b = (long long)numf(op->o2);
	return a | b;
}
static double op_bitxor(struct op* op) {
	uint a = (long long)numf(op->o1);
	uint b = (long long)numf(op->o2);
	return a ^ b;
}
static double op_bitnot(struct op* op) {
	uint a = (long long)numf(op->o1);
	return ~a;
}
static double op_bitshift(struct op* op) {
	uint a = (long long)numf(op->o1);
	int b = numf(op->o2);
	if (b >= 0) return a << b;
	else return a >> (-b);
}
// ------------------------------------

static double time_start;

static struct str str_sysfunc(struct str* s) {

	struct str r;
	str_init(&r);
	const char* p = str_ptr(s);
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
	else if (strcmp(p, "time") == 0) {
		char buf[16];
		sprintf(buf, "%.2f", sys_time() - time_start);
		str_append(&r, buf);
	}
	else if (strcmp(p, "created by") == 0) {
		str_init_const(&r, "\0christof.kaser@gmail.com");
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
		int h = atoi(p + 4);
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
	return r;
}

static struct str op_lstr(struct op* op) {
	uint ind = op->str;
	struct str r;
	str_init_const(&r, cstrs_p + ind);
	return r;
}

static struct str op_numstr(struct op* op) {
	return str_numfx(numf(op->o1), rt.num_scale, rt.num_space);
}

static struct str op_numarrstr(struct op* op) {
	struct str str;
	str_init(&str);
	str_append(&str, "[ ");
	struct arr arr = arrf(op->o1);
	for (int i = 0; i < arr.len; i++) {
		double f = arr.pnum[i];
		struct str s = str_numfx(f, rt.num_scale, rt.num_space);
		str_append(&str, str_ptr(&s));
		str_free(&s);
		str_append(&str, " ");
	}
	free(arr.pnum);
	str_append(&str, "]");
	return str;
}

static struct str op_strarrstr(struct op* op) {
	struct str str;
	str_init(&str);
	str_append(&str, "[ ");
	struct arr arr = arrf(op->o1);
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

static struct str op_join(struct op* op) {
	struct str str;
	str_init(&str);

	struct arr arr = arrf(op->o1);
	for (int i = 0; i < arr.len; i++) {
		str_append(&str, str_ptr(arr.pstr + i));
		str_free(arr.pstr + i);
	}
	free(arr.pstr);

	return str;
}
static void xnumarrarrstr(struct str* str, struct arr* a) {
	str_append(str, "[\n");
	for (int i = 0; i < a->len; i++) {
		str_append(str, " [");
		double* pf = (a->parr + i)->pnum;
		int len = (a->parr + i)->len;
		for (int j = 0; j < len; j++) {
			struct str s = str_numfx(pf[j], rt.num_scale, rt.num_space);
			str_append(str, " ");
			str_append(str, str_ptr(&s));
			str_free(&s);
		}
		str_append(str, " ]\n");
	}
	str_append(str, "]");
}

static struct str op_numarrarrstr(struct op* op) {
	struct str str;
	str_init(&str);
	struct arr* a = garr(op->o1);
	xnumarrarrstr(&str, a);
	return str;
}

static void xstrarrarrstr(struct str* str, struct arr* a) {
	str_append(str, "[\n");
	for (int i = 0; i < a->len; i++) {
		str_append(str, " [");
		struct str* p = (a->parr + i)->pstr;
		int len = (a->parr + i)->len;
		for (int j = 0; j < len; j++) {
			str_append(str, " \"");
			str_append(str, str_ptr(&p[j]));
			str_append(str, "\"");
		}
		str_append(str, " ]\n");
	}
	str_append(str, "]");
}

static struct str op_strarrarrstr(struct op* op) {
	struct str str;
	str_init(&str);
	struct arr* a = garr(op->o1);
	xstrarrarrstr(&str, a);
	return str;
}

static struct str op_vstr(struct op* op) {
	return str_str(rt_strs + op->o1);
}
static struct str op_lvstr(struct op* op) {
	return str_str(rtl_strs + op->o1);
}

static struct str op_vstrael(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return str("");
	}
	return str_str(arr->pstr + h);
}
static struct str op_vstraelael(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return str("");
	}
	arr = arr->parr + h;
	h = (int)numf(op->o3) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return str("");
	}
	return str_str(arr->pstr + h);
}

static struct str op_substr(struct op* op) {
	struct str s = strf(op->o1);
	struct str r = str_substr(&s, (int)numf(op->o2) - 1, (int)numf(op->o3));
	str_free(&s);
	return r;
}
static struct str op_sysfunc(struct op* op) {
	struct str s = strf(op->o1);
	struct str r = str_sysfunc(&s);
	str_free(&s);
	return r;
}

static struct str op_time_str(struct op* op) {
	struct str str;
	char buf[20];
	str_init(&str);
	time_t v =  (int)numf(op->o1);
	struct tm* tinfo = localtime(&v);
	strftime(buf, 20, "%Y-%m-%d %H:%M:%S", tinfo);
	str_append(&str, buf);
	return str;
}

static struct str op_str_chr(struct op* op) {
	struct str str;
	str_init(&str);

	int code = (int)numf(op->o1);

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

static struct str op_keyb_key(struct op* op) {
	struct str r = str(rt.key);
	return r;
}

static struct str op_stradd(struct op* op) {
	struct str s1 = strf(op->o1);
	struct str s2 = strf(op->o2);
	struct str r = str_add(&s1, &s2);
	str_free(&s1);
	str_free(&s2);
	return r;
}

// ------------------- log expr ---------------


static int op_eqf(struct op* op) {
	return numf(op->o1) == numf(op->o2);
}
static int op_neqf(struct op* op) {
	return numf(op->o1) != numf(op->o2);
}
static int op_lef(struct op* op) {
	return numf(op->o1) <= numf(op->o2);
}
static int op_ltf(struct op* op) {
	return numf(op->o1) < numf(op->o2);
}
static int op_gef(struct op* op) {
	return numf(op->o1) >= numf(op->o2);
}
static int op_gtf(struct op* op) {
	return numf(op->o1) > numf(op->o2);
}
static int op_eqs(struct op* op) {
	return op_str_compare(op) == 0;
}
static int op_neqs(struct op* op) {
	return op_str_compare(op) != 0;
}

static int op_and(struct op* op) {
	return intf(op->o1) && intf(op->o2);
}
static int op_or(struct op* op) {
	return intf(op->o1) || intf(op->o2);
}
static int op_not(struct op* op) {
	return !intf(op->o1);
}

static int op_eqarr(struct op* op) {
	struct arr a1 = arrf(op->o1);
	struct arr a2 = arrf(op->o2);
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
static int op_neqarr(struct op* op) {
	return !op_eqarr(op);
}

// ---------------------- statements -------------------------

static void op_nop(struct op* op) {
}
static void op_flass(struct op* op) {
	double* p = gnum(op->o1);
	*p = numf(op->o2);
}
static void op_flassp(struct op* op) {
	double* p = gnum(op->o1);
	*p += numf(op->o2);
}
static void op_flassm(struct op* op) {
	double* p = gnum(op->o1);
	*p -= numf(op->o2);
}
static void op_flasst(struct op* op) {
	double* p = gnum(op->o1);
	*p *= numf(op->o2);
}
static void op_flassd(struct op* op) {
	double* p = gnum(op->o1);
	*p /= numf(op->o2);
}

static void op_strass(struct op* op) {
	struct str s = strf(op->o2);
	struct str* ps = gstr(op->o1);
	str_free(ps);
	*ps = s;
}

static void op_strassp(struct op* op) {
	struct str* ps = gstr(op->o1);
	struct str s = strf(op->o2);
	str_append_str(ps, &s);
	str_free(&s);
}

static void op_flael_ass(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	*(arr->pnum + h) = numf(op->o3);
}

static void op_flael_assp(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	*(arr->pnum + h) += numf(op->o3);
}

static void op_flael_assm(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	*(arr->pnum + h) -= numf(op->o3);
}

static void op_flael_asst(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	*(arr->pnum + h) *= numf(op->o3);
}

static void op_flael_assd(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	*(arr->pnum + h) /= numf(op->o3);
}

static void op_strael_ass(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	str_free(arr->pstr + h);
	*(arr->pstr + h) = strf(op->o3);
}

static void op_strael_assp(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	struct str s = strf(op->o3);
	str_append_str(arr->pstr + h, &s);
	str_free(&s);
}

static void exec_sequ(ushort o) {

#if 0
	while (o != UMO && !stop_flag) {
		struct op* op = codp + o;
		(*(op->vf))(op);
		o = op->next;
	}
#else
	struct op* op = codp + o;
	while (op != codp + UMO && !stop_flag) {
		(*(op->vf))(op);
		op = codp + op->next;
	}
#endif
}

static void op_while(struct op* op) {
#if 0
	while (intf(op->o1)) {
		exec_sequ(op->o2);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}
#elif 0

	ushort o1 = op->o1;
	struct op* op0 = codp + op->o2;
	while (intf(o1)) {
		struct op* op = op0;
		while (op != codp + UMO) {
			(*(op->vf))(op);
			op = codp + op->next;
		}
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}
#else
	struct op* op2 = codp + op->o2;
	struct op* op1 = codp + op->o1;
	int (*f)(struct op*) = op1->intf;
	while ((*f)(op1)) {
		op = op2;
		while (op != codp + UMO && !stop_flag) {
			(*(op->vf))(op);
			op = codp + op->next;
		}
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}

#endif
}
static void op_repeat(struct op* op) {
	while (1) {
		exec_sequ(op->o2);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		if (intf(op->o1)) break;
		exec_sequ(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}
}
static void op_for(struct op* op) {
	struct op* opx = op + 1;
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = numf(opx->ox1);
#if 0
	while (*pint <= to) {
		exec_sequ(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += 1;
	}
#else
	struct op* op3 = codp + op->o3;
	while (*pint <= to) {
		struct op* o = op3;
		while (o != codp + UMO && !stop_flag) {
			(*(o->vf))(o);
			o = codp + o->next;
		}
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += 1;
	}

#endif
}
static void op_fordown(struct op* op) {
	struct op* opx = op + 1;
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = numf(opx->ox1);
	while (*pint >= to) {
		exec_sequ(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint -= 1;
	}
}
static void op_for_range(struct op* op) {
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = 0;
#if 0
	while (*pint < to) {
		exec_sequ(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += 1;
	}
#else
	struct op* op3 = codp + op->o3;
	while (*pint < to) {
		struct op* o = op3;
		while (o != codp + UMO && !stop_flag) {
			(*(o->vf))(o);
			o = codp + o->next;
		}
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += 1;
	}

#endif
}

static void op_for_to(struct op* op) {
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = 1;
	struct op* op3 = codp + op->o3;
	while (*pint <= to) {
		struct op* o = op3;
		while (o != codp + UMO && !stop_flag) {
			(*(o->vf))(o);
			o = codp + o->next;
		}
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += 1;
	}
}


static void op_for_in(struct op* op) {
	struct op* opx = op + 1;
	double* pnum = gnum(op->o1);
	double* pind = gnum(opx->ox1);
	struct arr arr = arrf(op->o2);
	*pind = 0;
	while (*pind < arr.len) {
		*pnum = arr.pnum[(uint)*pind];
		exec_sequ(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pind += 1;
	}
	free(arr.pnum);
}

static void op_forstep(struct op* op) {
	struct op* opx = op + 1;
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = numf(opx->ox1);
	double step = numf(opx->ox2);

	while (1) {
		if (step > 0 && (*pint > to)) break;
		if (step < 0 && (*pint < to)) break;
		exec_sequ(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += step;
	}
}

static void op_break(struct op* op) {
	stop_flag = op->o1;
}

static void op_if(struct op* op) {
#if 0
	if (intf(op->o1)) {
		exec_sequ(op->o2);
	}
#elif 0
	if (intf(op->o1)) {
		struct op* opx = codp + op->o2;
		while (opx != codp + UMO && !stop_flag) {
			(*(opx->vf))(opx);
			opx = codp + opx->next;
		}
	}

#else
	if (intf(op->o1)) {
		op = codp + op->o2;
		while (op != codp + UMO && !stop_flag) {
			(*(op->vf))(op);
			op = codp + op->next;
		}
	}
#endif
}
static void op_if_else(struct op* op) {
	if (intf(op->o1)) {
		exec_sequ(op->o2);
	}
	else {
		exec_sequ(op->o3);
	}
}

static void op_callsubr(struct op* op) {
	exec_sequ(op->o1);
	if (stop_flag) stop_flag -= 1;
}

static void op_print(struct op* op);

// -------------------------------------------------------

static void op_swapnum(struct op* op) {
	double* p1 = gnum(op->o1);
	double* p2 = gnum(op->o2);
	double h = *p1;
	*p1 = *p2;
	*p2 = h;
}
static void op_swapnumael(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h1 = (int)numf(op->o2) - arr->base;
	int h2 = (int)numf(op->o3) - arr->base;
	if (h1 < 0 || h1 >= arr->len || h2 < 0 || h2 >= arr->len) {
		out_of_bounds(op);
		return;
	}
	double h = *(arr->pnum + h1);
	*(arr->pnum + h1) = *(arr->pnum + h2);
	*(arr->pnum + h2) = h;
}

static void op_swapstr(struct op* op) {
	struct str* p1 = gstr(op->o1);
	struct str* p2 = gstr(op->o2);
	struct str h = *p1;
	*p1 = *p2;
	*p2 = h;
}

static void op_swapstrael(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h1 = (int)numf(op->o2) - arr->base;
	int h2 = (int)numf(op->o3) - arr->base;
	if (h1 < 0 || h1 >= arr->len || h2 < 0 || h2 >= arr->len) {
		out_of_bounds(op);
		return;
	}
	struct str h = *(arr->pstr + h1);
	*(arr->pstr + h1) = *(arr->pstr + h2);
	*(arr->pstr + h2) = h;
}

static void op_swaparr(struct op* op) {
	struct arr* a1 = garr(op->o1);
	struct arr* a2 = garr(op->o2);
	struct arr h = *a1;
	*a1 = *a2;
	*a2 = h;
}

static void op_swaparrael(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	struct arr* a1 = arr->parr + h;
	struct arr* a2 = garr(op->o3);
	struct arr tmp = *a1;
	*a1 = *a2;
	*a2 = tmp;
}

static void op_swaparraelx(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	struct arr* a1 = arr->parr + h;
	h = (int)numf(op->o3) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	struct arr* a2 = arr->parr + h;
	struct arr tmp = *a1;
	*a1 = *a2;
	*a2 = tmp;
}

// -------------------------------------------------------
static struct arr o_arrx(struct op* op, int typ, int sz) {
	struct arr* arr = garr(op->o1);

	struct arr res;
	if (typ >= ARR_AEL) {
		typ -= 3;
		int h = (int)numf(op->o2) - arr->base;
		if (h < 0 || h >= arr->len) {
			out_of_bounds(op);
			res.len = 0;
			return res;
		}
		arr = arr->parr + h;
	}

	res.len = arr->len;
	res.p = _realloc(NULL, res.len * sz);
	res.typ = typ;
	res.base = arr->base;
	if (res.p == NULL) {
		out_of_mem(op);
		res.len = 0;
	}
	for (int i = 0; i < res.len; i++) {
		if (typ == ARR_NUM) res.pnum[i] = arr->pnum[i];
		else res.pstr[i] = str_str(arr->pstr + i);
	}
	return res;
}

static struct arr op_vnumarr(struct op* op) {
	return o_arrx(op, ARR_NUM, sizeof(double));
}

static struct arr op_vnumarrael(struct op* op) {
	return o_arrx(op, ARR_AEL, sizeof(double));
}

static struct arr op_vstrarr(struct op* op) {
	return o_arrx(op, ARR_STR, sizeof(struct str));
}

static struct arr op_vstrarrael(struct op* op) {
	return o_arrx(op, ARR_AELSTR, sizeof(struct str));
}

static struct arr op_varrarr(struct op* op) {
	struct arr* arr = garr(op->o1);
	struct arr res;
	res.len = arr->len;
	res.typ = ARR_ARR;
	res.base = arr->base;
	res.p = _realloc(NULL, res.len * sizeof(struct arr));
	if (res.p == NULL) {
		out_of_mem(op);
		res.len = 0;
	}
	for (int i = 0; i < res.len; i++) {
		struct arr* a = arr->parr + i;
		struct arr r;
		r.len = a->len;
		r.typ = a->typ;
		r.base = a->base;
		if (r.typ == ARR_STR) {
			r.p = _realloc(NULL, r.len * sizeof(struct str));
		}
		else {
			r.p = _realloc(NULL, r.len * sizeof(double));
		}
		if (r.p == NULL) {
			out_of_mem(op);
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

static struct arr o_arr_init(struct op* op, int typ, int sz) {
	struct arr res;
	res.len = 0;
	res.typ = typ;
	res.base = 1;
	ushort o = op->o1;
	while (o != UMO) {
		res.len += 1;
		o = (codp + o)->next;
	}
	res.p = _realloc(NULL, res.len * sz);
//	res.p = calloc(sz, res.len);
	if (res.p == NULL) {
		out_of_mem(op);
		res.len = 0;
	}
	int i = 0;
	o = op->o1;
	while (o != UMO) {
		if (typ == ARR_NUM) res.pnum[i] = numf(o);
		else if (typ == ARR_STR) res.pstr[i] = strf(o);
		else res.parr[i] = arrf(o);
		i += 1;
		o = (codp + o)->next;
	}
	return res;
}

static struct arr op_numarr_init(struct op* op) {
	return o_arr_init(op, ARR_NUM, sizeof(double));
}
static struct arr op_strarr_init(struct op* op) {
	return o_arr_init(op, ARR_STR, sizeof(struct str));
}
static struct arr op_arrarr_init(struct op* op) {
	return o_arr_init(op, ARR_ARR, sizeof(struct arr));
}


static struct arr op_str_chars(struct op* op) {

	struct str s = strf(op->o1);
	const char* p = str_ptr(&s);

	struct arr res;
	res.len = str_ulen(p);
	res.typ = ARR_STR;
	res.base = 1;
	res.p = _realloc(NULL, res.len * sizeof(struct str));
	if (res.p == NULL) {
		out_of_mem(op);
		res.len = 0;
		return res;
	}

	uint ind = 0;
	uint i = 0;
	uint l;
	while (ind < res.len) {
		l = ulen(p[i]);
		str_init(res.pstr + ind);

		uint h = 0;
		while (h < l) {
			res.pstr[ind].d[h] = p[i + h];
			h++;
		}
		res.pstr[ind].d[h] = 0;
		i += l;
		ind++;
	}

	str_free(&s);
	return res;
}

static struct arr op_str_split(struct op* op) {

	struct str s1 = strf(op->o1);
	struct str s2 = strf(op->o2);
	const char* s2p = str_ptr(&s2);

	struct arr res;
	res.len = 0;
	res.typ = ARR_STR;
	res.base = 1;
	res.p = NULL;
	char* dup = strdup(str_ptr(&s1));
	if (dup == NULL) {
		out_of_mem(op);
		return res;
	}

	char* str = dup;
	while (1) {

		char* tk = strsep(&str, s2p);

		if (tk == NULL) break;
		res.len += 1;
		res.p = realloc(res.p, res.len * sizeof(struct str));
		if (res.p == NULL) {
			out_of_mem(op);
			res.len = 0;
			return res;
		}
		str_init(res.pstr + res.len - 1);
		str_append(res.pstr + res.len - 1, tk);
	}
	str_free(&s1);
	str_free(&s2);
	free(dup);
	return res;
}


static void op_strarr_ass(struct op* op) {
	struct arr* arr = garr(op->o1);
	struct arr a = arrf(op->o2);
	if (arr->p != NULL) {
		for (int i = 0; i < arr->len; i++) {
			str_free(&arr->pstr[i]);
		}
		free(arr->p);
	}
	*arr = a;
}

// -------------------------------------------------------------------------------------

static struct str op_input(struct op* op) {
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

static void op_print(struct op* op) {
	struct str s = strf(op->o1);
	gr_print(str_ptr(&s));
	str_free(&s);
}

static void op_write(struct op* op) {
	struct str s = strf(op->o1);
	gr_write(str_ptr(&s));
	str_free(&s);
}

static void op_sys(struct op* op) {
	if (op->o1 >= 10) {
		gr_sys(op->o1);
	}
}
/*
static void op_syscmd(struct op* op) {

	struct str s = strf(op->o1);
	struct str str;

	if (strcmp(str_ptr(&s), "grid") == 0) {
		gr_sys(5);
	}
	else {
		str_init(&str);
		str_append(&str, "Invalid syscmd: ");
		str_append(&str, str_ptr(&s));
		str_append(&str, " - valid: grid");
		gr_print(str_ptr(&str));
		str_free(&str);
	}

	str_free(&s);
}
*/

//------------------------------------------------------------------

static void op_sleep(struct op* op) {
	gr_sleep(numf(op->o1));
}
static void op_timer(struct op* op) {
	gr_timer(numf(op->o1));
}
static void op_linewidth(struct op* op) {
	gr_linewidth(numf(op->o1));
}

static void op_textsize(struct op* op) {
	gr_textsize(numf(op->o1));
}
static void op_rgb(struct op* op) {
	int red = (int)(numf(op->o1) * 256);
	if (red > 255) red = 255;
	int green = (int)(numf(op->o2) * 256);
	if (green > 255) green = 255;
	int blue = (int)(numf(op->o3) * 256);
	if (blue > 255) blue = 255;
	gr_color(red, green, blue);
}

static void op_circle(struct op* op) {
	gr_circle(numf(op->o1));
}
static void op_rotate(struct op* op) {
	gr_rotate(numf(op->o1) / 180. * M_PI);
}
static void op_line(struct op* op) {
	gr_line(numf(op->o1), numf(op->o2));
}
static void op_move(struct op* op) {
	gr_move(numf(op->o1), numf(op->o2));
}
static void op_translate(struct op* op) {
	gr_translate(numf(op->o1), numf(op->o2));
}
static void op_rect(struct op* op) {
	gr_rect(numf(op->o1), numf(op->o2));
}
static void op_arc(struct op* op) {
	gr_arc(numf(op->o1), numf(op->o2), numf(op->o3));
}

static void op_text(struct op* op) {
	struct str s = strf(op->o1);
	gr_text(str_ptr(&s));
	str_free(&s);
}

static void op_polygon(struct op* op) {
	struct arr arr = arrf(op->o1);
	gr_polygon(arr.pnum, arr.len);
	free(arr.pnum);
}

static void op_curve(struct op* op) {
	struct arr arr = arrf(op->o1);
	gr_curve(arr.pnum, arr.len);
	free(arr.pnum);
}

static void op_sound(struct op* op) {
	struct arr arr = arrf(op->o1);
	gr_sound(arr.pnum, arr.len);
	free(arr.pnum);
}

/*
static double time_start;

static void op_sysfuncx(struct op* op) {
	struct str s = strf(op->o1);
	const char* p = str_ptr(&s);

	if (strcmp(p, "time") == 0) {
		char buf[16];
		sprintf(buf, "%.2f", sys_time() - time_start);
		gr_print(buf);
	}
	else if (strncmp(p, "log:", 4) == 0) {
		fprintf(stderr, "%s\n", p + 4);
	}
	else if (strncmp(p, "id:", 3) == 0) {
		int h = atoi(p + 3);
		gr_sys(h);
	}
	else {
		gr_print("sysfunc call not available");
	}
	str_free(&s);
}
*/

static void op_background(struct op* op) {
	int h = (int)numf(op->o1);
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

static void op_clear(struct op* op) {
	gr_sys(1);
}

static void op_color(struct op* op) {
	int h = (int)numf(op->o1);
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

static void op_random_seed(struct op* op) {
	int h = (int)numf(op->o1);
	srand(h);
}

static void op_numfmt(struct op* op) {
	rt.num_space = (int)numf(op->o1);
	rt.num_scale = (int)numf(op->o2);
}

static void op_mouse_cursor(struct op* op) {
	gr_mouse_cursor((int)numf(op->o1));
}


// -----------------------------------------

static void op_arr_ass(struct op* op) {
	struct arr* arr = garr(op->o1);
	struct arr a = arrf(op->o2);
	if (arr->p != NULL) free(arr->p);
	*arr = a;
}

//---------------------------

static void o_aelael_ass(struct op* op, ushort typ) {
	struct arr* arr = garr(op->o1);
	struct op* opx = codp + op->o3;
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	arr = arr->parr + h;
	h = (int)numf(opx->o1) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	if (typ == 0) {
		*(arr->pnum + h) = numf(opx->o2);
	}
	else if (typ == 2) {
		*(arr->pnum + h) += numf(opx->o2);
	}
	else if (typ == 3) {
		*(arr->pnum + h) -= numf(opx->o2);
	}
	else if (typ == 4) {
		*(arr->pnum + h) *= numf(opx->o2);
	}
	else if (typ == 5) {
		*(arr->pnum + h) /= numf(opx->o2);
	}
	else { // typ = 1
		str_free(arr->pstr + h);
		*(arr->pstr + h) = strf(opx->o2);
	}
}

static void op_flaelael_ass(struct op* op) {
	// f[i][j] = 2
	o_aelael_ass(op, 0);
}
static void op_straelael_ass(struct op* op) {
	o_aelael_ass(op, 1);
}
static void op_flaelael_assp(struct op* op) {
	o_aelael_ass(op, 2);
}
static void op_flaelael_assm(struct op* op) {
	o_aelael_ass(op, 3);
}
static void op_flaelael_asst(struct op* op) {
	o_aelael_ass(op, 4);
}
static void op_flaelael_assd(struct op* op) {
	o_aelael_ass(op, 5);
}

static void op_arrael_ass(struct op* op) {
	struct arr* arr = garr(op->o1);
	int h = (int)numf(op->o2) - arr->base;
	if (h < 0 || h >= arr->len) {
		out_of_bounds(op);
		return;
	}
	arr = arr->parr + h;
	struct arr a = arrf(op->o3);
	if (arr->p != NULL) free(arr->p);
	*arr = a;
}

//  -------------------------------------------------------------

static void exec_slow(struct op* op);
static void exec_sequ_slow(ushort sqb);

static void exsq(ushort sq) {
	if (sq != UMO) {
		if (rt.slow == 0) exec_sequ(sq);
		else exec_sequ_slow(sq);
	}
}

void evt_func(int id, const char* v) {

	if (id == 1) {
		exsq(seq.animate);
	}
	else if (id == 2) {
		exsq(seq.timer);
	}
	else if (id == 0) {
		rt.key = v;
		exsq(seq.key_down);
		rt.key = "";
	}
#ifdef __EMSCRIPTEN__
	else if (id == 3) {
		// input
		*input_str = 0;
		strncat(input_str, v, 1024);
	}
	else if (id == 4) {
		// input_cancel
		*input_str = 0;
		input_str = NULL;
	}
	else if (id >= 5 && id <= 7) {
		// debug step:31, over:32, out:33
		rt.slow = 31 + id - 5;
	}
#endif
}

void evt_mouse(int id, double x, double y) {
	if (id <= 2) {
		rt.mouse_x = x;
		rt.mouse_y = y;
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
	}
}

static void op_callfunc(struct op* op) {

	struct op* of = codp + op->o1 - 1;
	double* nums = NULL;
	struct str* strs = NULL;
	struct arr* arrs = NULL;
	byte n_num = of->bx0;
	byte n_str = of->bx1;
	byte n_arr = of->bx2;

	if (n_num) {
		nums = alloca(n_num * sizeof(double));
		memset(nums, 0, n_num * sizeof(double));
	}
	if (n_str) {
		strs = alloca(n_str * sizeof(struct str));
		memset(strs, 0, n_str * sizeof(struct str));
	}
	if (n_arr) {
		arrs = alloca(n_arr * sizeof(struct arr));
		arrs_init(arrs, n_arr);
//		memset(arrs, 0, n_arr * sizeof(struct arr));
	}
	ushort ifl = 0;
	ushort istr = 0;
	ushort iarr = 0;
	ushort o = op->o3;
	int ind = 0;
	while (o != UMO) {
		struct op* opx = codp + o;
		if (of->bx[ind] == PAR_NUM) {
			nums[ifl] = (*(opx->numf))(opx);
			ifl += 1;
		}
		else if (of->bx[ind] >= PAR_RNUM) {
			break;
		}
		else if (of->bx[ind] == PAR_STR) {
			strs[istr] = (*(opx->strf))(opx);
			istr += 1;
		}
		else { 				// PAR_ARR)
			arrs[iarr] = (*(opx->arrf))(opx);
			iarr += 1;
		}
		ind += 1;
		o = opx->next;
	}

	while (o != UMO) {
		struct op* opx = codp + o;
		byte t = of->bx[ind];
		if (t == PAR_RNUM) {
			nums[ifl] = *(gnum(opx->o1));
			ifl += 1;
		}
		else if (t == PAR_RSTR) {
			strs[istr] = *(gstr(opx->o1));
			istr += 1;
		}
		else if (t == PAR_RARR) {
			struct arr* arr = garr(opx->o1);
			arrs[iarr] = *arr;
			// otherwise problems with global arr variables
			arr->p = 0;
			arr->len = 0;
			iarr += 1;
		}
		else {
			internal_error(__LINE__);
		}
		ind += 1;
		o = opx->next;
	}

	double* rtl_nums_caller = rtl_nums;
	struct str* rtl_strs_caller = rtl_strs;
	struct arr* rtl_arrs_caller = rtl_arrs;
	rtl_nums = nums;
	rtl_strs = strs;
	rtl_arrs = arrs;

	ushort func_caller = rt.func;
	rt.func = op->o1;

	if (rt.slow == 0) exec_sequ(op->o1);
	else {
		if (rt.slow >= 32) rt.slow += 1;
		exec_sequ_slow(op->o1);
		if (rt.slow > 32) rt.slow -= 1;
	}
	rt.func = func_caller;

	ifl = 0;
	istr = 0;
	iarr = 0;

	rtl_nums = rtl_nums_caller;
	rtl_strs = rtl_strs_caller;
	rtl_arrs = rtl_arrs_caller;

	o = op->o3;
	ind = 0;
	while (o != UMO) {
		struct op* opx = codp + o;
		byte t = of->bx[ind];

		if (t == PAR_NUM) ifl += 1;
		else if (t == PAR_STR) istr += 1;
		else if (t == PAR_ARR) iarr += 1;

		else if (t == PAR_RNUM) {
			*(gnum(opx->o1)) = nums[ifl];
			ifl += 1;
		}
		else if (t == PAR_RSTR) {
			*(gstr(opx->o1)) = strs[istr];
			// don't free reference strs
			str_init(&strs[istr]);
			istr += 1;
		}
		else  {
			// PAR_RARR
			struct arr* pa = garr(opx->o1);
			if (pa->p != NULL) free(pa->p);
			*pa = arrs[iarr];
			// don't free reference arrs
			arrs[iarr].p = NULL;
			iarr += 1;
		}
		ind += 1;
		o = opx->next;
	}

	for (int is = 0; is < n_str; is++) {
		str_free(strs + is);
	}
	for (int ia = 0; ia < n_arr; ia++) {
		struct arr* a = arrs + ia;
		if (a->p) free_arr(a);
	}
	if (stop_flag) stop_flag -= 1;
}


#define sl_as(ps, s) str_append(ps, s)

static void sl_an(struct str* ps, int h) {
	struct str s = str_num(h);
	str_append(ps, str_ptr(&s));
	str_free(&s);
}
static void sl_anf(struct str* ps, double h) {
	struct str s = str_numf(h);
	str_append(ps, str_ptr(&s));
	str_free(&s);
}

static const char* vexf(ushort typ) {
	if (typ < VAR_NUMARR) return vex(typ);
	if (typ == VAR_NUMARR) return "[]";
	else if (typ == VAR_STRARR) return "$[]";
	else if (typ == VAR_NUMARRARR) return "[][]";
	else return "$[][]";
}
static void dbg_debv(struct str* ps, struct func* fu, double* nums, struct str* strs, struct arr* arrs) {

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
			struct arr* a = arrs + p->id;
			if (a->len > 1000) {
				sl_as(ps, "[ ");
				sl_an(ps, a->len);
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
				struct str str;
				str_init(&str);
				xnumarrarrstr(&str, a);
				sl_as(ps, str_ptr(&str));
			}
			else if (p->typ == VAR_STRARRARR)  {
				struct str str;
				str_init(&str);
				xstrarrarrstr(&str, a);
				sl_as(ps, str_ptr(&str));
			}
		}
		sl_as(ps, "\n");
		p += 1;
	}
}

static void dbg_outvars(void) {
	struct str s;
	str_init(&s);
	dbg_debv(&s, func_p, rt_nums, rt_strs, rt_arrs);
	struct func* f = func_p;
	while (f < func_p + func_len) {
		if (f->start == rt.func) {
			sl_as(&s, "----- Local scope -----\n");
			dbg_debv(&s, f, rtl_nums, rtl_strs, rtl_arrs);
			break;
		}
		f += 1;
	}
	sl_as(&s, "\n");
	gr_debout(str_ptr(&s));
	str_free(&s);
}

static void dbg_delay(void) {
	if (rt.slow && rt.slow < 31) {
		gr_sleep(rt.slow *  0.1);
	}
}

static void dbg_line(struct op* op) {
	if (rt.slow && rt.slow < 33) {
		int i = 0;
		while (codp + opln_p[i].o != op) i++;
		gr_debline(opln_p[i].line);
		dbg_outvars();
		if (rt.slow == 32 || rt.slow == 31) {
			gr_step();
		}
		else {
			dbg_delay();
		}
	}
}

static void dbg_dispvars(void) {
	if (rt.slow < 33) {
		dbg_outvars();
		dbg_delay();
	}
}

static void exec_sequ_slow(ushort o) {
	while (o != UMO && !stop_flag) {
		struct op* op = codp + o;
		dbg_line(op);
		exec_slow(op);
		if (op->vf != op_if && op->vf != op_if_else) dbg_dispvars();
		o = op->next;
	}
}

static void op_while_slow(struct op* op) {
	while (intf(op->o1)) {
		dbg_delay();
		exec_sequ_slow(op->o2);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		dbg_line(op);
	}
}

static void op_repeat_slow(struct op* op) {
	dbg_delay();
	struct op* op1 = codp + op->o1;
	while (1) {
		exec_sequ_slow(op->o2);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		dbg_line(op1);
		if (intf(op->o1)) break;
		dbg_delay();
		exec_sequ_slow(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
	}
}

static void op_if_slow(struct op* op) {
	dbg_delay();
	if (intf(op->o1)) {
		exec_sequ_slow(op->o2);
	}
}
static void op_if_else_slow(struct op* op) {
	dbg_delay();
	if (intf(op->o1)) {
		exec_sequ_slow(op->o2);
	}
	else {
		exec_sequ_slow(op->o3);
	}
}

static void op_callsubr_slow(struct op* op) {
	if (rt.slow >= 32) rt.slow += 1;
	exec_sequ_slow(op->o1);
	if (rt.slow > 32) rt.slow -= 1;
	if (stop_flag) stop_flag -= 1;
}

// ---------------------------------------------------
static void xop_for_slow(struct op* op, char inc) {
	struct op* opx = op + 1;
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = numf(opx->ox1);
	while (1) {
		if (inc > 0 && *pint > to) break;
		if (inc < 0 && *pint < to) break;
		dbg_delay();
		exec_sequ_slow(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += inc;
		dbg_line(op);
	}
}


static void op_for_slow(struct op* op) {
	xop_for_slow(op, 1);
}
static void op_fordown_slow(struct op* op) {
	xop_for_slow(op, -1);
}

static void op_forstep_slow(struct op* op) {
	struct op* opx = op + 1;
	double step = numf(opx->ox2);
	xop_for_slow(op, step);
}

static void op_for_range_slow(struct op* op) {
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = 0;
	while (*pint < to) {
		dbg_line(op);
		exec_sequ_slow(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += 1;
		dbg_delay();
	}
}
static void op_for_to_slow(struct op* op) {
	double to = numf(op->o2);
	double* pint = gnum(op->o1);
	*pint = 1;
	while (*pint <= to) {
		dbg_line(op);
		exec_sequ_slow(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pint += 1;
		dbg_delay();
	}
}

static void op_for_in_slow(struct op* op) {
	struct op* opx = op + 1;
	double* pnum = gnum(op->o1);
	double* pind = gnum(opx->ox1);
	struct arr arr = arrf(op->o2);
	*pind = 0;
	while (*pind < arr.len) {
		*pnum = arr.pnum[(uint)*pind];
		dbg_line(op);
		exec_sequ_slow(op->o3);
		if (stop_flag) {
			stop_flag -= 1;
			break;
		}
		*pind += 1;
		dbg_delay();
	}
	free(arr.pnum);
}

static void op_for_instr(struct op* op) {
	struct op* opx = op + 1;
	struct str* pstr = gstr(op->o1);
	double* pind = gnum(opx->ox1);
	struct arr arr = arrf(op->o2);
	*pind = 0;
	while (*pind < arr.len) {
		str_free(pstr);
		*pstr = arr.pstr[(uint)*pind];

		if (rt.slow == 0) exec_sequ(op->o3);
		else {
			dbg_line(op);
			exec_sequ_slow(op->o3);
		}
		*pind += 1;
		if (stop_flag) {
			stop_flag -= 1;
			while (*pind < arr.len) {
				str_free(arr.pstr + (uint)*pind);
				*pind += 1;
			}
			break;
		}
		dbg_delay();
	}
	free(arr.pstr);
}

static struct arr op_map_number(struct op* op) {
	struct arr arr = arrf(op->o1);

	struct arr res;
	res.len = arr.len;
	res.typ = ARR_NUM;
	res.base = arr.base;
	res.p = _realloc(NULL, res.len * sizeof(double));
	if (res.p == NULL) {
		out_of_mem(op);
		res.len = 0;
		return res;
	}
	rt.sys_error = 0;
	for (int i = 0; i < arr.len; i++) {
		struct str s = arr.pstr[i];
		char *p;
		const char *ps = str_ptr(&s);
		double d = strtod(ps, &p);
		if (p == ps || *p != 0) {
			rt.sys_error = 1;
		}
		str_free(&s);
		res.pnum[i] = d;
	}
	free(arr.pstr);
	return res;
}


static void exec_slow(struct op* op) {
	void (*vf)(struct op*) = op->vf;
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
	(*(vf))(op);
}

// ------------ exceptions ----------------

static void except(struct op* op, const char* s) {
	char b[36];
	strcpy(b, "*** ERROR: ");
	strcat(b, s);
	gr_print(b);

	if (rt.slow == 0) {
		gr_info(1);
		int line = 0;
		int i = 0;
		while (i < opln_len) {
			if (codp + opln_p[i].o == op) {
				line = opln_p[i].line;
				gr_debline(line);
				break;
			}
			i++;
		}
		dbg_outvars();
	}
	gr_exit();
}

static void out_of_bounds(struct op* op) {
	except(op, "index out of bounds");
}

static void out_of_mem(struct op* op) {
	except(op, "out of memory");
}

static void out_of_mem0(void) {
	out_of_mem(NULL);
}

// -------------------------------------------------------

static void init_rt(void) {

	int h;
	h = func_p->varcnt[0] * sizeof(double);
	rt_nums = (double*)_realloc(NULL, h);
	memset(rt_nums, 0, h);
	h = func_p->varcnt[1] * sizeof(struct str);
	rt_strs = (struct str*)_realloc(NULL, h);
	memset(rt_strs, 0, h);

	h = func_p->varcnt[2] * sizeof(struct arr);
	rt_arrs = (struct arr*)_realloc(NULL, h);
	arrs_init(rt_arrs, func_p->varcnt[2]);
//	memset(rt_arrs, 0, h);

	time_start = sys_time();

	rt.mouse_x = 0;
	rt.mouse_y = 0;

	rt.num_scale = 2;
	rt.num_space = 0;
	rt.key = "";

	rt.sys_error = 0;
	rt.func = UMO;
	out_of_memf = out_of_mem0;

	rt.input_data_pos = 0;
	stop_flag = 0;
}

static void free_rt(void) {
	free(rt_nums);
	int i;
	for (i = 0; i < func_p->varcnt[1]; i++) {
		str_free(rt_strs + i);
	}
	free(rt_strs);
	for (int ia = 0; ia < func_p->varcnt[2]; ia++) {
		free_arr(rt_arrs + ia);
	}
	free(rt_arrs);
	out_of_memf = NULL;
	parse_clean();
}

