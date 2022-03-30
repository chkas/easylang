/*	kabas.c

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns 
    "christof.kaser@gmail.com".
*/
#include "kalib.h"

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#include "kalex.h"

#include "kafunc.h"

//--------------------------------------------------------------------------------------

static void csb_tok_nt(void) {
	csb(tval);
	nexttok();
}
static void cs_tok_nt() {
	cs(tval);
	nexttok();
}
static void cs_tok_spc_nt() {
	cs(tval);
	cs_spc();
	nexttok();
}

static void csb_tok_spc_nt() {
	csb(tval);
	cs_spc();
	nexttok();
}
static void csk_tok_spc_nt() {
	if (*tval >= 'a') csb(tval);
	else cs(tval);	
	cs_spc();
	nexttok();
}

static ushort parse_ex(void);
static ushort parse_fac(void);
static ushort parse_str_ex(void);
static ushort parse_str_term(void);

static double (*numf[])(struct op*) = {
	op_sys_time, op_error, op_mouse_x, op_mouse_y, op_randomf, op_pi,
	op_random,  op_sqrt, op_logn, op_abs, op_sign, op_bitnot, op_floor, op_sin, op_cos, op_tan, op_asin, op_acos, op_atan, 
	op_atan2, op_pow, op_bitand, op_bitor, op_bitxor, op_bitshift, op_lower, op_higher,
	op_number, op_str_ord, op_str_compare
};

static void parse_numfunc(ushort o) {

	ushort h;
	csb_tok_nt();
//	if (cod) codp[o].numf = numf[tokpr - t_systime];
	if (cod) codp[o].numf = numf[tokpr - t_systime];

	if (tokpr <= t_pi) {
	}
	else if (tokpr <= t_higher) {
		int t = tokpr;
		cs_spc();
		h = parse_fac();
		codp[o].o1 = h;
		if (t >= t_atan2) {
			cs_spc();
			h = parse_fac();
			codp[o].o2 = h;
		}
	}
	else if (tokpr <= t_str_compare) {
		int t = tokpr;
		cs_spc();
		h = parse_str_term();
		codp[o].o1 = h;
		if (t == t_str_compare) {
			cs_spc();
			h = parse_str_term();
			codp[o].o2 = h;
		}
	}
}

static ushort parse_arr_ex(void);
static ushort parse_strarr_ex(void);

struct str (*strf[])(struct op*) = {
	op_input, op_sysfunc, op_keyb_key, op_str_chr, op_time_str, op_join, op_substr
};

static void parse_str_func(ushort o) {

	ushort h;
	csb_tok_nt();
	if (cod) codp[o].strf = strf[tokpr - t_input];

	if (tokpr >= t_str_chr && tokpr <= t_timestr) {
		cs_spc();
		h = parse_ex();
		codp[o].o1 = h;
	}
	else if (tokpr == t_substr) {
		cs_spc();
		h = parse_str_ex();
		codp[o].o1 = h;
		cs_spc();
		h = parse_ex();
		codp[o].o2 = h;
		cs_spc();
		h = parse_ex();
		codp[o].o3 = h;
	}
	else if (tokpr == t_sysfunc) {
		cs_spc();
		h = parse_str_ex();
		codp[o].o1 = h;
	}
	else if (tokpr == t_strjoin) {
		cs_spc();
		h = parse_strarr_ex();
		codp[o].o1 = h;
	}
}

static int is_str_factor() {
	if (tok == t_lstr) return 1;
	if (tok == t_vstr) return 1;
	if (tok == t_vstrael) return 1;
	if (is_strfunc()) return 1;
	return 0;
}

// -------------------------------------------------
static void expt(int h) {
	if (tok != h) error(token_list[h]);
}

static void expt_ntok(int h) {
	if (is_enter && tok == t_eof) {
		// autocomplete on enter
		cs(token_list[h]);
		return;
	}
	expt(h);
	cs_tok_nt();
}

static int is_num_factor() {
	if (tok == t_pal) return 1;
	if (tok == t_minus) return 1;
	if (tok == t_lnumber) return 1;
	if (tok == t_name) return 1;
	if (tok == t_vnumael) return 1;
	if (tok == t_len) return 1;
	if (tok == t_if) return 1;
	if (is_numfunc()) return 1;
	return 0;
}

static void optimize_vnumael(ushort o, ushort h) {

	if (codp[h].numf == op_vnum) {
		codp[o].numf = op_vnumael_var;
		codp[o].o2 = codp[h].o1;
		code_len -= 1;
	}
	else if (codp[h].numf == op_lvnum) {
		codp[o].numf = op_vnumael_lvar;
		codp[o].o2 = codp[h].o1;
		code_len -= 1;
	}
}
static ushort parse_log_ex();

static ushort parse_fac() {

	ushort h;
	ushort o = code_add();

	if (tok == t_lnumber) {
		double f = tvalf;
		cs_tok_nt();
		float fh = f;
		if (f == fh) {
			codp[o].numf = op_const_fl;
			codp[o].cfl = fh;
		}
		else {
			codp[o].numf = op_const_flx;
			ushort ox = code_add();
			codp[ox].cdbl = f;
		}
	}
	else if (tok == t_len) {
		csb_tok_spc_nt();
		codp[o].numf = op_arr_len;
		if (tok == t_vnumarr) {
			codp[o].o1 = parse_var(VAR_NUMARR, RD);
			csbrr();
		}
		else if (tok == t_vstrarr) {
			codp[o].o1 = parse_var(VAR_STRARR, RD);
			csbrr();
		}
		else if (tok >= t_vnumarrarr && tok <= t_vstrarrarr) {
			if (tok == t_vnumarrarr) codp[o].o1 = parse_var(VAR_NUMARRARR, RD);
			else codp[o].o1 = parse_var(VAR_STRARRARR, RD);
			expt_ntok(t_brr);
		}
		else if (tok == t_vstrael) {
			// len e$[i] vs len e$[i][]
			char s[16];
			ushort pos = code_utf8len;
			strcpy(s, tval);
			cs_tok_nt();
			cs("$[");
			h = parse_ex();
			codp[o].o2 = h;

			if (tok == t_brr) {
				// len a$[i]
				cs_tok_nt();
				codp[o].o1 = get_var(VAR_STRARR, RD, s, pos);
				codp[o].strf = op_vstrael;
				opln_add(o, fmtline);
				h = o;
				o = code_add();
				codp[o].numf = op_str_len;
				codp[o].o1 = h;

			}
			else if (tok == t_brrl) {
				// len a$[i][]
				codp[o].o1 = get_var(VAR_STRARRARR, RD, s, pos);
				codp[o].numf = op_arrarrael_len;
				opln_add(o, fmtline);
				expt_ntok(t_brrl);
				expt_ntok(t_brr);
			}
		}
		else if (tok == t_vnumael) {
			codp[o].o1 = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
			// len a[i][]
			cs(tval);
			csbrl();
			nexttok();
			codp[o].numf = op_arrarrael_len;
			h = parse_ex();
			codp[o].o2 = h;
			expt_ntok(t_brrl);
			expt_ntok(t_brr);
			opln_add(o, fmtline);
		}

		else if (is_str_factor()) {
			codp[o].numf = op_str_len;
			h = parse_str_term();
			codp[o].o1 = h;
		}
		else {
			error("array variable, string");
		}
	}
	else if (is_numfunc()) {
		parse_numfunc(o);
	} 
	else if (tok == t_name) {
		short i = parse_var(VAR_NUM, RD);
		if (i < 0) {
			codp[o].o1 = -i - 1;
			codp[o].numf = op_lvnum;
		}
		else {
			codp[o].o1 = i;
			codp[o].numf = op_vnum;
		}
	} 
	else if (tok == t_minus) {
		cs_tok_nt();
		h = parse_fac();
		codp[o].o1 = h;
		codp[o].numf = op_negf;
	} 
	else if (tok == t_pal) {
		cs_tok_nt();
		code_len -= 1;
		o = parse_ex();
		expt_ntok(t_par);
	}
	else if (tok == t_vnumael) {
		char s[16];
		strcpy(s, tval);
		ushort pos = code_utf8len;
		cs_tok_nt();
		csbrl();

		h = parse_ex();
		codp[o].o2 = h;

		if (tok == t_brr) {
			cs_tok_nt();

			if (cod) {
				codp[o].o1 = get_var(VAR_NUMARR, RD, s, pos);
				codp[o].numf = op_vnumael;
				optimize_vnumael(o, h);
			}
		}
		else if (tok == t_brrl) {
			cs_tok_nt();
			codp[o].o1 = get_var(VAR_NUMARRARR, RD, s, pos);
			codp[o].numf = op_vnumaelael;
			h = parse_ex();
			codp[o].o3 = h;
			expt_ntok(t_brr);
		}
		else {
			error("], ][");
		}
		opln_add(o, fmtline);
	}
	else if (tok == t_if) {
		csb_tok_spc_nt();
		h = parse_log_ex();
		codp[o].o1 = h;
		codp[o].numf = op_numlog;
	}
	else {
		error("number");
	}
	return o;
}


static ushort parse_termx(ushort ox) {

	ushort h;
	if (ox == UMO) ox = parse_fac();
	while (tok == t_mult || tok == t_div || tok == t_mod || tok == t_divi) {
		cs_spc();
		ushort o = code_add();
		if (cod) {
			codp[o].o1 = ox;
			if (tok == t_mult) codp[o].numf = op_mult;
			else if (tok == t_div) codp[o].numf = op_div;
			else if (tok == t_divi) codp[o].numf = op_divi;
			else codp[o].numf = op_mod;
		}
		csk_tok_spc_nt();
		h = parse_fac();
		codp[o].o2 = h;
		ox = o;
	}
	return ox;
}

static ushort parse_term() {
	return parse_termx(UMO);
}

static ushort optimize_flex(ushort ox, ushort o, ushort h) {
	double (*f)(struct op*) = codp[ox].numf;
	if ((f == op_vnum || f == op_lvnum)&& codp[h].numf == op_const_fl) {
		float val = codp[h].cfl;
		if (val >= -32767 && val <= 32767) {
			short valf = val;
			if (val == valf) {
				codp[ox].numf = op_add_vnum16;
				codp[ox].cint16 = val;
				if (codp[o].numf == op_sub) codp[ox].cint16 = -val;
				code_len -= 2;
				if (f == op_lvnum) codp[ox].numf = op_add_vnum16l;
				return ox;
			}
		}
	}
	return o;
}

static ushort parse_exx(ushort f0) {

	ushort h;
	ushort ox = parse_termx(f0);
	while (tok == t_plus || tok == t_minus) {
		cs_spc();
		ushort o = code_add();
		codp[o].o1 = ox;
		if (tok == t_plus) codp[o].numf = op_add;
		else codp[o].numf = op_sub;
		cs_tok_spc_nt();
		h = parse_term();
		if (cod) {
			codp[o].o2 = h;
//			ox = o;
			ox = optimize_flex(ox, o, h);
		}
	}
	return ox;
}
static ushort parse_ex() {
	return parse_exx(UMO);
}

static ushort parse_str_term() {

	ushort h;
	ushort o = code_add();
	if (tok == t_lstr) {
		char buf[256];
		int i = 0;
		byte esc = 0;
		while (1) {
			nextc();
			if  (c == '\"' || c == 0) break;
			if (c == '\\') {
				esc = 1;
				nextc();
				if  (c == 't') c = '\t';
				else if  (c == 'n') c = '\n';
			}
			if (i < 255) buf[i++] = c;
			else error("string too long");
		}
		buf[i] = 0;
		if (c != 0) nextc();
		cs("\"");
		if (esc == 0) csi(buf);
		else {
			char buf2[512];
			i = 0;
			int j = 0;
			while (buf[i] != 0) {
				char ch = buf[i];
				if (ch == '\t') {
					buf2[j] = '\\';
					j += 1;
					ch = 't';
				} 
				else if (ch == '\n') {
					buf2[j] = '\\';
					j += 1;
					ch = 'n';
				} 
				else if (ch == '"') {
					buf2[j] = '\\';
					j += 1;
				} 
				else if (ch == '\\') {
					buf2[j] = '\\';
					j += 1;
				} 
				buf2[j] = ch;
				j += 1;
				i += 1;
			}
			buf2[j] = 0;
			csi(buf2);
		}
		cs("\"");
		if (cod) {
			codp[o].strf = op_lstr;
			codp[o].str = cstrs_add(buf);
		}
		nexttok();
	}
	else if (tok == t_vstr) {
		short i = parse_var(VAR_STR, RD);
		if (i < 0) {
			codp[o].o1 = -i - 1;
			codp[o].strf = op_lvstr;
		}
		else {
			codp[o].o1 = i;
			codp[o].strf = op_vstr;
		}
	}
	else if (tok == t_vstrael) {
		char s[16];
		strcpy(s, tval);
		ushort pos = code_utf8len;
		cs_tok_nt();
		cs("$[");
		h = parse_ex();
		codp[o].o2 = h;

		if (tok == t_brr) {
			cs_tok_nt();
			codp[o].o1 = get_var(VAR_STRARR, RD, s, pos);
			codp[o].strf = op_vstrael;
		}
		else if (tok == t_brrl) {
			cs_tok_nt();
			codp[o].o1 = get_var(VAR_STRARRARR, RD, s, pos);
			codp[o].strf = op_vstraelael;
			h = parse_ex();
			codp[o].o3 = h;
			expt_ntok(t_brr);
		}
		else {
			error("], ][");
		}
		opln_add(o, fmtline);
	}
	else if (is_strfunc()) {
		parse_str_func(o);
	}
	else if (is_num_factor()) {
		codp[o].strf = op_numstr;
		h = parse_ex();
		codp[o].o1 = h;
	}
	else {
		error("string");
	}
	return o;
}

static ushort parse_str_ex() {

	ushort h;
	ushort ox = parse_str_term();
	while (tok == t_amp) {
		cs_spc();
		ushort o = code_add();
		codp[o].o1 = ox;
		codp[o].strf = op_stradd;
		cs_tok_spc_nt();
		h = parse_str_term();
		codp[o].o2 = h;
		ox = o;
	}
	return ox;
}

static ushort parse_log_exx(uint f0);

static void parse_str_cmp(ushort o) {
	ushort h;
	h = parse_str_ex();
	codp[o].o1 = h;
	cs_spc();
	if (tok == t_eq) codp[o].intf = op_eqs;
	else if (tok == t_neq) codp[o].intf = op_neqs;
	else error("=, <>");
	cs_tok_spc_nt();
	h = parse_str_ex();
	codp[o].o2 = h;
}

static char optimize_log(ushort tk, ushort h, ushort o) {
	if (codp[h].numf == op_vnum) {
		if (tk == t_eq) codp[o].intf = op_eqv;
		else if (tk == t_neq) codp[o].intf = op_neqv;
		else if (tk == t_lt) codp[o].intf = op_ltv;
		else if (tk == t_le) codp[o].intf = op_lev;
		else if (tk == t_gt) codp[o].intf = op_gtv;
		else codp[o].intf = op_gev;
		codp[o].o1 = codp[h].o1;
		code_len -= 1;
		return 1;
	}
	else if (codp[h].numf == op_lvnum) {
		if (tk == t_eq) codp[o].intf = op_eqvl;
		else if (tk == t_neq) codp[o].intf = op_neqvl;
		else if (tk == t_lt) codp[o].intf = op_ltvl;
		else if (tk == t_le) codp[o].intf = op_levl;
		else if (tk == t_gt) codp[o].intf = op_gtvl;
		else codp[o].intf = op_gevl;
		codp[o].o1 = codp[h].o1;
		code_len -= 1;
		return 1;
	}
	return 0;
}

static char optimize_log2(ushort tk, ushort h, ushort o) {
	if (codp[h].numf == op_vnum || codp[h].numf == op_lvnum) {
		if (tk == t_lt) tk = t_gt;
		else if (tk == t_gt) tk = t_lt;
		else if (tk == t_le) tk = t_ge;
		else if (tk == t_ge) tk = t_le;
		codp[o].o2 = codp[o].o1;
		optimize_log(tk, h, o);
		return 1;
	}
	return 0;
}

static void parse_cmp(ushort o, ushort f0) {
	ushort h;

	h = parse_exx(f0);
	codp[o].o1 = h;
	cs_spc();
	if (tok == t_lt) codp[o].intf = op_ltf;
	else if (tok == t_gt) codp[o].intf = op_gtf;
	else if (tok == t_le) codp[o].intf = op_lef;
	else if (tok == t_ge) codp[o].intf = op_gef;
	else if (tok == t_eq) codp[o].intf = op_eqf;
	else if (tok == t_neq) codp[o].intf = op_neqf;
	else error("=, <>, <, >, <=, >=");

	ushort tokx;
	char optimized;
	if (cod) {
		tokx = tok;
		if (f0 == UMO) optimized = optimize_log(tok, h, o);
	}

	cs_tok_spc_nt();
	h = parse_ex();
	
	if (cod) {
		codp[o].o2 = h;
		if (f0 == UMO && !optimized) optimize_log2(tokx, h, o);
	}
}

static ushort parse_log_termx(uint f0) {

	ushort h;
	ushort o = code_add();
	if (f0 != UMO) {
		parse_cmp(o, (ushort)f0);
	}
	else if (tok == t_not) {
		csb_tok_spc_nt();
		h = parse_log_termx(UMO);
		codp[o].o1 = h;
		codp[o].intf = op_not;
	}
	else if (tok == t_pal) {
		cs_tok_nt();
		code_len -= 1;

		if (is_str_factor()) {
			o = parse_log_ex();
			expt_ntok(t_par);
		} 
		else {
			h = parse_ex();
			if (tok == t_par) {
				cs_tok_nt();
				o = code_add();
				parse_cmp(o, h);
			}
			else {
				o = parse_log_exx(h);
				expt_ntok(t_par);
			}
		}
	}

	else if (is_str_factor()) {
		parse_str_cmp(o);
	} 
	else {
		parse_cmp(o, UMO);
	}
	return o;
}

static ushort parse_log_term() {
	return parse_log_termx(UMO);
}

static ushort parse_log_ex_andx(uint f0) {
	ushort ox = parse_log_termx(f0);
	while (tok == t_and) {
		cs_spc();
		ushort o = code_add();
		codp[o].o1 = ox;
		codp[o].intf = op_and;
		csb_tok_spc_nt();
		ushort h = parse_log_term();
		codp[o].o2 = h;
		ox = o;
	}
	return ox;
}

static ushort parse_log_ex_and() {
	return parse_log_ex_andx(UMO);
}

static ushort parse_log_exx(uint f0) {
	ushort ox = parse_log_ex_andx(f0);
	while (tok == t_or) {
		cs_spc();
		ushort o = code_add();
		codp[o].o1 = ox;
		codp[o].intf = op_or;
		csb_tok_spc_nt();
		ushort h = parse_log_ex_and();
		codp[o].o2 = h;
		ox = o;
	}
	return ox;
}

static ushort parse_log_ex() {
	return parse_log_exx(UMO);
}

static ushort parse_sequ(void);

static void stat_begin() {
	cst(tok);
	cs_spc();
	nexttok();
}

static ushort nest_block[16];

static void stat_begin_nest() {
	if (!err && sequ_level < 16) nest_block[sequ_level] = codestrln;
	cst(tok);
	cs_spc();
	nexttok();
}

static ushort parse_sequ_end(void) {
	space_add();
	ushort h = parse_sequ();
	if (tok != t_dot && tok != t_end) {
		cs_nl();
		error("<cmd>, end, .");
	}
	space_sub();
	cs_nl();
	cst(tok);
	return h;
}

static ushort parse_sequ_if(void) {
	space_add();
	ushort h = parse_sequ();
	if (tok != t_dot && tok != t_else && tok != t_elif && tok != t_end) {
		cs_nl();
		error("<cmd>, else, elif, end, .");
	}
	space_sub();
	if (tok != t_elif) { 
		cs_nl();
		if (tok == t_else) {
			if (!err && sequ_level < 16) nest_block[sequ_level] = codestrln;
		}
		cst(tok);
	}
	return h;
}

static void parse_subr(void) {

	ushort h;
	loop_level += 1;
	stat_begin_nest();
	if (tok != t_name) error_tok(t_name);
	const char* name = getn(tval);
	struct vname* p = get_vname(func_p, name, VAR_SUBR);
	if (p != NULL) error("already defined");
	p = add_vname(func_p, name, VAR_SUBR, code_utf8len);
	cs_tok_nt();
	p->id = code_len;	// could be recursive
	h = parse_sequ_end();
//kc
	if (h == UMO) p->id = UMO; // could be empty

	nexttok();
	loop_level -= 1;
}

static ushort parse_func_header(ushort mode) {

	stat_begin();
	if (tok != t_name) error_tok(t_name);
	const char* name = getn(tval);
	func = func_get(name);
	if (func != NULL) {
		if (mode == 1 && func->start == UMO) mode = 2;
		else error("already defined");
	}
	else {
		func = func_add(name);
		if (func == NULL) return UMO;
	}
	cs_tok_spc_nt();

	ushort ox;
	if (mode >= 1) {
		ox = code_add();
		func->start = code_len;	// when it's recursive
	}
	else func->start = UMO;

	int i = 0;
	char typ;
	byte ptyp;
	while (tok != t_dot) {
		if (i == 8) {
			error("max 8 parameters");
			return UMO;
		}
		if (tok == t_name) {
			lvar(VAR_NUM, 1, mode);
			typ = 'f';
			ptyp = PAR_NUM;
		}
		else if (tok == t_vstr) {
			lvar(VAR_STR, 1, mode);
			typ = 's';
			ptyp = PAR_STR;
		}
		else if (tok == t_vnumarr) {
			lvar(VAR_NUMARR, 1, mode);
			csbrr();
			typ = 'g';
			ptyp = PAR_ARR;
		}
		else if (tok == t_vstrarr) {
			lvar(VAR_STRARR, 1, mode);
			csbrr();
			typ = 't';
			ptyp = PAR_ARR;
		}
		else {
			if (is_enter && tok == t_eof) {
				cst(t_dot);
				cs_spc();
				cst(t_dot);
				space_add();
				cs_nl();
				error("");
				return UMO;
			}
			error("., string or number variable");
			return UMO;
		}
		if (mode <= 1) func->parms[i] = typ;
		else if (func->parms[i] != typ) error("funcdecl doesn't match");

		if (mode >= 1) codp[ox].bx[i] = ptyp;

		cs_spc();
		i += 1;
	}
	cst(t_dot);
	cs_spc();
	nexttok();
	while (tok != t_dot) {
		if (i == 8) {
			error("max 8 parameters");
			return UMO;
		}
		if (tok == t_name) {
			lvar(VAR_NUM, 3, mode);
			typ = 'F';
			ptyp = PAR_RNUM;
		}
		else if (tok == t_vstr) {
			lvar(VAR_STR, 3, mode);
			typ = 'S';
			ptyp = PAR_RSTR;
		}
		else if (tok == t_vnumarr) {
			lvar(VAR_NUMARR, 3, mode);
			csbrr();
			typ = 'G';
			ptyp = PAR_RARR;
		}
		else if (tok == t_vnumarrarr) {
			lvar(VAR_NUMARRARR, 3, mode);
			expt_ntok(t_brr);
			typ = 'H';
			ptyp = PAR_RARR;
		}
		else if (tok == t_vstrarr) {
			lvar(VAR_STRARR, 3, mode);
			csbrr();
			typ = 'T';
			ptyp = PAR_RARR;
		}
		else if (tok == t_vstrarrarr) {
			lvar(VAR_STRARRARR, 3, mode);
			expt_ntok(t_brr);
			typ = 'U';
			ptyp = PAR_RARR;
		}
		else {
			if (is_enter && tok == t_eof) {
				cst(t_dot);
				space_add();
				cs_nl();
				error("");
				return UMO;
			}
			error("., variable");
			return UMO;
		}
		if (mode <= 1) func->parms[i] = typ;
		else if (func->parms[i] != typ) error("funcdecl doesn't match");

		if (mode >= 1) codp[ox].bx[i] = ptyp;

		cs_spc();
		i += 1;
	}
	if (mode <= 1) func->parms[i] = 0;
	else if (func->parms[i] != 0) error("funcdecl doesn't match");

	cst(t_dot);
	nexttok();

	return ox;
}

static void parse_func(void) {

	ushort ox = parse_func_header(1);
	if (ox == UMO) return;

	ushort h = parse_sequ_end();		// can be empty (UMO)
	func->start = h;

	codp[ox].bx0 = func->varcnt[0];
	codp[ox].bx1 = func->varcnt[1];
	codp[ox].bx2 = func->varcnt[2];

	for (int i = 0; i < funcdecl_len; i++) {
		if (funcdecl[i].func_i == func - func_p) {
			ushort o = funcdecl[i].callref;
			codp[o].o1 = func->start;
		}
	}
	func = func_p;
	nexttok();
}

static void parse_funcdecl(void) {
	parse_func_header(0);
	func = func_p;
}

static void get_onref(const char* s, int* pid, ushort** psq) {
	if (strcmp(s, "mouse_down") == 0) {
		*pid = 0;
		*psq = &seq.mouse_down;
	}
	else if (strcmp(s, "animate") == 0) {
		*pid = 4;
		*psq = &seq.animate;
	}
	else if (strcmp(s, "timer") == 0) {
		*pid = 5;
		*psq = &seq.timer;
	}
	else if (strcmp(s, "mouse_up") == 0) {
		*pid = 1;
		*psq = &seq.mouse_up;
	}
	else if (strcmp(s, "mouse_move") == 0) {
		*pid = 2;
		*psq = &seq.mouse_move;
	}
	else if (strcmp(s, "key") == 0) {
		*pid = 3;
		*psq = &seq.key_down;
	}
	else if (strcmp(s, "key_down") == 0) {
		*pid = 3;
		*psq = &seq.key_down;
	}
	else {
		*psq = NULL;
	}
}

static void parse_on_stat() {
	stat_begin_nest();
	int id = 0;
	ushort* psq;
	get_onref(tval, &id, &psq);
	if (psq == NULL) {
		error("mouse_down, mouse_up, mouse_move, key, animate, timer");
		return;
	}
	else if (*psq != UMO) {
		error("already defined");
		return;
	} 
	csb_tok_nt();
	ushort sq = parse_sequ_end();
	*psq = sq;

	prog_props |= 1;
	onstats |= 1 << id;
	nexttok();
}

static ushort parse_arr_ex(void) {

	ushort h;
	ushort ex = code_add();

	if (tok == t_brl) {
		cs_tok_spc_nt();
		codp[ex].arrf = op_numarr_init;
		ushort o = ex;
		while (tok != t_brr && tok != t_brrl && tok != t_eof && !err) {
			h = parse_ex();
			codp[o].next = h;
			o = h;
			cs_spc();
		}
		if (tok == t_brrl) {
			cs("]");
			tok = t_brl;
			strcpy(tval, "[");
		}
		else expt_ntok(t_brr);
		codp[o].next = UMO;
		codp[ex].o1 = codp[ex].next;
	}
	else if (tok == t_vnumarr) {
		codp[ex].arrf = op_vnumarr;
		codp[ex].o1 = parse_var(VAR_NUMARR, RD);
		csbrr();
	}
	else if (tok == t_vnumael) {
		codp[ex].arrf = op_vnumarrael;
		codp[ex].o1 = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
		cs(tval);
		csbrl();
		nexttok();
		h = parse_ex();
		codp[ex].o2 = h;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
		opln_add(ex, fmtline);
	}
	else if (tok == t_number) {
		codp[ex].arrf = op_map_number;
		csb_tok_nt();
		cs_spc();
		h = parse_strarr_ex();
		codp[ex].o1 = h;
	}
	else error("array");
	return ex;
}

static ushort parse_arrarr_ex(void) {

	ushort h;
	ushort ex = code_add();

	if (tok == t_brl) {
		cs_tok_spc_nt();
		codp[ex].arrf = op_numarrarr_init;
		ushort o = ex;
		while (tok != t_brr && tok != t_eof && !err) {
			h = parse_arr_ex();
			codp[o].next = h;
			o = h;
			cs_spc();
		}
		expt_ntok(t_brr);
		codp[o].next = UMO;
		codp[ex].o1 = codp[ex].next;
	}
	else if (tok == t_vnumarrarr) {
		codp[ex].arrf = op_vnumarrarr;
		codp[ex].o1 = parse_var(VAR_NUMARRARR, RD);
		expt_ntok(t_brr);
	}
	else error("array array");
	return ex;
}

static ushort parse_strarr_ex(void) {

	ushort h;
	ushort ex = code_add();

	if (tok == t_brl) {
		codp[ex].arrf = op_strarr_init;
		cs_tok_spc_nt();
		ushort o = ex;
		while (tok != t_brr && tok != t_eof && !err) {
			h = parse_str_ex();
			codp[o].next = h;
			o = h;
			cs_spc();
		}
		expt_ntok(t_brr);
		codp[o].next = UMO;
		codp[ex].o1 = codp[ex].next;
	}
	else if (tok == t_vstrarr) {
		codp[ex].arrf = op_vstrarr;
		codp[ex].o1 = parse_var(VAR_STRARR, RD);
		csbrr();
	}
	else if (tok == t_vstrael) {
		codp[ex].arrf = op_vstrarrael;
		codp[ex].o1 = get_var(VAR_STRARRARR, RD, tval, code_utf8len);
		cs(tval);
		cs("$[");
		nexttok();
		h = parse_ex();
		codp[ex].o2 = h;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
		opln_add(ex, fmtline);
	}
	else if (tok == t_name && strcmp(tval, "strchars") == 0) {
		codp[ex].arrf = op_str_chars;
		csb_tok_spc_nt();
		h = parse_str_ex();
		codp[ex].o1 = h;
	}
	else if (tok == t_name && strcmp(tval, "strsplit") == 0 ) {
		codp[ex].arrf = op_str_split;
		csb_tok_spc_nt();
		h = parse_str_ex();
		codp[ex].o1 = h;
		cs_spc();
		h = parse_str_ex();
		codp[ex].o2 = h;
	}
	else error("string array");
	return ex;
}

static void parse_strarr_ass(ushort o) {

	ushort h;
	codp[o].o1 = parse_var(VAR_STRARR, WR);
	csbrrsp();
	if (tok == t_eq) {
		cs_tok_spc_nt();
		codp[o].vf = op_strarr_ass;
		h = parse_strarr_ex();
		codp[o].o2 = h;
	}
	else if (tok == t_ampeq) {
		cs_tok_spc_nt();
		codp[o].vf = op_strarr_append;
		h = parse_str_ex();
		codp[o].o2 = h;
	}
	else error("=, &=");
}

static void parse_arrarr_ass(ushort o) {

	ushort h;
	codp[o].o1 = parse_var(VAR_NUMARRARR, WR);
	expt_ntok(t_brr);
	cs_spc();

	if (tok == t_eq) {
		cs_tok_spc_nt();
		codp[o].vf = op_arrarr_ass;
		h = parse_arrarr_ex();
		codp[o].o2 = h;
	}
	else if (tok == t_ampeq) {
		cs_tok_spc_nt();
		codp[o].vf = op_arrarr_append;
		h = parse_arr_ex();
		codp[o].o2 = h;
	}
	else error("=, &=");
}

static void parse_strarrarr_ass(ushort o) {

	ushort h;
	codp[o].o1 = parse_var(VAR_STRARRARR, WR);
	expt_ntok(t_brr);
	cs_spc();

	expt_ntok(t_ampeq);
	cs_spc();
	codp[o].vf = op_arrarr_append;
	h = parse_strarr_ex();
	codp[o].o2 = h;
}

static void parse_arr_ass(ushort o) {

	ushort h;
	codp[o].o1 = parse_var(VAR_NUMARR, WR);
	csbrrsp();
	if (tok == t_eq) {
		cs_tok_spc_nt();
		codp[o].vf = op_arr_ass;
		h = parse_arr_ex();
		codp[o].o2 = h;
	}
	else if (tok == t_ampeq) {
		cs_tok_spc_nt();
		codp[o].vf = op_numarr_append;
		h = parse_ex();
		codp[o].o2 = h;
	}
	else error("=, &=");
}

static void parseael_ass(ushort o) {

	ushort h;
	char s[16];
	strcpy(s, tval);
	ushort pos = code_utf8len;
	cs_tok_nt();
	csbrl();
	h = parse_ex();
	codp[o].o2 = h;

	if (tok == t_brr) {
		//* f[i] = 2
		cs_tok_nt();
		codp[o].o1 = get_var(VAR_NUMARR, RD, s, pos);
		cs_spc();
		if (tok == t_eq) codp[o].vf = op_flael_ass;
		else if (tok == t_pleq) codp[o].vf = op_flael_assp;
		else if (tok == t_mineq) codp[o].vf = op_flael_assm;
		else if (tok == t_asteq) codp[o].vf = op_flael_asst;
		else if (tok == t_diveq) codp[o].vf = op_flael_assd;
		else error("=, +=");
		cs_tok_spc_nt();
		h = parse_ex();
		codp[o].o3 = h;
	}
	else if (tok == t_brrl) {
		cs_tok_nt();
		if (tok == t_brr) {
			//* f[i][] &= 2
			cs_tok_nt();
			codp[o].o1 = get_var(VAR_NUMARRARR, RD, s, pos);
			cs_spc();
			if (tok == t_ampeq) {
				cs_tok_spc_nt();
				codp[o].vf = op_numarrael_append;
				h = parse_ex();
				codp[o].o3 = h;
			}
			else if (tok == t_eq) {
				cs_tok_spc_nt();
				codp[o].vf = op_arrael_ass;
				h = parse_arr_ex();
				codp[o].o3 = h;
			}
			else error("&=, =");
		}
		else {
			//* f[i][j] = 2
			codp[o].vf = op_flaelael_ass;
			codp[o].o1 = get_var(VAR_NUMARRARR, RD, s, pos);
			ushort ox = code_add();
			codp[o].o3 = ox;
			h = parse_ex();
			codp[ox].o1 = h;
			expt_ntok(t_brr);
			cs_spc();

			if (tok == t_eq) codp[o].vf = op_flaelael_ass;
			else if (tok == t_pleq) codp[o].vf = op_flaelael_assp;
			else if (tok == t_mineq) codp[o].vf = op_flaelael_assm;
			else if (tok == t_asteq) codp[o].vf = op_flaelael_asst;
			else if (tok == t_diveq) codp[o].vf = op_flaelael_assd;
			else error("= += -= *= /=");
			cs_tok_spc_nt();

			h = parse_ex();
			codp[ox].o2 = h;
		}
	}
	else {
		error("], ][");
	}
}

static void parse_strael_ass(ushort o) {

	ushort h;
	char s[16];
	strcpy(s, tval);
	ushort pos = code_utf8len;
	cs_tok_nt();
	cs("$[");
	h = parse_ex();
	codp[o].o2 = h;

	if (tok == t_brr) {
		//* f$[i] = "apple"
		cs_tok_nt();
		codp[o].o1 = get_var(VAR_STRARR, RD, s, pos);
		cs_spc();
		if (tok == t_eq) codp[o].vf = op_strael_ass;
		else if (tok == t_ampeq) codp[o].vf = op_strael_assp;
		else error("=, &=");
		cs_tok_spc_nt();
		h = parse_str_ex();
		codp[o].o3 = h;
	}
	else if (tok == t_brrl) {
		cs_tok_nt();
		if (tok == t_brr) {
			//* f$[i][] &= "apple"
			cs_tok_nt();
			codp[o].o1 = get_var(VAR_STRARRARR, RD, s, pos);
			cs_spc();
			if (tok == t_ampeq) {
				cs_tok_spc_nt();
				codp[o].vf = op_strarrael_append;
				h = parse_str_ex();
				codp[o].o3 = h;
			}
			else if (tok == t_eq) {
				cs_tok_spc_nt();
				codp[o].vf = op_arrael_ass;
				h = parse_strarr_ex();
				codp[o].o3 = h;
			}
			else error("&=, =");
		}
		else {
			//* f[i][j] = "apple"
			codp[o].vf = op_straelael_ass;
			codp[o].o1 = get_var(VAR_STRARRARR, RD, s, pos);
			ushort ox = code_add();
			codp[o].o3 = ox;
			h = parse_ex();
			codp[ox].o1 = h;
			expt_ntok(t_brr);
			cs_spc();
			expt_ntok(t_eq);
			cs_spc();
			h = parse_str_ex();
			codp[ox].o2 = h;
		}
	}
	else {
		error("], ][");
	}
}


static void parse_global_stat(void) {

	if (sequ_level != 0) error("not allowed here");
	csb(tval);
	cs_spc();
	nexttok();
	while (tok != t_dot) {
		if (tok == t_name) {
			parse_var(VAR_NUM, 0);
		}
		else if (tok == t_vstr) {
			parse_var(VAR_STR, 0);
		}
		else if (tok == t_vnumarr) {
			parse_var(VAR_NUMARR, 0);
			csbrr();
		}
		else if (tok == t_vstrarr) {
			parse_var(VAR_STRARR, 0);
			csbrr();
		}
		else if (tok == t_vnumarrarr) {
			parse_var(VAR_NUMARRARR, 0);
			expt_ntok(t_brr);
		}
		else if (tok == t_vstrarrarr) {
			parse_var(VAR_STRARRARR, 0);
			expt_ntok(t_brr);
		}
		else {
			if (is_enter && tok == t_eof) {
				cst(t_dot);
				cs_nl();
				error("");
				break;
			}
			error("., variable");
			break;
		}
		cs_spc();
	}
	cst(t_dot);
	nexttok();
}

static void parse_if_stat(ushort stat) {

	ushort h;
	stat_begin_nest();
	h = parse_log_ex();
	codp[stat].o1 = h;
	h = parse_sequ_if();
	codp[stat].o2 = h;
	codp[stat].vf = op_if;

	if (tok == t_else) {
		nexttok();
		codp[stat].vf = op_if_else;
		h = parse_sequ_end();
		codp[stat].o3 = h;
	}
	else if (tok == t_elif) {
		ushort ifst;
		codp[stat].vf = op_if_else;

		while (1) {
			cs_nl();
			stat_begin_nest();
			ifst = code_add();
			opln_add(ifst, fmtline);

			codp[stat].o3 = ifst;

			codp[ifst].next = UMO;
			codp[ifst].vf = op_if;
			h = parse_log_ex();
			codp[ifst].o1 = h;
			h = parse_sequ_if();
			codp[ifst].o2 = h;

			if (tok != t_elif) break;

			codp[ifst].vf = op_if_else;
			stat = ifst;
		}
		if (tok == t_else) {
			nexttok();
			codp[ifst].vf = op_if_else;
			h = parse_sequ_end();
			codp[ifst].o3 = h;
		}
	}
	nexttok();
}

static void parse_for_stat(ushort o) {

	ushort ox;
	ushort h;
	loop_level += 1;
	stat_begin_nest();

	if (tok != t_name && tok != t_vstr) error("variable");

	if (tok == t_name) {
		codp[o].o1 = parse_var(VAR_NUM, RW);
		cs_spc();
		ushort t = 0;
		if (tok == t_name) {
			if (strcmp(tval, "range") == 0) t = 1;
			else if (strcmp(tval, "in") == 0) t = 3;
		}
		else if (tok == t_eq) t = 2;
		if (t == 0) error("=, range, in");

		if (t <= 2) {
			if (t == 2) {
				ox = code_add();
				cs_tok_spc_nt();
				h = parse_ex();
				codp[ox].ox1 = h;
				cs_spc();
				if (strcmp(tval, "to") == 0) codp[o].vf = op_for;
				else if (strcmp(tval, "downto") == 0) codp[o].vf = op_fordown; 
				else if (strcmp(tval, "step") == 0) {
					csk_tok_spc_nt();
					h = parse_ex();
					codp[ox].ox2 = h;
					cs_spc();
					codp[o].vf = op_forstep; 
					if (strcmp(tval, "to") != 0) error("to");
				}
				else error("to, downto, step");
			}
			else {
				codp[o].vf = op_for_range;
			}
			csk_tok_spc_nt();
			h = parse_ex();
			codp[o].o2 = h;
		}
		else {
			// for in
			ox = code_add();
			codp[ox].ox1 = get_var(VAR_NUM, 0, "_", code_utf8len);
			csb_tok_spc_nt();
			h = parse_arr_ex();
			codp[o].o2 = h;
			codp[o].vf = op_for_in;
		}
	}
	else  {
		codp[o].o1 = parse_var(VAR_STR, RW);
		cs_spc();
		if (tok != t_name || strcmp(tval, "in") != 0) error("in");
		ox = code_add();
		codp[ox].ox1 = get_var(VAR_NUM, 0, "_", code_utf8len);
		csb_tok_spc_nt();
		h = parse_strarr_ex();
		codp[o].o2 = h;
		codp[o].vf = op_for_instr;
	}
	h = parse_sequ_end();
	codp[o].o3 = h;
	nexttok();
	loop_level -= 1;
}

static void parse_repeat_stat(ushort o) {

	ushort h;
	loop_level += 1;
	if (!err && sequ_level < 16) nest_block[sequ_level] = codestrln;
	csb_tok_nt();
	space_add();
	h = parse_sequ();
	space_sub();
	codp[o].o2 = h;
	cs_nl();
	cs_spc();
	cs_spc();
	if (tok != t_until) error("<cmd>, until");
	stat_begin();
	h = parse_log_ex();
	codp[o].o1 = h;
	opln_add(h, fmtline);
	h = parse_sequ_end();
	codp[o].o3 = h;
	codp[o].vf = op_repeat;
	nexttok();
	loop_level -= 1;
}

static void parse_len_stat(ushort o) {

	ushort h;
	stat_begin();

	if (tok == t_vnumarr) {
		codp[o].vf = op_numarr_len;
		codp[o].o1 = parse_var(VAR_NUMARR, WR);
		csbrr();
	}
	else if (tok == t_vstrarr) {
		codp[o].vf = op_strarr_len;
		codp[o].o1 = parse_var(VAR_STRARR, WR);
		csbrr();
	}
	else if (tok >= t_vnumarrarr && tok <= t_vstrarrarr) {
		if (tok == t_vnumarrarr) {
			codp[o].o1 = parse_var(VAR_NUMARRARR, WR);
			codp[o].vf = op_arrarr_len;
		}
		else {
			codp[o].o1 = parse_var(VAR_STRARRARR, WR);
			codp[o].vf = op_arrarr_len;
		}
		expt_ntok(t_brr);
	}
	else if (tok == t_vnumael || tok == t_vstrael) {
		if (tok == t_vnumael) {
			codp[o].o1 = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
			codp[o].vf = op_arrnumarrel_len;
			cs(tval);
			csbrl();
		}
		else {
			codp[o].o1 = get_var(VAR_STRARRARR, RD, tval, code_utf8len);
			codp[o].vf = op_arrstrarrel_len;
			cs(tval);
			cs("$[");
		}
		//* len a[i][] 2
		nexttok();
		h = parse_ex();
		codp[o].o3 = h;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else error("array variable");
	cs_spc();

	h = parse_ex();
	codp[o].o2 = h;
}

static void parse_arrarr_swap(ushort o, byte arrtok, enum vartyp arrtype) {

	codp[o].vf = op_swaparr;
	codp[o].o1 = parse_var(arrtype + 2, RW);
	expt_ntok(t_brr);
	cs_spc();
	if (tok == arrtok + 2) {
		codp[o].o2 = parse_var(arrtype + 2, RW);
		expt_ntok(t_brr);
	}
	else {
		expt(arrtok);
	}
}

static void parse_arr_swap(ushort o, byte arrtok, enum vartyp arrtype) {

	ushort h;
	codp[o].vf = op_swaparr;
	codp[o].o1 = parse_var(arrtype, RW);
	csbrrsp();

	if (tok == arrtok) {
		//* swap a[] b[]
		codp[o].o2 = parse_var(arrtype, RW);
		csbrr();
	}
	else if (tok == arrtok - 2) {
		//* swap a[] b[i][]
		codp[o].vf = op_swaparrael;
		h = codp[o].o1;
		codp[o].o1 = get_var(arrtype + 2, RD, tval, code_utf8len);
		cs(tval);
		csbrl();
		nexttok();
		codp[o].o3 = h;
		h = parse_ex();
		codp[o].o2 = h;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else {
		expt(arrtok);
	}
}

static void parse_arr_swap2(ushort o, byte arrtok, enum vartyp arrtype, char* s, ushort pos) {

	codp[o].vf = op_swaparrael;
	codp[o].o1 = get_var(arrtype + 2, RW, s, pos);
	cs(tval);
	nexttok();
	expt_ntok(t_brr);
	cs_spc();

	if (tok == arrtok) {
		codp[o].o3 = parse_var(arrtype, RW);
		csbrr();
	}
	else if (tok == arrtok - 2) {
		ushort h;
		codp[o].vf = op_swaparraelx;
		h = get_var(arrtype + 2, RW, tval, code_utf8len);
		if (cod && h != codp[o].o1) error("must be the same array");
		cs(tval);
		csbrl();
		nexttok();
		h = parse_ex();
		codp[o].o3 = h;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else {
		expt(arrtok);
	}
}

static void parse_swap_stat(ushort o) {

	stat_begin();

	if (tok == t_name) {
		codp[o].vf = op_swapnum;
		codp[o].o1 = parse_var(VAR_NUM, RW);
		cs_spc();
		expt(t_name);
		codp[o].o2 = parse_var(VAR_NUM, RW);
	}
	else if (tok == t_vnumael) {
		ushort h;
		char s[16];
		ushort pos = code_utf8len;
		strcpy(s, tval);
		cs_tok_nt();
		csbrl();

		h = parse_ex();
		codp[o].o2 = h;

		if (tok == t_brr) {
			//* swap f[i] f[j]
			cs_tok_nt();
			codp[o].o1 = get_var(VAR_NUMARR, RD, s, pos);
			codp[o].vf = op_swapnumael;
			cs_spc();

			expt(t_vnumael);
			h = parse_var(VAR_NUMARR, RD);
			if (h != codp[o].o1 && cod) error("must be the same array");
			h = parse_ex();
			codp[o].o3 = h;
			expt_ntok(t_brr);
		}
		else if (tok == t_brrl) {
			parse_arr_swap2(o, t_vnumarr, VAR_NUMARR, s, pos);
		}
		else {
			expt(t_brr);
			
		}
	}
	else if (tok == t_vstr) {
		codp[o].vf = op_swapstr;
		codp[o].o1 = parse_var(VAR_STR, RW);
		cs_spc();
		expt(t_vstr);
		codp[o].o2 = parse_var(VAR_STR, RW);
	}
	else if (tok == t_vstrael) {
		ushort h;
		char s[16];
		strcpy(s, tval);
		ushort pos = code_utf8len;
		cs_tok_nt();
		cs("$[");
		h = parse_ex();
		codp[o].o2 = h;

		if (tok == t_brr) {
			// swap f$[i] f$[j]
			cs_tok_nt();
			codp[o].o1 = get_var(VAR_STRARR, RD, s, pos);
			codp[o].vf = op_swapstrael;
			cs_spc();
			expt(t_vstrael);
			h = parse_var(VAR_STRARR, RD);
			if (h != codp[o].o1 && cod) error("must be the same array");
			h = parse_ex();
			codp[o].o3 = h;
			expt_ntok(t_brr);
		}
		else if (tok == t_brrl) {
			parse_arr_swap2(o, t_vstrarr, VAR_STRARR, s, pos);
		}
		else {
			expt(t_brr);
		}
	}
// ----------------------------------------------------------------------------------------
	else if (tok >= t_vnumarr && tok <= t_vstrarr) {
		if (tok == t_vnumarr) {
			parse_arr_swap(o, t_vnumarr, VAR_NUMARR);
		}
		else {
			parse_arr_swap(o, t_vstrarr, VAR_STRARR);
		}
	}
	else if (tok >= t_vnumarrarr && tok <= t_vstrarrarr) {
		if (tok == t_vnumarrarr) {
			parse_arrarr_swap(o, t_vnumarr, VAR_NUMARR);
		}
		else {
			parse_arrarr_swap(o, t_vstrarr, VAR_STRARR);
		}
	}
// ----------------------------------------------------------------------------------------
	else error("variable");
}

static void parse_call_stat(ushort o) {

	stat_begin();
	expt(t_name);
	const char* name = getn(tval);
	struct vname* pf = get_vname(func_p, name, VAR_SUBR);
	if (pf != NULL) {
		cs_tok_nt();
		codp[o].o1 = pf->id;
		codp[o].vf = op_callsubr;
		return;
	}
	struct func* p = func_get(name);
	if (p == NULL) {
		error("not defined");
		return;
	}
	cs_tok_nt();

	codp[o].o1 = p->start;
	if (p->start == UMO) {
		funcdecl = realloc(funcdecl, sizeof(struct funcdecl) * (funcdecl_len + 1));
		funcdecl[funcdecl_len].callref = o;
		funcdecl[funcdecl_len].func_i = p - func_p;
		funcdecl_len += 1;
	}
	codp[o].vf = op_callfunc;
	ushort of = o;

	ushort i = 0;

	while (1) {
		char b = p->parms[i];
		if (b < 'a') break;
		cs_spc();
		ushort h;
		if (b == 'f') {
			h = parse_ex();
			codp[o].next = h;
			o = h;
		}
		else if (b == 's') {
			h = parse_str_ex();
			codp[o].next = h;
			o = h;
		}
		else if (b == 'g') {
			h = parse_arr_ex();
			codp[o].next = h;
			o = h;
		}
		else if (b == 't') {
			h = parse_strarr_ex();
			codp[o].next = h;
			o = h;
		}
		i += 1;
	}

	while (1) {
		char b = p->parms[i];
		if (b < 'A') break;

		cs_spc();
		ushort h = code_add();
		codp[o].next = h;
		o = h;
		if (b == 'F') {
			expt(t_name);
			codp[o].o1 = parse_var(VAR_NUM, RW);
		}
		else if (b == 'S') {
			expt(t_vstr);
			codp[o].o1 = parse_var(VAR_STR, RW);
		}
		else if (b == 'G') {
			expt(t_vnumarr);
			codp[o].o1 = parse_var(VAR_NUMARR, RW);
			csbrr();
		}
		else if (b == 'H') {
			expt(t_vnumarrarr);
			codp[o].o1 = parse_var(VAR_NUMARRARR, RW);
			expt_ntok(t_brr);
		}
		else if (b == 'T') {
			expt(t_vstrarr);
			codp[o].o1 = parse_var(VAR_STRARR, RW);
			csbrr();
		}
		else if (b == 'U') {
			expt(t_vstrarrarr);
			codp[o].o1 = parse_var(VAR_STRARRARR, RW);
			expt_ntok(t_brr);
		}
		i += 1;
	}
	codp[o].next = UMO;
	codp[of].o3 = codp[of].next;
}

static void optimize_ass(ushort ox, ushort o, ushort h) {

	void (*f)(struct op*) = codp[ox].vf;

	if (codp[h].numf == op_const_fl) {

		float val = codp[h].cfl;
		if (val >= -32767 && val <= 32767) {
			short vali = val;
			if (val == vali) {
				if (f == op_flass) {
					codp[o].vf = op_intass16;
					codp[o].cint16 = val;
					code_len -= 1;
				}
				else if (f == op_flassp) {
					codp[o].vf = op_intassp16;
					codp[o].cint16 = val;
					code_len -= 1;
				}
				else if (f == op_flassm) {
					codp[o].vf = op_intassp16;
					codp[o].cint16 = -val;
					code_len -= 1;
				}
			}
		}
	}
	else if (f == op_flass) {
		if  (codp[h].numf == op_vnum) {
			codp[o].vf = op_ass_var;
			codp[o].o2 = codp[h].o1;
			code_len -= 1;
		}
		else if (codp[h].numf == op_lvnum) {
			codp[o].vf = op_ass_lvar;
			codp[o].o2 = codp[h].o1;
			code_len -= 1;
		}
	}
}

static ushort parse_strarr_term() {

	ushort h;
	ushort o = code_add();
	if (tok == t_vnumarr) {
		codp[o].strf = op_numarrstr;
		h = parse_arr_ex();
		codp[o].o1 = h;
	}
	else if (tok == t_vstrarr) {
		codp[o].strf = op_strarrstr;
		h = parse_strarr_ex();
		codp[o].o1 = h;
	}
	else if (tok == t_vnumarrarr) {
		codp[o].strf = op_numarrstr;
		if (c == ']') {
			codp[o].strf = op_numarrarrstr;
			codp[o].o1 = parse_var(VAR_NUMARRARR, RD);
			expt_ntok(t_brr);
		}
		else {
			h = parse_arr_ex();
			codp[o].o1 = h;
		}
	}
	else {
		codp[o].strf = op_strarrstr;
		if (c == ']') {
			codp[o].strf = op_strarrarrstr;
			codp[o].o1 = parse_var(VAR_STRARRARR, RD);
			expt_ntok(t_brr);
		}
		else {
			h = parse_strarr_ex();
			codp[o].o1 = h;
		}
	}
	return o;
}

//-----------------------------------------------

static ushort parse_sequ() {

	ushort h;
	ushort sequ = UMO;
	ushort ox = 0;	// only because of "unused" warning

	while (1) {

		if (tok == t_dot || tok <= t_end) break;
		if (tok == t_eof) {
			if (is_enter) {
				cs_nl();
				error("");
			}
			break;
		}
		cs_nl();

		if (tok == t_hash) {
			parse_comment();
			nexttok();
		}
		else if (tok == t_global) {
			parse_global_stat();
		}
		else if (tok == t_prefix) {
			if (sequ_level != 0) error("not allowed here");
			if (prefix_len == 0) {
				stat_begin();
				if (tok != t_name) error_tok(t_name);
				strcpy(prefix, tval);
				prefix_len = strlen(prefix);
				cs(tval);
				nexttok();
			}
			else {
				prefix_len = 0;
				cst(tok);
				nexttok();
			}
		}
		else if (tok == t_func) {
			if (sequ_level != 0) error("not allowed here");
			loop_level += 1;
			if (!err && sequ_level < 16) nest_block[sequ_level] = codestrln;
			parse_func();
			loop_level -= 1;
		}
		else if (tok == t_subr && sequ_level == 0) {
			parse_subr();
		}
		else if (tok == t_on) {
			if (sequ_level != 0) error("not allowed here");
			parse_on_stat();
		}
		else if (tok == t_funcdecl) {
			if (sequ_level != 0) error("not allowed here");
			parse_funcdecl();
		}
		else if (tok == t_input_data) {
			if (sequ_level != 0) error("not allowed here");
			csb(tval);
			if (c != 0) cs_nl();
			parse_input_data();
			nexttok();
		}
		else {

			ushort o = code_add();
			opln_add(o, fmtline);

			if (sequ == UMO) sequ = o;
			else codp[ox].next = o;
			ox = o;

			// -----------------------------------------------------------------------
			if (tok == t_name) {
				short sh = parse_var(VAR_NUM, WR);
				cs_spc();
				codp[o].o1 = sh;
				if (tok == t_eq) codp[o].vf = op_flass;
				else if (tok == t_pleq) codp[o].vf = op_flassp;
				else if (tok == t_mineq) codp[o].vf = op_flassm;
				else if (tok == t_asteq) codp[o].vf = op_flasst;
				else if (tok == t_diveq) codp[o].vf = op_flassd;
				else error("= += -= *= /=");
				cs_tok_spc_nt();
				h = parse_ex();
				if (cod) {
					codp[o].o2 = h;
					optimize_ass(ox, o, h);
				}
			}
			else if (tok == t_if) {
				parse_if_stat(o);
			}
			else if (tok == t_while) {
				loop_level += 1;
				stat_begin_nest();
				h = parse_log_ex();
				codp[o].o1 = h;
				h = parse_sequ_end();
				codp[o].o2 = h;
				codp[o].vf = op_while;
				nexttok();
				loop_level -= 1;
			}
			else if (tok == t_repeat) {
				parse_repeat_stat(o);
			}
			else if (tok == t_for) {
				parse_for_stat(o);
			}
			else if (tok == t_call) {
				parse_call_stat(o);
			}
			else if (tok == t_len) {
				parse_len_stat(o);
			}
			else if (tok == t_vstr) {
				codp[o].o1 = parse_var(VAR_STR, WR);
				cs_spc();
				if (tok == t_eq) codp[o].vf = op_strass;
				else if (tok == t_ampeq) codp[o].vf = op_strassp;
				else error("=, &=");
				cs_tok_spc_nt();
				h = parse_str_ex();
				codp[o].o2 = h;
			}
			else if (tok >= t_vnumael && tok <= t_vstrarrarr) {
				if (tok == t_vnumael) {
					parseael_ass(o);
				} 
				else if (tok == t_vnumarr) {
					parse_arr_ass(o);
				}
				else if (tok == t_vstrarr) {
					parse_strarr_ass(o);
				} 
				else if (tok == t_vstrael) {
					parse_strael_ass(o);
				} 
				else if (tok == t_vnumarrarr) {
					parse_arrarr_ass(o);
				}
				else {
					parse_strarrarr_ass(o);
				}			
			}
			else if (tok == t_swap) {
				parse_swap_stat(o);
			}
			else if (tok == t_break) {
				if (loop_level == 0) error("not in a loop or function");
				csb_tok_nt();
				cs_spc();
				h = tvalf;
				if (tok != t_lnumber || h != tvalf) error("int number");
				if (loop_level < h) error("loop level too low");			
				cs(tval);
				codp[o].vf = op_break;
				codp[o].o1 = h;
				nexttok();
			}
			else if (tok == t_subr) {
				if (loop_level != 1 || func == func_p) error("not allowed here");
				parse_subr();
				codp[o].vf = op_nop;
			}
			// ----------------------------------------------------------------------------
			else if (tok == t_clear) {
				csb_tok_nt();
				codp[o].vf = op_clear;
				prog_props |= 1;
			}
			else if (tok >= t_print && tok <= t_curve) {
				csb_tok_spc_nt();
				if (cod) {
					if (tokpr == t_sleep) {
						codp[o].vf = op_sleep;
					}
					else if (tokpr == t_timer) {
						codp[o].vf = op_timer;
					}
					else if (tokpr == t_color) {
						codp[o].vf = op_color;
					}
					else if (tokpr == t_linewidth) {
						codp[o].vf = op_linewidth;
					}
					else if (tokpr == t_textsize) {
						codp[o].vf = op_textsize;
					}
					else if (tokpr == t_move) {
						codp[o].vf = op_move;
					}
					else if (tokpr == t_line) {
						codp[o].vf = op_line;
						prog_props |= 1;
					}
					else if (tokpr == t_rect) {
						codp[o].vf = op_rect;
						prog_props |= 1;
					}
					else if (tokpr == t_arc) {
						codp[o].vf = op_arc;
						prog_props |= 1;
					}
					else if (tokpr == t_rgb) {
						codp[o].vf = op_rgb;
					}
					else if (tokpr == t_circle) {
						codp[o].vf = op_circle;
						prog_props |= 1;
					}
					else if (tokpr == t_text) {
						codp[o].vf = op_text;
						prog_props |= 5;
					}
					else if (tokpr == t_print || tokpr == t_pr) {
						codp[o].vf = op_print;
						prog_props |= 8;
					}
					else if (tokpr == t_write) {
						codp[o].vf = op_write;
						prog_props |= 8;
					}
					else if (tokpr == t_background) {
						codp[o].vf = op_background;
					}
					else if (tokpr == t_mouse_cursor) {
						codp[o].vf = op_mouse_cursor;
					}
					else if (tokpr == t_polygon) {
						codp[o].vf = op_polygon;
						prog_props |= 1;
					}
					else if (tokpr == t_curve) {
						codp[o].vf = op_curve;
						prog_props |= 1;
					}
					else if (tokpr == t_sound) {
						codp[o].vf = op_sound;
						prog_props |= 2;
					}
					else if (tokpr == t_translate) {
						codp[o].vf = op_translate;
					}
					else if (tokpr == t_rotate) {
						codp[o].vf = op_rotate;
					}
					else if (tokpr == t_numfmt) {
						codp[o].vf = op_numfmt;
					}
					else {
						internal_error(__LINE__);
						return 0;
					}
				}
				if (tokpr == t_pr || tokpr == t_print) {
					if (tok >= t_vnumarr && tok <= t_vstrarrarr) {
						h = parse_strarr_term();
					}
					else {
						h = parse_str_ex();
					}
					codp[o].o1 = h;
				}
				else if (tokpr <= t_text || tokpr == t_sysfunc) {
					h = parse_str_ex();
					codp[o].o1 = h;
				}
				else if (tokpr <= t_arc) {
					int t = tokpr;
					h = parse_ex();
					codp[o].o1 = h;
					if (t >= t_move) {
						cs_spc();
						h = parse_ex();
						codp[o].o2 = h;
						if (t >= t_rgb) {
							cs_spc();
							h = parse_ex();
							codp[o].o3 = h;
						}
					}
				}
				else if (tokpr <= t_curve) {
					h = parse_arr_ex();
					codp[o].o1 = h;
				}
				else {
					internal_error(__LINE__);
				}
			}
			else {
				error("statement");
				break;
			}
		}
	}
	if (sequ != UMO) codp[ox].next = UMO;
	return sequ;
}

static int caret_pos;

extern int parse(const char* str, int opt, int pos) {

	syntax_high = (opt & 2);
	if (syntax_high) {
		bold1 = "<b>";
		bold2 = "</b>";
	}
	else {
		bold1 = "";
		bold2 = "";
	}
	cod = ! (opt & 4);
	is_enter = (opt & 8);

	parse_str = str;
	
	if (is_enter) pos = strlen(parse_str);		// on enter

	parse_prepare();
	nextc();
	nexttok();

	sequ_level = 0;
	fmtline = 0;
	ushort h = parse_sequ();
	if (tok != t_eof) {
		cs_nl();
		error("<cmd>");
	}
	func_p->start = h;

	if (err) { 
		// always when is_enter
		int err_pos = codestrln;

#if !defined(__EMSCRIPTEN__)
		co(" *** ");
#endif
		co(parse_str + ind_tok);
		caret_pos = code_utf8len;
		if (nestlevel_err >= 0) {
			ushort npos = nest_block[nestlevel_err];
			codestr[npos + 1] = 'u';
			char ch = codestr[npos + 4];
			if (ch == 'f') codestr[npos + 7] = 'u';
			else if (ch == 'h') codestr[npos + 10] = 'u';
			else if (ch == 'o') codestr[npos + 8] = 'u';
			else if (ch == 'l') codestr[npos + 9] = 'u';
			else if (ch == 'e') codestr[npos + 11] = 'u';
			else if (ch == 'u') codestr[npos + 9] = 'u';
			else if (ch == 'n') codestr[npos + 7] = 'u';
		}
		return err_pos + 1;
	}

	co("\n");
	if (!cod) return 0;

	func = func_p;
	while (func < func_p + func_len) {
		struct vname *p = func->vname_p;
		while (p < func->vname_p + func->vname_len) {
			if (p->typ <= VAR_NUMARRARR && p->access != RW) {
				if (p->access == RD) error_pos("never set", p->srcpos);
				else error_pos("never used", p->srcpos);
				caret_pos = code_utf8len;
				return codestrln;
			}
			p += 1;
		}
		func += 1;
	}
	caret_pos = pos;
	if (caret_pos >= code_utf8len) pos = code_utf8len;

	int mask = 1;
	if (prog_props & 8) mask |= 2;
	if ((prog_props & 1) || (prog_props & 4)) mask |= 4;

	if (seq.mouse_down != UMO || seq.mouse_up != UMO || 
			seq.mouse_move != UMO || seq.key_down != UMO ||
			seq.animate != UMO || seq.timer != UMO) {
		mask |= 8; 
	}
	return -mask;
}

extern const char* format(void) {
	codestr[codestrln] = 0;
	return codestr;
}

extern int caret(void) {
	return caret_pos;
}

extern void k_free(void) {
	free_rt();
}

static const char* progname = "";

extern int exec(int dbg, const char* args) {

	freecodestr();
	rt.args = args;
	init_rt();
	gr_init(progname, onstats | (prog_props << 6));
	rt.slow = 0;

	if (dbg) {
		rt.slow = 1 << (dbg - 1);
		exec_sequ_slow(func_p->start);
		gr_debline(0);
	}
	else {
		exec_sequ(func_p->start);
	}
#ifdef __EMSCRIPTEN__
	if (!onstats) free_rt();
#else
	gr_event_loop();
	free_rt();
#endif
	return onstats;
}

#ifdef __EMSCRIPTEN__

int main(void) {
	EM_ASM( postMessage(['started']));
	return 0;
}

#elif defined(__RUN__)

char* code = "\
for i range 5\
	print i * i\
.\
";

int main(void) {
	if (parse(code, 0, 0)) {
		exec(0, "");
//		printf("%s", format());
	}
	return 0;
}

#else

static void err_exit(void) {
	fprintf(stderr, "kabas [-f] [filename]\n");
	exit(1);
}

int main(int argc, const char* argv[]) {

	srand(time(NULL));
	int form = 0;

	int i = 1;
	int opt = 0;
	if (argc > 1 && strcmp(argv[i], "-f") == 0) {
		form = 1;
		i++;
	}
	if (argc > i + 1) err_exit();
	FILE* f = stdin;
	if (argc > i) {

		if (argv[i][0] == '-') err_exit();
		progname = argv[i];
		f = fopen(argv[i], "rb");
		if (!f) {
			fprintf(stderr, "Could not open %s\n", argv[i]);
			exit(1);
		}
	}
	char* fstr;
	if (f == stdin) {
		fstr = NULL;
		int ch;
		int len = 0;
		while (1) {
			ch = fgetc(f);
			if (ch == EOF) break;
			fstr = _realloc(fstr, len + 1);
			fstr[len++] = ch;
		}
		fstr = _realloc(fstr, len + 1);
		fstr[len] = 0;
	}
	else {
		fseek (f, 0, SEEK_END);
		int l = ftell(f);
		fseek(f, 0, SEEK_SET);
		fstr = _realloc(NULL, l + 1);
		fread(fstr, 1, l, f);
		fstr[l] = 0;
		fclose(f);
	}

	if (parse(fstr, opt, 0) >= 0) {
//		printf("----------------\n");
//		printf("%s\n", format());
		exit(1);
	}
	free(fstr);

	if (form) {
		printf("%s\n", format());
		return 0;
	}

	i++;
	int n_args = argc - i;
	struct str args;
	str_init(&args);
	if (n_args > 0) {
		for (int j = 0; j < n_args; j++) {
			if (j > 0) str_append_c(&args, '&');
			str_append(&args, argv[j + i]);
		}
	}
	exec(0, str_ptr(&args)); 
	return 0;
}

#endif

