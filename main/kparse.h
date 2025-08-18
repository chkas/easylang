/*	kparse.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

S void csb_tok_nt(void) {
	csb(tval);
	nexttok();
}
S void cs_tok_nt(void) {
	cs(tval);
	nexttok();
}
S void cs_tok_spc_nt(void) {
	cs(tval);
	cs_spc();
	nexttok();
}

S void csb_tok_spc_nt(void) {
	csb(tval);
	cs_spc();
	nexttok();
}
S void csk_tok_spc_nt(void) {
	if (*tval >= 'a') csb(tval);
	else cs(tval);
	cs_spc();
	nexttok();
}

S ND* parse_ex(void);
S ND* parse_fac(void);
S ND* parse_strex(void);
S ND* parse_strterm(void);

S double (*numf[])(ND*) = {
	op_mouse_x, op_mouse_y, op_randomf, op_sys_time, op_error, op_pi,
	op_random, op_sqrt, op_log10, op_abs, op_sign, op_bitnot, op_floor, op_sin, op_cos, op_tan, op_asin, op_acos, op_atan,
	op_atan2, op_pow, op_bitand, op_bitor, op_bitxor, op_bitshift, op_lower, op_higher,
	op_number, op_strcode, op_strpos, op_strcompare
};

S ND* parse_numfunc(void) {

	ND* nd = mknd();
	csb_tok_nt();
	nd->numf = numf[tokpr - t_mouse_x];

	if (tokpr <= t_pi) {
	}
	else if (tokpr <= t_higher) {
		int t = tokpr;
		if (tok == t_comma) cs_tok_nt();
		cs_spc();
		nd->le = parse_fac();
		if (t >= t_atan2) {
			if (tok == t_comma) cs_tok_nt();
			cs_spc();
			nd->ri = parse_fac();
		}
	}
	else if (tokpr <= t_strcompare) {
		int t = tokpr;
		cs_spc();
		nd->le = parse_strterm();
		if (t >= t_strpos) {
			if (tok == t_comma) cs_tok_nt();
			cs_spc();
			nd->ri = parse_strterm();
		}
	}
	return nd;
}

S ND* parse_numarrex(void);
S ND* parse_strarrex(void);
S ND* parse_strarrarrex(void);

struct str (*strf[])(ND*) = {
	op_input, op_sysfunc, op_keyb_key, op_strchar, op_time_str, op_strjoin, op_substr
};

S ND* parse_strfunc(void) {

	ND* nd = mknd();
	csb_tok_nt();
	nd->strf = strf[tokpr - t_input];

	if (tokpr >= t_strchar && tokpr <= t_timestr) {
		cs_spc();
		nd->le = parse_fac();
	}
	else if (tokpr == t_substr) {
		ND* ndx = mkndx();
		cs_spc();
		nd->le = parse_strex();
		cs_spc();
		nd->ri = parse_fac();
		cs_spc();
		ndx->ex = parse_fac();
	}
	else if (tokpr == t_sysfunc) {
		cs_spc();
		nd->le = parse_strex();
	}
	else if (tokpr == t_strjoin) {
		cs_spc();
		nd->le = parse_strarrex();
		cs_spc();
		nd->ri = parse_strterm();
	}
	else if (tokpr == t_keyb_key) {
		// kc
		prog_props |= 17;
	}
	return nd;
}

S int is_strfactor(void) {
	if (tok == t_lstr) return 1;
	if (tok == t_vstr) return 1;
	if (tok == t_vstrael) return 1;
	if (is_strfunc()) return 1;
	return 0;
}

// -------------------------------------------------
S void expt(int h) {
	if (tok != h) errort(h);
}

S void expt_ntok(int h) {
	if (is_enter && tok == t_eof) {
		// autocomplete on enter
		if (!is_tab) cs(tokstr[h]);
		else errort(h);
		return;
	}
	expt(h);
	cs_tok_nt();
}
S void expta(const char* s) {
	if (strcmp(tval, s) != 0) {
		if (is_enter && tok == t_eof) {
			csb(s);
			cs_spc();
			error("");
		}
		error(s);
	}
}

S int is_numfactor(void) {
	if (tok == t_pal) return 1;
	if (tok == t_minus) return 1;
	if (tok == t_lnumber) return 1;
	if (tok == t_name) return 1;
	if (tok == t_len) return 1;
	if (tok == t_if) return 1;
	if (is_numfunc()) return 1;
	if (tok == t_vnumael) return 1;
	return 0;
}

S byte in_fastfunc;

S void optimize_vnumael(ND* nd) {

	if (in_fastfunc) return;
	if (nd->ri->numf == op_lvnum) {
		nd->numf = op_vnumael_lvar;
		nd->v2 = nd->ri->v1;
	}
}

S ND* parse_log_ex(void);

S ND* parse_ex_arr(ND** ndolp) {
	ND** old = nd_doll;
	nd_doll = ndolp;
	ND* nd = parse_ex();
	nd_doll = old;
	return nd;
}

enum aeltype { AEL, ARRAEL, AELAEL };
enum functype { FUNCPROC, FUNCNUM, FUNCSTR, FUNCARR, FUNCSTRARR, FUNCARRARR  };

S int parse_vstrael(ND* nd, int aelael) {

	// e$[i] vs e$[i][j] vs e$[i][]
	char s[16];
	ushort pos = code_utf8len;
	strcpy(s, tval);
	cs_tok_nt();
	cs("$[");
	ND* ndol = NULL;
	nd->ri = parse_ex_arr(&ndol);

	int rc = AEL;
	if (tok == t_brr) {
		// a$[i]
		cs_tok_nt();
		nd->v1 = get_var(VAR_STRARR, RD, s, pos);
		nd->strf = op_vstrael;
	}

	else if (tok == t_brrl) {
		nd->v1 = get_var(VAR_STRARRARR, RD, s, pos);
		cs_tok_nt();
		if (tok == t_brr) {
			nd->arrf = op_vstrarrael;
			rc = ARRAEL;
		}
		else if (aelael) {
			ND* ndx = mknd();
			nd->strf = op_vstraelael;
			ndx->ex = nd->ri;
			nd->ri = ndx;
			ndx->ex2 = parse_ex();
			expt_ntok(t_brr);
			rc = AELAEL;
		}
	}
	else rc = -1;
	if (ndol != NULL) ndol->v1 = nd->v1;
	opline_add(nd, fmtline);
	return rc;
}

S ND* parse_lenfunc(void) {

	ND* nd = mknd();
	nd->numf = op_arrlen;
	if (tok == t_vnumarr) {
		nd->v1 = parse_var(VAR_NUMARR, RD);
		csbrr();
	}
	else if (tok == t_vstrarr) {
		nd->v1 = parse_var(VAR_STRARR, RD);
		csbrr();
	}
	else if (tok >= t_vnumarrarr && tok <= t_vstrarrarr) {
		if (tok == t_vnumarrarr) nd->v1 = parse_var(VAR_NUMARRARR, RD);
		else nd->v1 = parse_var(VAR_STRARRARR, RD);
		expt_ntok(t_brr);
	}
	else if (tok == t_vstrael) {
		// len e$[i] vs len e$[i][] vs len e$[i][j]
		int t = parse_vstrael(nd, 1);
		if (t == AEL || t == AELAEL) {
			ND* h = nd;
			nd = mknd();
			nd->numf = op_strlen;
			nd->le = h;
		}
		else if (t == ARRAEL) {
			cs_tok_nt();
			nd->numf = op_arrarrael_len;
		}
		else error("]");
	}
	else if (tok == t_vnumael) {
		// len a[i][]
		nd->v1 = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
		cs_tok_nt();
		csbrl();
		nd->numf = op_arrarrael_len;

		ND* ndol = NULL;
		nd->ri = parse_ex_arr(&ndol);
		if (ndol != NULL) ndol->v1 = nd->v1;
		opline_add(nd, fmtline);
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else if (is_strfactor()) {
		nd->numf = op_strlen;
		nd->le = parse_strterm();
	}
	else {
		errorx(ERR_VARRSTR);
	}
	return nd;
}

S ND* parse_numarrarrex(void);

S void parse_call_param(ND* nd, struct proc* p, byte isfunc) {
	csf(tval);
	nexttok();
	nd->le = p->start;
	if (p->start == NULL) {
		procdecl = realloc(procdecl, sizeof(struct procdecl) * (procdecl_len + 1));
		procdecl[procdecl_len].callref = nd;
		procdecl[procdecl_len].proc_i = p - proc_p;
		procdecl_len += 1;
	}
	ushort i = 0;
	while (1) {
		char b = p->parms[i];
		if (b == 0) break;
		cs_spc();
		if (b == 'f') {
			if (isfunc) nd->next = parse_fac();
			else nd->next = parse_ex();
			nd = nd->next;
		}
		else if (b == 's') {
			if (isfunc) nd->next = parse_strterm();
			else nd->next = parse_strex();
			nd = nd->next;
		}
		else if (b == 'g') {
			nd->next = parse_numarrex();
			nd = nd->next;
		}
		else if (b == 'h') {
			nd->next = parse_numarrarrex();
			nd = nd->next;
		}
		else if (b == 'i') {
			nd->next = parse_strarrex();
			nd = nd->next;
		}
		else if (b == 'j') {
			nd->next = parse_strarrarrex();
			nd = nd->next;
		}
		else {
			ND* h = mknd();
			nd->next = h;
			nd = h;
			if (b == 'F') {
				if (tok != t_name) errorx(ERR_V);
				nd->v1 = parse_var(VAR_NUM, RW);
			}
			else if (b == 'S') {
				expt(t_vstr);
				nd->v1 = parse_var(VAR_STR, RW);
			}
			else if (b == 'G') {
				if (tok == t_vnumarr) {
					// a[]
					nd->v1 = parse_var(VAR_NUMARR, RW);
					nd->ri = NULL;
					csbrr();
				}
				else if (tok == t_vnumael) {
					// a[i][]
					nd->v1 = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
					cs(tval);
					csbrl();
					nexttok();
	
					ND* ndol = NULL;
					nd->ri = parse_ex_arr(&ndol);
					if (ndol != NULL) ndol->v1 = nd->v1;
					expt_ntok(t_brrl);
					expt_ntok(t_brr);
				}
				else {
					expt(t_vnumarr);
				}
			}
			else if (b == 'H') {
				expt(t_vnumarrarr);
				nd->v1 = parse_var(VAR_NUMARRARR, RW);
				nd->ri = NULL;
				expt_ntok(t_brr);
			}
			else if (b == 'T') {
				expt(t_vstrarr);
				nd->v1 = parse_var(VAR_STRARR, RW);
				nd->ri = NULL;
				csbrr();
			}
			else if (b == 'U') {
				expt(t_vstrarrarr);
				nd->v1 = parse_var(VAR_STRARRARR, RW);
				nd->ri = NULL;
				expt_ntok(t_brr);
			}
		}
		if (!nd) return;
		if (tok == t_comma) cs_tok_nt();
		i += 1;
	}
	nd->next = NULL;
}

S ND* parse_callfunc(struct proc* p, byte typ) {

	ND* nd = mknd();
	nd->numf = op_callfunc;
	if (p->start && p->start->bx3 != 0) {
		nd->numf = op_fastcall;
	}
	if (typ) {
		if (typ == 1) nd->strf = op_callfunc_str;
		else nd->arrf = op_callfunc_arr;
	}
    parse_call_param(nd, p, 1);

	nd->ri = nd->next;
	return nd;
}
S byte try_call_subr(ND* nd, const char* name) {
	struct vname* pf = get_vname(proc, name, VAR_SUBR);
	if (pf == NULL && proc != proc_p) pf = get_vname(proc_p, name, VAR_SUBR);
	if (pf == NULL) {
		return 0;
	}
	csf(tval);
	nexttok();
	nd->le = pf->sstart;
	nd->vf = op_callsubr;
	return 1;
}

S void parse_call_stat(ND* nd, struct proc* p) {

/*
	if (p == NULL) {
		csb_tok_spc_nt();
		expt(t_name);

		const char* name = getn(tval);
		if (try_call_subr(nd, name)) return;
		p = proc_get(name);

		if (p == NULL || p->typ != 0) {
			error("not defined");
			return;
		}
	}
*/
	nd->vf = op_callproc;
    parse_call_param(nd, p, 0);
	nd->ri = nd->next;
}

S int parse_vnumael(ND* nd, int aelael) {
	// e[i] vs e[i][j] vs e[i][]
	int rc = AEL;
	char s[16];
	strcpy(s, tval);
	ushort pos = code_utf8len;
	cs_tok_nt();
	csbrl();
	ND* ndol = NULL;
	nd->ri = parse_ex_arr(&ndol);
	nd->numf = NULL;
	if (tok == t_brr) {
		cs_tok_nt();
		nd->numf = op_vnumael;
		nd->v1 = get_var(VAR_NUMARR, RD, s, pos);
	}
	else if (tok == t_brrl) {
		nd->v1 = get_var(VAR_NUMARRARR, RD, s, pos);
		cs_tok_nt();
		if (tok == t_brr) {
			rc = ARRAEL;
			nd->arrf = op_vnumarrael;
		}
		else {
			rc = AELAEL;
			if (aelael) {
				ND* ndx = mknd();
				nd->numf = op_vnumaelael;
				ndx->ex = nd->ri;
				nd->ri = ndx;
				ndx->ex2 = parse_ex();
				expt_ntok(t_brr);
			}
		}
	}
	else rc = -1;
	if (ndol != NULL) ndol->v1 = nd->v1;
	opline_add(nd, fmtline);
	return rc;
}

S ND* parse_fac0(void) {

	ND* nd;
	if (tok == t_lnumber) {
		nd = mknd();
		nd->cfl = tvalf;
		cs_tok_nt();
		nd->numf = op_const_fl;

	}
	else if (tok == t_name) {

		const char* name = getn(tval);
		struct proc* p = proc_get(name);
		if (p) {
			if (p->typ != 1) {
				errorx(ERR_NUMB);
				return NULL;
			}
			else nd = parse_callfunc(p, 0);
		}
		else {
			nd = mknd();
			short i = parse_var(VAR_NUM, RD);
			if (i < 0) {
				nd->v1 = -i - 1;
				nd->numf = op_vnum;
			}
			else {
				nd->v1 = i;
				nd->numf = op_lvnum;
			}
		}
	}
	else if (is_numfunc()) {
		nd = parse_numfunc();
	}
	else if (tok == t_len) {
		csb_tok_spc_nt();
		nd = parse_lenfunc();
	}
	else if (tok == t_minus) {
		nd = mknd();
		cs_tok_nt();
		ND* h = parse_fac();
		nd->le =h;
		nd->numf = op_negf;
	}
	else if (tok == t_pal) {
		cs_tok_nt();
		nd = parse_ex();
		expt_ntok(t_par);
	}
	else if (tok == t_vnumael) {
		nd = mknd();
		int t = parse_vnumael(nd, 1);
		if (t == AEL) {
			optimize_vnumael(nd);
		}
		else if (t != AELAEL) {
			errorx(ERR_BR);
		}
	}
	else if (tok == t_if) {
		nd = mknd();
		csb_tok_spc_nt();
		nd->le = parse_log_ex();
		nd->numf = op_numlog;
	}
	else if (tok == t_pal_consumed) {
		tok = tokpr;
		tokpr = t_pal;
		nd = parse_ex();
		expt_ntok(t_par);
	}
	else if (nd_doll != NULL && tok == 0 && cp == '$' && *nd_doll == NULL) {
		nd = mknd();
		cs_tok_nt();
		nd->numf = op_arrlen;
		*nd_doll = nd;
		nd_doll = NULL;
	}
	else {
		nd = NULL;
		//errorx(ERR_NUMB);
	}
	return nd;
}

S ND* parse_fac(void) {
	ND* nd = parse_fac0();
	if (nd == NULL) errorx(ERR_NUMB);
	return nd;
}

S ND* parse_termx(ND* ndx) {

	if (ndx == NULL) {
		ndx = parse_fac0();
		if (ndx == NULL) return NULL;
	}
	while (tok == t_mult || tok == t_div || (tok >= t_mod && tok <= t_divi1)) {
		cs_spc();
		ND* nd = mknd();
		if (cod) {
			nd->le = ndx;
			if (tok == t_mult) nd->numf = op_mult;
			else if (tok == t_div) nd->numf = op_div;
			else if (tok == t_divi) nd->numf = op_divi;
			else if (tok == t_mod) nd->numf = op_mod;
			else if (tok == t_divi1) nd->numf = op_divi1;
			else nd->numf = op_mod1;
		}
		csk_tok_spc_nt();
		nd->ri = parse_fac();
		ndx = nd;
	}
	return ndx;
}

S ND* parse_term(void) {
	ND* nd = parse_termx(NULL);
	if (nd == NULL) errorx(ERR_NUMB);
	return nd;
}

S void optimize_ex(ND* nd) {

	if (in_fastfunc) return;
	if (nd->le->numf == op_lvnum && nd->ri->numf == op_const_fl) {
		double d = nd->ri->cfl;
		float f = (float)d;
		if ((double)f == d) {
			if (nd->numf == op_sub) f = -f;
			nd->numf = op_add_varfl;
			nd->v1 = nd->le->v1;
			nd->cfl32 = f;
		}
	}
	else if (nd->le->numf == op_lvnum && nd->ri->numf == op_lvnum) {
		if (nd->numf == op_sub) nd->numf = op_sub_varvar;
		else nd->numf = op_add_varvar;
		nd->v1 = nd->le->v1;
		nd->v2 = nd->ri->v1;
	}
}

S ND* parse_exx(ND* nd0) {

	ND* ndx = parse_termx(nd0);
	if (ndx == NULL) return NULL;
	while (tok == t_plus || tok == t_minus) {
		cs_spc();
		ND* nd = mknd();
		nd->le = ndx;
		if (tok == t_plus) nd->numf = op_add;
		else nd->numf = op_sub;
		cs_tok_spc_nt();
		nd->ri = parse_term();
		if (cod) optimize_ex(nd);
		ndx = nd;
	}
//kc?
	//if (tok == t_eof && is_tab) pr("xx %d %d %d", parseline, fmtline , errn);
	if (tok == t_eof && is_tab && parseline == fmtline && !errn) tabinexpr = 1;
	return ndx;
}
S ND* parse_ex(void) {
	ND* nd = parse_exx(NULL);
	if (nd == NULL) errorx(ERR_NUMB);
	return nd;
}

S ND* parse_lstr(void) {
	ND* nd = mknd();
	char buf[256];
	int i = 0;
	byte esc = 0;
	while (1) {
		nextc();
		if (c == '\"' || c == 0) break;
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
		nd->strf = op_lstr;
		nd->str = cstrs_add(buf);
	}
	nexttok();
	return nd;
}

S ND* parse_numstr(void) {
	ND* nd = mknd();
	nd->strf = op_numstr;
	nd->le = parse_ex();
	return nd;
}

S ND* parse_strarr_term(void);

S ND* parse_strterm(void) {

	ND* nd = NULL;
	if (tok == t_lstr) {
		nd = parse_lstr();
	}
	else if (tok == t_vstr) {
		nd = mknd();
		short i = parse_var(VAR_STR, RD);
		if (i < 0) {
			nd->v1 = -i - 1;
			nd->strf = op_vstr;
		}
		else {
			nd->v1 = i;
			nd->strf = op_lvstr;
		}
	}
	else if (tok == t_vstrael) {
		nd = mknd();
		// e$[i] vs e$[i][] vs e$[i][j]
		int t = parse_vstrael(nd, 1);
		if (t == ARRAEL) {
			cs_tok_nt();
			ND* ndx = nd;
			nd = mknd();
			nd->strf = op_strarrstr;
			nd->le = ndx;
		}
		else if (t == -1) {
			errorx(ERR_BR);
		}
	}
	else if (is_strfunc()) {
		nd = parse_strfunc();
	}

	else if (tok == t_name) {

		const char* name = getn(tval);
		struct proc* p = proc_get(name);
		if (p) {
			if (p->typ == FUNCPROC) error("string");

			else if (p->typ == FUNCNUM) {
				nd = parse_numstr();
			}
			else if (p->typ == FUNCSTR) {
				nd = parse_callfunc(p, 1);
			}
			else if (p->typ == FUNCARR) {
				nd = mknd();
				nd->strf = op_numarrstr;
				nd->le = parse_numarrex();
			}
			else if (p->typ == FUNCSTRARR) {
				nd = mknd();
				nd->strf = op_strarrstr;
				nd->le = parse_strarrex();
			}
			else {
				nd = mknd();
				nd->strf = op_numarrarrstr;
				nd->le = parse_numarrarrex();
			}
		}
		else {
			if (strcmp(tval, "strtok") == 0 || strcmp(tval, "strsplit") == 0) {
				nd = mknd();
				nd->strf = op_strarrstr;
				nd->le = parse_strarrex();
			}
			else nd = parse_numstr();
		}
	}
	else if (tok == t_vnumael) {
		nd = mknd();
		ND* ndx = mknd();
		int t = parse_vnumael(ndx, 1);
		nd->le = ndx;
		if (t == ARRAEL) {
			cs_tok_nt();
			nd->strf = op_numarrstr;
		}
		else if (t != -1) {
			nd->strf = op_numstr;
			nd->le = parse_exx(ndx);
			if (nd->le == NULL) errorx(ERR_NUMB);
		}
		else {
			errorx(ERR_BR);
		}
	}
	else if (tok == t_pal) {
		cs_tok_nt();
		if (is_numfactor()) {
			tokpr = tok;
			tok = t_pal_consumed;
			nd = parse_numstr();
		}
		else {
			nd = parse_strex();
			expt_ntok(t_par);
		}
	}
	else if (is_numfactor()) {
		nd = parse_numstr();
	}
	else if (tok >= t_vnumarr && tok <= t_vstrarrarr) {
		nd = parse_strarr_term();
	}
	else {
		errorx(ERR_STR);
	}
	return nd;
}

S ND* parse_strex(void) {

	ND* ndx = parse_strterm();
	while (tok == t_amp) {
		cs_spc();
		ND* nd = mknd();
		nd->le = ndx;
		nd->strf = op_stradd;
		cs_tok_spc_nt();
		nd->ri = parse_strterm();
		ndx = nd;
	}
	return ndx;
}

S ND* parse_log_exx(ND* nd0);

S ND* parse_str_cmp(void) {
	ND* nd = mknd();
	nd->le = parse_strex();
	cs_spc();
	if (tok == t_eq) nd->intf = op_eqs;
	else if (tok == t_neq) nd->intf = op_neqs;
	else errorx(ERR_STRCMP);
	cs_tok_spc_nt();
	nd->ri = parse_strex();
	return nd;
}

S ND* parse_arr_cmp(void) {
	ND* nd = mknd();
	nd->le = parse_numarrex();
	cs_spc();
	if (tok == t_eq) nd->intf = op_eqarr;
	else if (tok == t_neq) nd->intf = op_neqarr;
	else errorx(ERR_STRCMP);
	cs_tok_spc_nt();
	nd->ri = parse_numarrex();
	return nd;
}

S void optimize_cmp(ND* nd) {

	if (in_fastfunc) return;
	if (nd->le->numf == op_lvnum && nd->ri->numf == op_const_fl) {
		double d = nd->ri->cfl;
		float f = (float)d;
		if ((double)f == d) {
			void* p = nd->intf;
			if (p == op_ltf) nd->intf = op_ltx;
			else if (p == op_gtf) nd->intf = op_gtx;
			else if (p == op_lef) nd->intf = op_lex;
			else if (p == op_gef) nd->intf = op_gex;
			else if (p == op_eqf) nd->intf = op_eqx;
			else nd->intf = op_neqx;
			nd->v1 = nd->le->v1;
			nd->cfl32 = f;
		}
	}
}

S ND* parse_cmp(ND* nd0) {
	ND* nd = mknd();
	nd->le = parse_exx(nd0);
	if (nd->le == NULL) return NULL;
	cs_spc();
	if (tok == t_lt) nd->intf = op_ltf;
	else if (tok == t_gt) nd->intf = op_gtf;
	else if (tok == t_le) nd->intf = op_lef;
	else if (tok == t_ge) nd->intf = op_gef;
	else if (tok == t_eq) nd->intf = op_eqf;
	else if (tok == t_neq) nd->intf = op_neqf;
	else errorx(ERR_CMP);
	cs_tok_spc_nt();
	nd->ri = parse_ex();

	if (cod) optimize_cmp(nd);
	return nd;
}

S ND* parse_log_termx(ND* nd0) {

	ND* nd;
	if (nd0) {
		nd = parse_cmp(nd0);
	}
	else if (tok == t_not) {
		nd = mknd();
		csb_tok_spc_nt();
		nd->le = parse_log_termx(NULL);
		nd->intf = op_not;
	}
	else if (tok == t_pal) {
		cs_tok_nt();

		if (is_strfactor()) {
			nd = parse_log_ex();
			expt_ntok(t_par);
		}
		else {
			ND* h = parse_ex();
			if (tok == t_par) {
				cs_tok_nt();
				nd = parse_cmp(h);
			}
			else {
				nd = parse_log_exx(h);
				expt_ntok(t_par);
			}
		}
	}
	else if (tok == t_vnumarr) {
		nd = parse_arr_cmp();
	}
	else if (is_strfactor()) {
		nd = parse_str_cmp();
	}
	else if (tok == t_name) {
		const char* name = getn(tval);
		struct proc* p = proc_get(name);
		if (p && p->typ == FUNCSTR) {
			nd = parse_str_cmp();
		}
		else if (p && p->typ == FUNCARR) {
			nd = parse_arr_cmp();
		}
		else {
			nd = parse_cmp(NULL);
		}
	}
	else {
		nd = parse_cmp(NULL);
//kc
		if (nd == NULL) errorx(ERR_NUMSTR);
	}
	return nd;
}

S ND* parse_log_term(void) {
	return parse_log_termx(NULL);
}

S ND* parse_log_ex_andx(ND* nd0) {
	ND* ndx = parse_log_termx(nd0);
	while (tok == t_and) {
		cs_spc();
		ND* nd = mknd();
		nd->le = ndx;
		nd->intf = op_and;
		csb_tok_spc_nt();
		nd->ri = parse_log_term();
		ndx = nd;
	}
	return ndx;
}

S ND* parse_log_ex_and(void) {
	return parse_log_ex_andx(NULL);
}

S ND* parse_log_exx(ND* nd0) {
	ND* ndx = parse_log_ex_andx(nd0);
	while (tok == t_or) {
		cs_spc();
		ND* nd = mknd();
		nd->le = ndx;
		nd->intf = op_or;
		csb_tok_spc_nt();
		nd->ri = parse_log_ex_and();
		ndx = nd;
	}
//kc?
	if (tok == t_eof && is_tab && parseline == fmtline) errorx(ERR_LOG);
	return ndx;
}

S ND* parse_log_ex(void) {
	return parse_log_exx(NULL);
}

S ND* parse_sequ(void);

S uint nest_block[16];

S void stat_begin_nest(void) {
	if (!errn && sequ_level < 16) nest_block[sequ_level] = codestrln;
	csb(tval);
	cs_spc();
	nexttok();
}

S ND* parse_sequ_end(void) {
	space_add();
	csnl();
	ND* nd = parse_sequ();
	if (tok != t_dot && tok != t_end) {
		if (nd || tokpr == t_hash) csnl();
		errorx(ERR_CMDE);
	}
	space_sub();
	csnl();
	cst(tok);
	return nd;
}

S ND* parse_stat();

S ND* parse_sequ_if() {
	space_add();
	csnl();
	ND* nd = parse_sequ();
	if (tok != t_dot && tok != t_else && tok != t_elif && tok != t_end) {
		if (nd || tokpr == t_hash) csnl();
		errorx(ERR_CMDEL);
	}
	space_sub();
	if (tok != t_elif) {
		csnl();
		if (tok == t_else) {
			if (!errn && sequ_level < 16) nest_block[sequ_level] = codestrln;
		}
		cst(tok);
	}
	return nd;
}
S ND* parse_sequ_stat() {
	if (tok == t_colon) {
		cs(" : ");
		nexttok();
		ND* nd = parse_stat();
		if (nd == NULL) errorx(ERR_CMD);
		nd->next = NULL;
		return nd;
	}
	return NULL;
}

S void parse_subr(void) {

	loop_level += 1;
	stat_begin_nest();
	if (tok != t_name) error_tok(t_name);
	const char* name = getn(tval);
	struct vname* p = get_vname(proc, name, VAR_SUBR);
	if (p != NULL) error("already defined");
	p = add_vname(proc, name, VAR_SUBR, code_utf8len);

	csf(tval);
	nexttok();

	p->sstart = mknd();
	ushort pind = p - proc->vname_p;

	ND* h = parse_sequ_end();
	p = proc->vname_p + pind;
	p->sstart->ex = h;
	
	nexttok();
	loop_level -= 1;
}

S int parse_proc_header(int mode, byte proctyp) {

	// mode:0 procdecl
	csb_tok_spc_nt();

	if (tok != t_name) error_tok(t_name);
	const char* name = getn(tval);
	proc = proc_get(name);
	if (proc != NULL) {
		if (mode == 1 && proc->start == NULL) {
			mode = 2;
			if (proctyp != proc->typ) goto err_declnotmatch;
			// in procdecl source position is stored here, must be cleared
			proc->varcnt[0] = 0;
		}
		else goto err_already_defined;
	}
	else {
		proc = proc_add(name);
		if (proc == NULL) return 0;
	}
	proc->typ = proctyp;

	csf(tval);
	cs_spc();
	nexttok();

	int i = 0;
	char typ;
	while (tok != t_dot) {
		if (i == 15) goto err_maxparam;
		if (tok == t_name) {
			lvar(VAR_NUM, 1, mode);
			typ = 'f';
		}
		else if (tok == t_vstr) {
			lvar(VAR_STR, 1, mode);
			typ = 's';
		}
		else if (tok == t_vnumarr) {
			lvar(VAR_NUMARR, 1, mode);
			csbrr();
			typ = 'g';
		}
		else if (tok == t_vnumarrarr) {
			lvar(VAR_NUMARRARR, 1, mode);
			expt_ntok(t_brr);
			typ = 'h';
		}
		else if (tok == t_vstrarr) {
			lvar(VAR_STRARR, 1, mode);
			csbrr();
			typ = 'i';
		}
		else if (tok == t_vstrarrarr) {
			lvar(VAR_STRARRARR, 1, mode);
			expt_ntok(t_brr);
			typ = 'j';
		}
		else if (tok == t_amp) {
			cs_tok_nt();
			//cs(tval);
			//nexttok();

			if (tok == t_name) {
				lvar(VAR_NUM, 3, mode);
				typ = 'F';
			}
			else if (tok == t_vstr) {
				lvar(VAR_STR, 3, mode);
				typ = 'S';
			}
			else if (tok == t_vnumarr) {
				lvar(VAR_NUMARR, 3, mode);
				csbrr();
				typ = 'G';
			}
			else if (tok == t_vnumarrarr) {
				lvar(VAR_NUMARRARR, 3, mode);
				expt_ntok(t_brr);
				typ = 'H';
			}
			else if (tok == t_vstrarr) {
				lvar(VAR_STRARR, 3, mode);
				csbrr();
				typ = 'T';
			}
			else if (tok == t_vstrarrarr) {
				lvar(VAR_STRARRARR, 3, mode);
				expt_ntok(t_brr);
				typ = 'U';
			}
			else {
				goto err_variable;
			}
		}
		else if (tok == t_comma) {
			nexttok();
			continue;
		}

		else {
			if (is_enter && tok == t_eof) {
				//if (proctyp == 0) {
				//	cst(t_dot);
				//	cs_spc();
				//}
				cst(t_dot);
				space_add();
				csnl();
				goto err;
			}
			goto err_variable;
		}
		if (mode <= 1) proc->parms[i] = typ;
		else if (proc->parms[i] != typ) goto err_declnotmatch;
		cs_spc();
		i += 1;
	}
	if (mode <= 1) proc->parms[i] = 0;
	else if (proc->parms[i] != 0) goto err_declnotmatch;

	cst(t_dot);
	nexttok();

	if (proctyp == 0 && tok == t_dot) nexttok();	//kc  .. -> . (delete sometime)

	return 1;

err_declnotmatch:
	error("decl doesn't match");
err_maxparam:
	error("max 15 parameters");
err_variable:
	error("., variable");
err_already_defined:
	error("already defined");
err:
	error("");
	return 0;
}

S void parse_proc(byte typ) {

	if (!parse_proc_header(1, typ)) return;

	ND* nd = mknd();
	proc->start = nd;
	nd->bx3 = 0;
	nd->bxnd = parse_sequ_end();
	nexttok();

	if (!cod) return;
	if (nd->bxnd == NULL) {
		nd->bxnd = mknd();
		nd->bxnd->vf = op_nop;
		nd->bxnd->next = NULL;
	}
	nd->bx0 = proc->varcnt[0];
	nd->bx1 = proc->varcnt[1];
	nd->bx2 = proc->varcnt[2];

	int i = 0;
	int offs = 0;
	while (proc->parms[i + offs]) {
		if (i == 8) {
			ND* h = mknd();
			h->bxnd = nd->bxnd;
			nd->bxnd = h;
			nd = h;
			offs = 8;
			i = 0;
		}
		byte ptyp;
		char typ = proc->parms[i + offs];
		if (typ == 'f') ptyp = PAR_NUM;
		else if (typ == 's') ptyp = PAR_STR;
		else if (typ >= 'g' && typ <= 'j') ptyp = PAR_ARR;

		else if (typ == 'F') ptyp = PAR_RNUM;
		else if (typ == 'S') ptyp = PAR_RSTR;
		else ptyp = PAR_RARR;
		nd->bx[i] = ptyp;
		i += 1;
	}

	for (int i = 0; i < procdecl_len; i++) {
		if (procdecl[i].proc_i == proc - proc_p) {
			ND* nd = procdecl[i].callref;
			nd->le = proc->start;
		}
	}
}

S void parse_procdecl(byte typ) {
	parse_proc_header(0, typ);
	proc->varcnt[0] = code_utf8len;
	proc = proc_p;
}

const char* evt_name[] = { "mouse_down", "mouse_up", "mouse_move", "animate", "timer", "key_down", "key_up" };

S void get_onref(const char* s, int* pid, ND*** ppsq) {
	if (strcmp(s, evt_name[0]) == 0) {
		*pid = 0;
		*ppsq = &seq.mouse_down;
	}
	else if (strcmp(s, evt_name[3]) == 0) {
		*pid = 5;
		*ppsq = &seq.animate;
	}
	else if (strcmp(s, evt_name[4]) == 0) {
		*pid = 6;
		*ppsq = &seq.timer;
	}
	else if (strcmp(s, evt_name[1]) == 0) {
		*pid = 1;
		*ppsq = &seq.mouse_up;
	}
	else if (strcmp(s, evt_name[2]) == 0) {
		*pid = 2;
		*ppsq = &seq.mouse_move;
	}
	else if (strcmp(s, evt_name[5]) == 0) {
		*pid = 3;
		*ppsq = &seq.key_down;
	}
	else if (strcmp(s, evt_name[6]) == 0) {
		*pid = 4;
		*ppsq = &seq.key_up;
	}
	else {
		*ppsq = NULL;
	}
}

S void parse_on_stat(void) {
	stat_begin_nest();
	int id = 0;
	ND** psq;
	get_onref(tval, &id, &psq);
	if (psq == NULL) {
		errorx(ERR_EVT);
		return;
	}
	else if (*psq != NULL) {
		error("already defined");
		return;
	}
	csb_tok_nt();
	*psq = parse_sequ_end();

	prog_props |= 1;
	onstats |= 1 << id;
	nexttok();
}

S ND* parse_numarrex(void) {
	if (tok == t_pal) {
		//kc
		cs_tok_nt();
		ND* nd = parse_numarrex();
		expt_ntok(t_par);
		return nd;
	}
	ND* ex = mknd();
	if (tok == t_brl) {
		cs_tok_spc_nt();
		ex->arrf = op_numarr_init;

		ND* nd = ex;
		while (tok != t_brr &&  tok != t_brrl && tok != t_eof && !errn) {
			nd->next = parse_ex();
			nd = nd->next;
			if (tok == t_comma) cs_tok_nt();
			cs_spc();
		}
		if (tok == t_brrl) {
			cs("]");
			tok = t_brl;
			strcpy(tval, "[");
		}
		else {
			if (is_tab && tok == t_eof) {
				errorx(ERR_ARREL);
			}
			else expt_ntok(t_brr);
		}
		nd->next = NULL;
		ex->le = ex->next;
	}
	else if (tok == t_vnumarr) {
		ex->arrf = op_vnumarr;
		ex->v1 = parse_var(VAR_NUMARR, RD);
		csbrr();
	}
	else if (tok == t_vnumael) {
		ex->arrf = op_vnumarrael;
		ex->v1 = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
		cs(tval);
		csbrl();
		nexttok();

		ND* ndol = NULL;
		ex->ri = parse_ex_arr(&ndol);
		if (ndol != NULL) ndol->v1 = ex->v1;

		expt_ntok(t_brrl);
		expt_ntok(t_brr);
		opline_add(ex, fmtline);
	}
	else if (tok == t_number) {
		ex->arrf = op_map_number;
		csb_tok_spc_nt();
		ex->le = parse_strarrex();
	}
	else if (tok == t_name) {
		const char* name = getn(tval);
		struct proc* p = proc_get(name);
		if (p && p->typ == FUNCARR) {
			ex = parse_callfunc(p, 2);
		}
		else goto err_arr;
	}
	else goto err_arr;
	return ex;
err_arr:
//	error("array");
	errorx(ERR_ARR);
	return ex;
}

S ND* parse_numarrarrex(void) {

	ND* ex = mknd();
	if (tok == t_brl) {
		cs_tok_spc_nt();
		ex->arrf = op_arrarr_init;
		ND* nd = ex;
		while (tok != t_brr && tok != t_eof && !errn) {
			nd->next = parse_numarrex();
			nd = nd->next;
			if (tok == t_comma) cs_tok_nt();
			cs_spc();
		}
		expt_ntok(t_brr);
		nd->next = NULL;
		ex->le = ex->next;
	}
	else if (tok == t_vnumarrarr) {
		ex->arrf = op_varrarr;
		ex->v1 = parse_var(VAR_NUMARRARR, RD);
		expt_ntok(t_brr);
	}
	else if (tok == t_name) {
		const char* name = getn(tval);
		struct proc* p = proc_get(name);
		if (p && p->typ == FUNCARRARR) {
			ex = parse_callfunc(p, 2);
		}
		else goto err_arr;
	}
	else goto err_arr;
	return ex;
err_arr:
	error("array array");
	return ex;
}

S ND* parse_strarrex(void) {

	ND* ex = mknd();
	if (tok == t_brl) {
		ex->arrf = op_strarr_init;
		cs_tok_spc_nt();
		ND* nd = ex;
		while (tok != t_brr && tok != t_eof && !errn) {
			nd->next = parse_strex();
			nd = nd->next;
			if (tok == t_comma) cs_tok_nt();
			cs_spc();
		}
		expt_ntok(t_brr);
		nd->next = NULL;
		ex->le = ex->next;
	}
	else if (tok == t_vstrarr) {
		ex->arrf = op_vstrarr;
		ex->v1 = parse_var(VAR_STRARR, RD);
		csbrr();
	}
	else if (tok == t_vstrael) {
		ex->arrf = op_vstrarrael;
		ex->v1 = get_var(VAR_STRARRARR, RD, tval, code_utf8len);
		cs(tval);
		cs("$[");
		nexttok();

		ND* ndol = NULL;
		ex->ri = parse_ex_arr(&ndol);
		if (ndol != NULL) ndol->v1 = ex->v1;

		expt_ntok(t_brrl);
		expt_ntok(t_brr);
		opline_add(ex, fmtline);
	}
	else if (tok == t_name) {
		if (strcmp(tval, "strchars") == 0) {
			ex->arrf = op_strchars;
			csb_tok_spc_nt();
			ex->le = parse_strex();
		}
		else if (strcmp(tval, "strsplit") == 0 || strcmp(tval, "strtok") == 0 ) {
			ex->arrf = op_strsplit;
			if (strcmp(tval, "strtok") == 0) ex->arrf = op_strtok;
			csb_tok_spc_nt();
			ex->le = parse_strex();
			cs_spc();
			ex->ri = parse_strex();
		}
		else  {
			const char* name = getn(tval);
			struct proc* p = proc_get(name);
			if (p && p->typ == FUNCSTRARR) {
				ex = parse_callfunc(p, 2);
			}
			else if (p && p->typ == FUNCARR) {
				ex = mknd();
				ex->arrf = op_numstrarr;
				ex->le = parse_callfunc(p, 2);
			}
			else goto err_arr;
		}
	}
	else if (tok == t_vnumarr || tok == t_vnumael) {
//?	else if (tok == t_vnumarr) {
		ex = mknd();
		ex->arrf = op_numstrarr;
		ex->le = parse_numarrex();
	}
	else goto err_arr;
	return ex;
err_arr:
	errorx(ERR_STRARR);
	return ex;
}

S ND* parse_strarrarrex(void) {

	ND* ex = mknd();
	if (tok == t_brl) {
		cs_tok_spc_nt();
		ex->arrf = op_arrarr_init;
		ND* nd = ex;
		while (tok != t_brr && tok != t_eof && !errn) {
			nd->next = parse_strarrex();
			nd = nd->next;
			if (tok == t_comma) cs_tok_nt();
			cs_spc();
		}
		expt_ntok(t_brr);
		nd->next = NULL;
		ex->le = ex->next;
	}
	else if (tok == t_vstrarrarr) {
		ex->arrf = op_varrarr;
		ex->v1 = parse_var(VAR_STRARRARR, RD);
		expt_ntok(t_brr);
	}
	else error("string array array");
	return ex;
}

S void parse_strarr_ass(ND* nd) {

	nd->v1 = parse_var(VAR_STRARR, WR);
	csbrrsp();
	if (tok == t_eq) {
		cs_tok_spc_nt();
		nd->vf = op_strarr_ass;
		nd->ri = parse_strarrex();
	}
	else if (tok == t_ampeq) {
		cs_tok_spc_nt();
		nd->vf = op_strarr_append;
		nd->ri = parse_strex();
	}
	else errorx(ERR_STRASS);
}

S void parse_arrarr_ass(ND* nd) {

	nd->v1 = parse_var(VAR_NUMARRARR, WR);
	expt_ntok(t_brr);
	cs_spc();

	if (tok == t_eq) {
		cs_tok_spc_nt();
		nd->vf = op_arrarr_ass;
		nd->ri = parse_numarrarrex();
	}
	else if (tok == t_ampeq) {
		cs_tok_spc_nt();
		nd->vf = op_arrarr_append;
		nd->ri = parse_numarrex();
	}
	else errorx(ERR_STRASS);
}

S void parse_strarrarr_ass(ND* nd) {

	nd->v1 = parse_var(VAR_STRARRARR, WR);
	expt_ntok(t_brr);
	cs_spc();

	if (tok == t_eq) {
		cs_tok_spc_nt();
		nd->vf = op_arrarr_ass;
		nd->ri = parse_strarrarrex();
	}
	else if (tok == t_ampeq) {
		cs_tok_spc_nt();
		nd->vf = op_arrarr_append;
		nd->ri = parse_strarrex();
	}
	else errorx(ERR_STRASS);
}

S void parse_arr_ass(ND* nd) {

	nd->v1 = parse_var(VAR_NUMARR, WR);
	csbrrsp();
	if (tok == t_eq) {
		cs_tok_spc_nt();
		nd->vf = op_arr_ass;
		nd->ri = parse_numarrex();
	}
	else if (tok == t_ampeq) {
		cs_tok_spc_nt();
		nd->vf = op_numarr_append;
		nd->ri = parse_ex();
	}
	else errorx(ERR_STRASS);
}

S void parseael_ass(ND* nd) {

	char s[16];
	strcpy(s, tval);
	ushort pos = code_utf8len;
	cs_tok_nt();
	csbrl();
	ND* ndx = mkndx();
	ND* ndol = NULL;
	nd->ri = parse_ex_arr(&ndol);

	if (tok == t_brr) {
		//* f[i] = 2
		cs_tok_nt();
		nd->v1 = get_var(VAR_NUMARR, RD, s, pos);
		cs_spc();
		if (tok == t_eq) nd->vf = op_flael_ass;
		else if (tok == t_pleq) nd->vf = op_flael_assp;
		else if (tok == t_mineq) nd->vf = op_flael_assm;
		else if (tok == t_asteq) nd->vf = op_flael_asst;
		else if (tok == t_diveq) nd->vf = op_flael_assd;
		else errorx(ERR_ASSIGN);
		cs_tok_spc_nt();
		ndx->ex = parse_ex();
	}
	else if (tok == t_brrl) {
		cs_tok_nt();
		if (tok == t_brr) {
			//* f[i][] &= 2
			cs_tok_nt();
			nd->v1 = get_var(VAR_NUMARRARR, RD, s, pos);
			cs_spc();
			if (tok == t_ampeq) {
				cs_tok_spc_nt();
				nd->vf = op_numarrael_append;
				ndx->ex = parse_ex();
			}
			else if (tok == t_eq) {
				cs_tok_spc_nt();
				nd->vf = op_arrael_ass;
				ndx->ex = parse_numarrex();
			}
			else errorx(ERR_STRASS);
		}
		else {
			//* f[i][j] = 2
			nd->vf = op_flaelael_ass;
			nd->v1 = get_var(VAR_NUMARRARR, RD, s, pos);
			ndx->ex = parse_ex();
			expt_ntok(t_brr);
			cs_spc();

			if (tok == t_eq) nd->vf = op_flaelael_ass;
			else if (tok == t_pleq) nd->vf = op_flaelael_assp;
			else if (tok == t_mineq) nd->vf = op_flaelael_assm;
			else if (tok == t_asteq) nd->vf = op_flaelael_asst;
			else if (tok == t_diveq) nd->vf = op_flaelael_assd;
			else errorx(ERR_ASSIGN);
			cs_tok_spc_nt();
			ndx->ex2 = parse_ex();
		}
	}
	else {
		errorx(ERR_BR);
	}
	if (ndol != NULL) ndol->v1 = nd->v1;
}

S void parse_strael_ass(ND* nd) {

	char s[16];
	strcpy(s, tval);
	ushort pos = code_utf8len;
	cs_tok_nt();
	cs("$[");
	ND* ndx = mkndx();
	ND* ndol = NULL;
	nd->ri = parse_ex_arr(&ndol);

	if (tok == t_brr) {
		//* f$[i] = "apple"
		cs_tok_nt();
		nd->v1 = get_var(VAR_STRARR, RD, s, pos);
		cs_spc();
		if (tok == t_eq) nd->vf = op_strael_ass;
		else if (tok == t_ampeq) nd->vf = op_strael_assp;
		else errorx(ERR_STRASS);
		cs_tok_spc_nt();
		ndx->ex = parse_strex();
	}
	else if (tok == t_brrl) {
		cs_tok_nt();
		if (tok == t_brr) {
			//* f$[i][] &= "apple"
			cs_tok_nt();
			nd->v1 = get_var(VAR_STRARRARR, RD, s, pos);
			cs_spc();
			if (tok == t_ampeq) {
				cs_tok_spc_nt();
				nd->vf = op_strarrael_append;
				ndx->ex = parse_strex();
			}
			else if (tok == t_eq) {
				cs_tok_spc_nt();
				nd->vf = op_arrael_ass;
				ndx->ex = parse_strarrex();
			}
			else error("&=, =");
		}
		else {
			//* f$[i][j] = "apple"
			nd->vf = op_straelael_ass;
			nd->v1 = get_var(VAR_STRARRARR, RD, s, pos);
			ndx->ex = parse_ex();
			expt_ntok(t_brr);
			cs_spc();
			expt_ntok(t_eq);
			cs_spc();
			ndx->ex2 = parse_strex();
		}
	}
	else {
		errorx(ERR_BR);
	}
	if (ndol != NULL) ndol->v1 = nd->v1;
}

S void parse_global_stat(void) {

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
				csnl();
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

S void parse_if_stat(ND* ifst) {

	stat_begin_nest();
	ifst->le = parse_log_ex();
	ifst->vf = op_if;
	ifst->ri = parse_sequ_stat();
	if (ifst->ri) return;
	ifst->ri = parse_sequ_if();

	while (tok == t_elif) {

		ifst->vf = op_if_else;
		ND* statx = mknd();
		statx->ex = ifst->ri;
		ifst->ri = statx;

		csnl();
		stat_begin_nest();
		ifst = mknd();
		opline_add(ifst, fmtline);
		statx->ex2 = ifst;

		ifst->next = NULL;
		ifst->vf = op_if;
		ifst->le = parse_log_ex();
		ifst->ri = parse_sequ_if();

	}
	if (tok == t_else) {
		nexttok();
		ifst->vf = op_if_else;
		ND* statx = mknd();
		statx->ex = ifst->ri;
		statx->ex2 = parse_sequ_end();
		ifst->ri = statx;
	}
	nexttok();
}

S void parse_while_stat(ND* nd) {
	stat_begin_nest();
	nd->vf = op_while;
	nd->le = parse_log_ex();
	nd->ri = parse_sequ_stat();
	if (nd->ri) return;
	loop_level += 1;
	nd->ri = parse_sequ_end();
	loop_level -= 1;
	nexttok();
}

S void parse_for_stat(ND* nd) {

	ND* ndx = mkndx();
	stat_begin_nest();

	if (tok != t_name && tok != t_vstr) error("variable");

	if (tok == t_name) {
		nd->v1 = parse_var(VAR_NUM, RW);
		cs_spc();
		ushort t = 0;
		if (tok == t_name) {
			if (strcmp(tval, "range0") == 0) t = 1;
			else if (strcmp(tval, "to") == 0) t = 2;
			else if (strcmp(tval, "in") == 0) t = 4;
		}
		else if (tok == t_eq) t = 3;
		if (t == 0) errorx(ERR_FOR);

		if (t <= 3) {
			if (t == 3) {
				cs_tok_spc_nt();
				ndx->ex2 = parse_ex();
				cs_spc();
				if (strcmp(tval, "to") == 0) nd->vf = op_for;
				else if (strcmp(tval, "downto") == 0) nd->vf = op_fordown;
				else if (strcmp(tval, "step") == 0) {
					csk_tok_spc_nt();
					ndx->ex3 = parse_ex();
					cs_spc();
					nd->vf = op_forstep;
					//kc
					expta("to");
				}
				else errorx(ERR_FOR2);

				csk_tok_spc_nt();
				nd->ri =parse_ex();
			}
			else if (t == 1) {
				nd->vf = op_for_range;
				csk_tok_spc_nt();
				nd->ri = parse_ex();
			}
			else {
				nd->vf = op_for_to;
				csk_tok_spc_nt();
				nd->ri = parse_ex();
			}
		}
		else {
			// for in
			csb_tok_spc_nt();
			nd->ri = parse_numarrex();
			nd->vf = op_for_in;
		}
	}
	else  {
		nd->v1 = parse_var(VAR_STR, RW);
		cs_spc();
		if (tok != t_name || strcmp(tval, "in") != 0) error("in");
		csb_tok_spc_nt();
		nd->ri = parse_strarrex();
		nd->vf = op_for_instr;
	}
	ndx->ex = parse_sequ_stat();
	if (ndx->ex) return;
	loop_level += 1;
	ndx->ex = parse_sequ_end();
	loop_level -= 1;
	nexttok();
}

//kcx
S void parse_repeat_stat(ND* nd) {

	ND* ndx = mkndx();
	loop_level += 1;
	if (!errn && sequ_level < 16) nest_block[sequ_level] = codestrln;
	csb_tok_nt();
	space_add();
	csnl();
	nd->ri = parse_sequ();
	if (tok != t_until) {
		if (nd->ri || tokpr == t_hash) csnl();
		errorx(ERR_CMDU);
		return;
	}
	space_sub();
	csnl();
	for (int i = 0; i < INDENT; i++) cs_spc();
	csb_tok_spc_nt();

	nd->le = parse_log_ex();
	opline_add(nd->le, fmtline);

	if (tok == t_dot || tok == t_end) {
		ndx->ex = NULL;
		csnl();
		cst(tok);
	}
	else {
		ndx->ex = parse_sequ_end();
	}
	nd->vf = op_repeat;
	nexttok();
	loop_level -= 1;
}


S void parse_len_stat(ND* nd) {

	csb_tok_spc_nt();

	if (tok == t_vnumarr) {
		nd->vf = op_numarr_len;
		nd->v1 = parse_var(VAR_NUMARR, WR);
		csbrr();
	}
	else if (tok == t_vstrarr) {
		nd->vf = op_strarr_len;
		nd->v1 = parse_var(VAR_STRARR, WR);
		csbrr();
	}
	else if (tok >= t_vnumarrarr && tok <= t_vstrarrarr) {
		if (tok == t_vnumarrarr) {
			nd->v1 = parse_var(VAR_NUMARRARR, WR);
			nd->vf = op_arrarr_len;
		}
		else {
			nd->v1 = parse_var(VAR_STRARRARR, WR);
			nd->vf = op_arrarr_len;
		}
		expt_ntok(t_brr);
	}
	else if (tok == t_vnumael || tok == t_vstrael) {
		ND* ndx = mkndx();
		if (tok == t_vnumael) {
			nd->v1 = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
			nd->vf = op_arrnumarrel_len;
			cs(tval);
			csbrl();
		}
		else {
			nd->v1 = get_var(VAR_STRARRARR, RD, tval, code_utf8len);
			nd->vf = op_arrstrarrel_len;
			cs(tval);
			cs("$[");
		}
		//* len a[i][] 2
		nexttok();
		ND* ndol = NULL;
		ndx->ex = parse_ex_arr(&ndol);
		if (ndol != NULL) ndol->v1 = nd->v1;
		opline_add(nd, fmtline);
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else errorx(ERR_VARR);
	cs_spc();

	nd->ri = parse_ex();
}
S void parse_arrbase_stat(ND* nd) {
	parse_len_stat(nd);
	if (nd->vf == op_arrnumarrel_len || nd->vf == op_arrstrarrel_len)
		nd->vf = op_arrbase2;
	else nd->vf = op_arrbase;
}

S void parse_arrarr_swap(ND* nd, byte arrtok, enum vartyp arrtype) {

	nd->vf = op_swaparr;
	nd->v1 = parse_var(arrtype + 2, RW);
	expt_ntok(t_brr);
	cs_spc();
	if (tok == arrtok + 2) {
		nd->v2 = parse_var(arrtype + 2, RW);
		expt_ntok(t_brr);
	}
	else {
		expt(arrtok);
	}
}

S void parse_arr_swap(ND* nd, byte arrtok, enum vartyp arrtype) {

	ushort h;
	nd->vf = op_swaparr;
	nd->v1 = parse_var(arrtype, RW);
	csbrrsp();

	if (tok == arrtok) {
		//* swap a[] b[]
		nd->v2 = parse_var(arrtype, RW);
		csbrr();
	}
	else if (tok == arrtok - 2) {
		//* swap a[] b[i][]
		ND* ndx = mkndx();
		nd->vf = op_swaparrael;
		h = nd->v1;
		nd->v1 = get_var(arrtype + 2, RD, tval, code_utf8len);
		cs(tval);
		if (arrtok == t_vstrarr) cs("$");
		csbrl();
		nexttok();
		ndx->vx = h;
		ND* ndol = NULL;
		nd->ri = parse_ex_arr(&ndol);
		if (ndol != NULL) ndol->v1 = nd->v1;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else {
		expt(arrtok);
	}
}

S void parse_arr_swap2(ND* nd, byte arrtok, enum vartyp arrtype) {

	ND* ndx = nd + 1;
	nd->vf = op_swaparrael;
	cs_spc();
	if (tok == arrtok) {
		ndx->vx = parse_var(arrtype, RW);
		csbrr();
	}
	else if (tok == arrtok - 2) {
		nd->vf = op_swaparraelx;
		ndx->vx2 = get_var(arrtype + 2, RW, tval, code_utf8len);
		cs(tval);
		if (arrtok == t_vstrarr) cs("$");
		csbrl();
		nexttok();
		ND* ndol = NULL;
		ndx->ex = parse_ex_arr(&ndol);
		if (ndol != NULL) ndol->v1 = ndx->vx2;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else {
		expt(arrtok);
	}
}

S void parse_swap_stat(ND* nd) {

	csb_tok_spc_nt();

	if (tok == t_name) {
		nd->vf = op_swapnum;
		nd->v1 = parse_var(VAR_NUM, RW);
		cs_spc();
		expt(t_name);
		nd->v2 = parse_var(VAR_NUM, RW);
	}
	else if (tok == t_vnumael) {
		ND* ndx = mkndx();
		int t = parse_vnumael(nd, 0);
		if (t == AEL) {
			// swap f[i] f[j]
			nd->vf = op_swapnumael;
			cs_spc();
			expt(t_vnumael);
			ndx->vx2 = parse_var(VAR_NUMARR, RD);
			ND* ndol = NULL;
			ndx->ex = parse_ex_arr(&ndol);
			if (ndol != NULL) ndol->v1 = ndx->vx2;
			expt_ntok(t_brr);
		}
		else if (t == ARRAEL) {
			cs_tok_nt();
			parse_arr_swap2(nd, t_vnumarr, VAR_NUMARR);
		}
		else if (t == AELAEL) {
// swap a[1][1] b[1][1]
			nd->vf = op_swapnumaelael;
			ndx->ex = parse_ex();
			expt_ntok(t_brr);
			cs_spc();
			expt(t_vnumael);

			//nd->v1a = parse_var(VAR_NUMARRARR, RD);
			nd->v1a = get_var(VAR_NUMARRARR, RD, tval, code_utf8len);
			cs_tok_nt();
			csbrl();
			ND* ndol = NULL;
			ndx->ex2 = parse_ex_arr(&ndol);
			if (ndol != NULL) ndol->v1 = nd->v1a;
			expt_ntok(t_brrl);
			ndx->ex3 = parse_ex();
			expt_ntok(t_brr);
		}
		else {
			errorx(ERR_BR);
		}
	}
	else if (tok == t_vstr) {
		nd->vf = op_swapstr;
		nd->v1 = parse_var(VAR_STR, RW);
		cs_spc();
		expt(t_vstr);
		nd->v2 = parse_var(VAR_STR, RW);
	}
	else if (tok == t_vstrael) {
		ND* ndx = mkndx();
		int t = parse_vstrael(nd, 0);
		if (t == AEL) {
			// swap f$[i] f$[j]
			nd->vf = op_swapstrael;
			cs_spc();
			expt(t_vstrael);
			ndx->vx2 = parse_var(VAR_STRARR, RD);
			ND* ndol = NULL;
			ndx->ex = parse_ex_arr(&ndol);
			if (ndol != NULL) ndol->v1 = ndx->vx2;
			expt_ntok(t_brr);
		}
		else if (t == ARRAEL) {
			cs_tok_nt();
			parse_arr_swap2(nd, t_vstrarr, VAR_STRARR);
		}
		else error("]");
	}
// ----------------------------------------------------------------------------------------
	else if (tok >= t_vnumarr && tok <= t_vstrarr) {
		if (tok == t_vnumarr) {
			parse_arr_swap(nd, t_vnumarr, VAR_NUMARR);
		}
		else {
			parse_arr_swap(nd, t_vstrarr, VAR_STRARR);
		}
	}
	else if (tok >= t_vnumarrarr && tok <= t_vstrarrarr) {
		if (tok == t_vnumarrarr) {
			parse_arrarr_swap(nd, t_vnumarr, VAR_NUMARR);
		}
		else {
			parse_arrarr_swap(nd, t_vstrarr, VAR_STRARR);
		}
	}
// ----------------------------------------------------------------------------------------
	else error("variable");
}

S void optimize_ass(ND* nd) {

	if (in_fastfunc) return;
	if (nd->ri->numf == op_const_fl) {

		double d = nd->ri->cfl;
		float f = (float)d;
		if ((double)f == d) {

			if (nd->vf == op_flass) {
				nd->vf = op_ass_fl;
				nd->cfl32 = f;
			}
			else if (nd->vf == op_flassp) {
				nd->vf = op_assp_fl;
				nd->cfl32 = f;
			}
			else if (nd->vf == op_flassm) {
				nd->vf = op_assp_fl;
				nd->cfl32 = -f;
			}
		}
	}
	else if (nd->vf == op_flass) {
		if  (nd->ri->numf == op_vnum) {
			nd->vf = op_ass_var;
			nd->v2 = nd->ri->v1;
		}
		else if (nd->ri->numf == op_lvnum) {
			nd->vf = op_ass_lvar;
			nd->v2 = nd->ri->v1;
		}
	}
}

S ND* parse_strarr_term(void) {

	ND* nd = mknd();
	if (tok == t_vnumarr) {
		nd->strf = op_numarrstr;
		nd->le = parse_numarrex();
	}
	else if (tok == t_vstrarr) {
		nd->strf = op_strarrstr;
		nd->le = parse_strarrex();
	}
	else if (tok == t_vnumarrarr) {
		nd->strf = op_numarrarrstr;
		nd->le = parse_numarrarrex();
	}
	else {
		nd->strf = op_strarrarrstr;
		nd->v1 = parse_var(VAR_STRARRARR, RD);
		expt_ntok(t_brr);
	}

	return nd;
}

S int getfunctype(void) {
	// funcX
	if (c == '$') {
		int h = 0;
		if (tok == t_funcdecl) h += 4;
		nextc();
		tval[4 + h] ='$';
		if (c == '[' && cn == ']') {
			tval[5 + h] ='[';
			tval[6 + h] =']';
			tval[7 + h] = 0;
			nextc();
			nextc();
			return 4;
		}
		tval[5 + h] = 0;
		return 2;
	}
	if (c == '[' && cn == ']') {
		int h = 0;
		if (tok == t_funcdecl) h += 4;
		tval[4 + h] ='[';
		tval[5 + h] =']';
		tval[6 + h] = 0;
		nextc();
		nextc();
		if (c == '[' && cn == ']') {
			tval[6 + h] ='[';
			tval[7 + h] =']';
			tval[8 + h] = 0;
			nextc();
			nextc();
			return 5;
		}
		return 3;
	}
	return 1;
}

S void parse_funcproc(void) {

	// proc .. or funcXX ..
	if (sequ_level != 0) error("not allowed here");
	loop_level += 1;
	if (!errn && sequ_level < 16) nest_block[sequ_level] = codestrln;
	if (tok == t_func || tok == t_fastfunc) {

		if (tok == t_fastfunc && cod) {
			in_fastfunc = 1;
			parse_proc(1);
			if (!errn) parse_fastfunc();
			in_fastfunc = 0;
		}
		else {
			parse_proc(getfunctype());
		}
	}
	else {
		parse_proc(0);

	}
	proc = proc_p;
	loop_level -= 1;
}


S void (*vftb[])(ND*) = {
	op_print, op_text, op_write,
	op_sleep, op_timer, op_textsize, op_linewidth, op_co_rotate, op_co_scale, op_circle,
	op_color, op_background, op_mouse_cursor, op_random_seed,
	op_move, op_line, op_co_translate, op_rect, op_numfmt,
	op_gtext,
	op_color3, op_gcircle,
	op_grect, op_gline, op_gcircseg,
	op_sound, op_polygon, op_curve,
};
S char vfprop[] = {
	8, 5, 8,
	0, 0, 1, 1, 1, 1, 1,
	1, 1, 1, 0,
	1, 1, 1, 1, 0,
	5,
	1, 1, 1,
	1, 1,
	2, 1, 1,
};


//kc
S ND* parse_stat(void) {
	ND* nd = mknd();
	opline_add(nd, fmtline);
	if (tok == t_name) {

		const char* name = getn(tval);

		if (try_call_subr(nd, name) == 0) {
			struct proc* p = proc_get(name);
			if (p) {
				if (p->typ == 0) parse_call_stat(nd, p);
				else {
					return NULL;
//							nd->vf = op_print;
//							nd->le = parse_strex();
				}
			}
			else {
				nd->v1 = parse_var(VAR_NUM, WR);
				cs_spc();
				if (tok == t_eq) nd->vf = op_flass;
				else if (tok == t_pleq) nd->vf = op_flassp;
				else if (tok == t_mineq) nd->vf = op_flassm;
				else if (tok == t_asteq) nd->vf = op_flasst;
				else if (tok == t_diveq) nd->vf = op_flassd;
				else {
					errorx(ERR_ASSIGN);
					return nd;
				}

// ?????
//						else {
//							nd->vf = op_print;
//							nd->le = parse_strex();
//						}
				cs_tok_spc_nt();
				nd->ri = parse_ex();
				if (cod) {
					optimize_ass(nd);
				}
			}
		}
	}
	else if (tok == t_if) {
		parse_if_stat(nd);
	}
	else if (tok == t_while) {
		parse_while_stat(nd);
	}
	else if (tok == t_for) {
		parse_for_stat(nd);
	}
	else if (tok == t_len) {
		parse_len_stat(nd);
	}
	else if (tok >= t_vnumael && tok <= t_vstrarrarr) {
		if (tok == t_vnumael) {
			parseael_ass(nd);
		}
		else if (tok == t_vnumarr) {
			parse_arr_ass(nd);
		}
		else if (tok == t_vstrarr) {
			parse_strarr_ass(nd);
		}
		else if (tok == t_vstrael) {
			parse_strael_ass(nd);
		}
		else if (tok == t_vnumarrarr) {
			parse_arrarr_ass(nd);
		}
		else {
			parse_strarrarr_ass(nd);
		}
	}
	else if (tok == t_repeat) {
		parse_repeat_stat(nd);
	}
	else if (tok == t_vstr) {
		nd->v1 = parse_var(VAR_STR, WR);
		cs_spc();
		if (tok == t_eq) nd->vf = op_strass;
		else if (tok == t_ampeq) nd->vf = op_strassp;
		else errorx(ERR_STRASS);
		cs_tok_spc_nt();
		nd->ri = parse_strex();
	}
	else if (tok == t_subr) {
		if (loop_level != 1 || proc == proc_p) error("not allowed here");
		parse_subr();
		nd->vf = op_nop;
	}
	else if (tok >= t_return) {
		if (tok <= t_arrbase) {

			if (tok == t_return) {
				nd->vf = op_return;
				csb_tok_nt();
				if (proc->typ == 0) {
				}
				else if (proc->typ == 1) {
					cs_spc();
					nd->le = parse_ex();
				}
				else if (proc->typ == FUNCSTR) {
					cs_spc();
					nd->le = parse_strex();
				}
				else if (proc->typ == FUNCARR) {
					cs_spc();
					nd->le = parse_numarrex();
				}
				else if (proc->typ == FUNCSTRARR) {
					cs_spc();
					nd->le = parse_strarrex();
				}
				else {
					cs_spc();
					nd->le = parse_numarrarrex();
				}
			}
			else if (tok == t_swap) {
				parse_swap_stat(nd);
			}
			else if (tok == t_break) {
				if (loop_level == 0) error("not in a loop");
				csb_tok_spc_nt();
				ushort h = tvalf;
				if (tok != t_lnumber || h != tvalf) error("break level");
				if (loop_level < h) error("break level too high");
				cs(tval);
				nd->vf = op_break;
				nd->v1 = h;
				nexttok();
			}
			// ----------------------------------------------------------------------------
			else if (tok >= t_gclear && tok <= t_gpenup) {
				nd->vf = op_sys;
				nd->v1 = tok - t_gclear + 11;
				csb_tok_nt();
				prog_props |= 1;
			}
			else {	// t_arrbase
			// else if (tok == t_arrbase) {
				parse_arrbase_stat(nd);
			}
		}
		else if (tok <= t_gcurve) {
			csb_tok_spc_nt();
			if (cod) {
				int h = tokpr - t_print;
				nd->vf = vftb[h];
				prog_props |= vfprop[h];
			}
			if (tokpr <= t_write) {
				nd->le = parse_strex();
			}
			else if (tokpr <= t_gcircseg) {
				int t = tokpr;
				ND* ndx;
				if (t >= t_gtext) ndx = mkndx();
				nd->le = parse_ex();
				if (t >= t_move) {
					if (tok == t_comma) cs_tok_nt();
					cs_spc();
					nd->ri = parse_ex();
					if (t >= t_gtext) {
						if (tok == t_comma) cs_tok_nt();
						cs_spc();
						if (t <= t_gtext) {
							ndx->ex = parse_strex();
						}
						else {
							ndx->ex = parse_ex();
							if (t >= t_grect) {
								if (tok == t_comma) cs_tok_nt();
								cs_spc();
								ndx->ex2 = parse_ex();
								if (t >= t_gcircseg) {
									if (tok == t_comma) cs_tok_nt();
									cs_spc();
									ndx->ex3 = parse_ex();
								}
							}
						}
					}
				}
			}
			else {		// <= t_gcurve
				nd->le = parse_numarrex();
			}
		}
		else {
			return NULL;
		}
	}
	else {
		return NULL;
	}
	return nd;
}

S ND* parse_sequ0(void) {

	ND* sequ = NULL;
	ND* ndp;

	while (tok != t_eof) {

		if (tok == t_hash) {
			parse_comment();
			nexttok();
		}
		else if (tok >= t_proc && tok <= t_global) {

			if (tok == t_global) {
				parse_global_stat();
			}
			else if (tok >= t_proc && tok <= t_fastfunc) {
				parse_funcproc();

			}
			else if (tok == t_subr) {
				parse_subr();
			}
			else if (tok == t_on) {
				parse_on_stat();
			}
			else if (tok == t_procdecl) {
				parse_procdecl(FUNCPROC);
			}
			else if (tok == t_funcdecl) {
				parse_procdecl(getfunctype());
			}
			else if (tok == t_prefix) {
				if (prefix_len == 0) {
					csb_tok_spc_nt();
					if (tok != t_name) error_tok(t_name);
					strcpy(prefix, tval);
					prefix_len = strlen(prefix);
					cs_tok_nt();
				}
				else {
					prefix_len = 0;
					cst(tok);
					nexttok();
				}
			}
			else { 	// tok == t_input_data
				csb(tval);
				if (c != 0) csnl();
				parse_input_data();
				nexttok();
			}
		}
		else {
			ND* nd = parse_stat();
			if (sequ == NULL) sequ = nd;
			else ndp->next = nd;
			ndp = nd;
			if (nd == NULL) break;
		}
		
		if (tok == t_semicol) {
			cs(" ; ");
			nexttok();
		}
		else csnl();

	}
	if (sequ != NULL) ndp->next = NULL;
	return sequ;
}

S ND* parse_sequ(void) {

	ND* sequ = NULL;
	ND* ndp;

	while (1) {
		if (tok == t_hash) {
			parse_comment();
			nexttok();
		}
		else {
			ND* nd = parse_stat();
			if (sequ == NULL) sequ = nd;
			else ndp->next = nd;
			ndp = nd;
			if (nd == NULL) break;
		}
		if (tok == t_dot || tok <= t_end || tok == t_eof || errn) break;
		//if (tok == t_dot || tok <= t_end || tok == t_eof) break;

		if (tok == t_semicol) {
			cs(" ; ");
			nexttok();
		}
		else csnl();
	}
	if (sequ != NULL) ndp->next = NULL;
	return sequ;
}
