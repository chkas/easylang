/*	kaparse.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns 
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
	op_sys_time, op_error, op_mouse_x, op_mouse_y, op_randomf, op_pi,
	op_random,  op_sqrt, op_logn, op_abs, op_sign, op_bitnot, op_floor, op_sin, op_cos, op_tan, op_asin, op_acos, op_atan, 
	op_atan2, op_pow, op_bitand, op_bitor, op_bitxor, op_bitshift, op_lower, op_higher,
	op_number, op_strcode, op_strcompare
};

S ND* parse_numfunc(void) {

	ND* nd = mknd();
	csb_tok_nt();
	nd->numf = numf[tokpr - t_systime];

	if (tokpr <= t_pi) {
	}
	else if (tokpr <= t_higher) {
		int t = tokpr;
		cs_spc();
		nd->le = parse_fac();
		if (t >= t_atan2) {
			cs_spc();
			nd->ri = parse_fac();
		}
	}
	else if (tokpr <= t_strcompare) {
		int t = tokpr;
		cs_spc();
		nd->le = parse_strterm();
		if (t == t_strcompare) {
			cs_spc();
			nd->ri = parse_strterm();
		}
	}
	return nd;
}

S ND* parse_numarrex(void);
S ND* parse_strarrex(void);

struct str (*strf[])(ND*) = {
	op_input, op_sysfunc, op_keyb_key, op_strchr, op_time_str, op_join, op_substr
};

S void parse_strfunc(ND* nd) {

	csb_tok_nt();
	nd->strf = strf[tokpr - t_input];

	if (tokpr >= t_strchr && tokpr <= t_timestr) {
		cs_spc();
		nd->le = parse_ex();
	}
	else if (tokpr == t_substr) {
		ND* ndx = mkndx();
		cs_spc();
		nd->le = parse_strex();
		cs_spc();
		nd->ri = parse_ex();
		cs_spc();
		ndx->ex = parse_ex();;
	}
	else if (tokpr == t_sysfunc) {
		cs_spc();
		nd->le = parse_strex();
	}
	else if (tokpr == t_strjoin) {
		cs_spc();
		nd->le = parse_strarrex();
	}
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
	if (tok != h) error(token_list[h]);
}

S void expt_ntok(int h) {
	if (is_enter && tok == t_eof) {
		// autocomplete on enter
		cs(token_list[h]);
		return;
	}
	expt(h);
	cs_tok_nt();
}

S int is_numfactor(void) {
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

S void optimize_vnumael(ND* nd) {

	if (nd->ri->numf == op_lvnum) {
		nd->numf = op_vnumael_lvar;
		nd->v2 = nd->ri->v1;
	}
}

S ND* parse_log_ex(void);

S ND* parse_lenfunc(ushort mode) {

	ND* nd = mknd();
	nd->numf = op_arr_len;
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
		// len e$[i] vs len e$[i][]
		char s[16];
		ushort pos = code_utf8len;
		strcpy(s, tval);
		cs_tok_nt();
		cs("$[");
		nd->ri = parse_ex();;

		if (tok == t_brr) {
			// len a$[i]
			cs_tok_nt();
			nd->v1 = get_var(VAR_STRARR, RD, s, pos);
			nd->strf = op_vstrael;
			opln_add(nd, fmtline);
			ND* h = nd;
			nd = mknd();
			nd->numf = op_strlen;
			nd->le = h;

		}
		else if (tok == t_brrl) {
			// len a$[i][]
			nd->v1 = get_var(VAR_STRARRARR, RD, s, pos);
			nd->numf = op_arrarrael_len;
			opln_add(nd, fmtline);
			expt_ntok(t_brrl);
			expt_ntok(t_brr);
		}
	}
	else if (tok == t_vnumael) {
		// len a[i][]

		char s[16];
		strcpy(s, tval);
		ushort pos = code_utf8len;
		cs_tok_nt();
		csbrl();
		nd->numf = op_arrarrael_len;
		nd->ri = parse_ex();

		if (mode == 0) {
			nd->v1 = get_var(VAR_NUMARRARR, RD, s, pos);
			expt_ntok(t_brrl);
			expt_ntok(t_brr);
		}
		else {
			if (tok == t_brrl) {
				cs_tok_nt();
				// len arr[1][] or arr[1][1]
				if (tok == t_brr) {
					nd->v1 = get_var(VAR_NUMARRARR, RD, s, pos);
					cs_tok_nt();
				}
				else {
					nd->v1 = get_var(VAR_NUMARRARR, RD, s, pos);
					nd->numf = op_vnumaelael;
					ND* ndx = mkndx();
					ndx->ex = parse_ex();
					expt_ntok(t_brr);
				}
			}
			else if (tok == t_brr) {
				// arr[1]
				nd->v1 = get_var(VAR_NUMARR, RD, s, pos);
				cs_tok_nt();
				nd->numf = op_vnumael;
			}
			else {
				error("]");
			}
		}
		opln_add(nd, fmtline);
	}
	else if (is_strfactor()) {
		nd->numf = op_strlen;
		nd->le = parse_strterm();
	}
	else {
		error("array variable, string");
	}
	return nd;
}

S ND* parse_fac(void) {

	ND* nd;
	if (tok == t_lnumber) {
		nd = mknd();
		nd->cfl = tvalf;
		cs_tok_nt();
		nd->numf = op_const_fl;
/*
		double f = tvalf;

		float fh = f;
		if (f == (double)fh) {
			nd->numf = op_const_fl;
			nd->cfl = fh;
		}
		else {
			nd->numf = op_const_flx;
			ushort ox = code_add();
			codp[ox].cdbl = f;
		}
*/

	}
	else if (tok == t_name) {
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
	else if (is_numfunc()) {
		nd = parse_numfunc();
	} 
	else if (tok == t_len) {
		csb_tok_spc_nt();
		nd = parse_lenfunc(0);
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
		char s[16];
		strcpy(s, tval);
		ushort pos = code_utf8len;
		cs_tok_nt();
		csbrl();

		nd->ri = parse_ex();

		if (tok == t_brr) {
			cs_tok_nt();

			if (cod) {
				nd->v1 = get_var(VAR_NUMARR, RD, s, pos);
				nd->numf = op_vnumael;
				optimize_vnumael(nd);
			}
		}
		else if (tok == t_brrl) {
			ND* ndx = mknd();
			cs_tok_nt();
			nd->v1 = get_var(VAR_NUMARRARR, RD, s, pos);
			nd->numf = op_vnumaelael;

			ndx->ex = nd->ri;
			nd->ri = ndx;
			ndx->ex2 = parse_ex();;
			expt_ntok(t_brr);
		}
		else {
			error("], ][");
		}
		opln_add(nd, fmtline);
	}
	else if (tok == t_if) {
		nd = mknd();
		csb_tok_spc_nt();
		nd->le = parse_log_ex();
		nd->numf = op_numlog;
	}
	else {
		nd = NULL;
		error("number");
	}
	return nd;
}


S ND* parse_termx(ND* ndx) {

	if (ndx == NULL) ndx = parse_fac();
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
	return parse_termx(NULL);
}

//kc optimize
S void optimize_ex(ND* nd) {

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

	ND* nd;
	ND* ndx = parse_termx(nd0);
	while (tok == t_plus || tok == t_minus) {
		cs_spc();
		nd = mknd();
		nd->le = ndx;
		if (tok == t_plus) nd->numf = op_add;
		else nd->numf = op_sub;
		cs_tok_spc_nt();
		nd->ri = parse_term();
		if (cod) optimize_ex(nd);
		ndx = nd;
	}
	return ndx;
}
S ND* parse_ex(void) {
	return parse_exx(NULL);
}

S ND* parse_strterm(void) {

	ND* nd = mknd();
	if (tok == t_lstr) {
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
	}
	else if (tok == t_vstr) {
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
		char s[16];
		strcpy(s, tval);
		ushort pos = code_utf8len;
		cs_tok_nt();
		cs("$[");
		nd->ri = parse_ex();

		if (tok == t_brr) {
			cs_tok_nt();
			nd->v1 = get_var(VAR_STRARR, RD, s, pos);
			nd->strf = op_vstrael;
		}
		else if (tok == t_brrl) {
			cs_tok_nt();
			nd->v1 = get_var(VAR_STRARRARR, RD, s, pos);
			nd->strf = op_vstraelael;
			ND* ndx = mkndx();
			ndx->ex = nd->ri;
			nd->ri = ndx;
			ndx->ex2 = parse_ex();;
			expt_ntok(t_brr);
		}
		else {
			error("], ][");
		}
		opln_add(nd, fmtline);
	}
	else if (is_strfunc()) {
		parse_strfunc(nd);
	}
	else if (is_numfactor()) {
		nd->strf = op_numstr;
		nd->le = parse_ex();
	}
	else {
		error("string");
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
		nd->ri = parse_strterm();;
		ndx = nd;
	}
	return ndx;
}

S ND* parse_log_exx(ND* nd0);

S void parse_str_cmp(ND* nd) {
	nd->le = parse_strex();;
	cs_spc();
	if (tok == t_eq) nd->intf = op_eqs;
	else if (tok == t_neq) nd->intf = op_neqs;
	else error("=, <>");
	cs_tok_spc_nt();
	nd->ri = parse_strex();
}

S void parse_arr_cmp(ND* nd) {
	nd->le = parse_numarrex();
	cs_spc();
	if (tok == t_eq) nd->intf = op_eqarr;
	else if (tok == t_neq) nd->intf = op_neqarr;
	else error("=, <>");
	cs_tok_spc_nt();
	nd->ri = parse_numarrex();
}

S void optimize_cmp(ND* nd) {

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

S void parse_cmp(ND* nd, ND* nd0) {
	nd->le = parse_exx(nd0);
	cs_spc();
	if (tok == t_lt) nd->intf = op_ltf;
	else if (tok == t_gt) nd->intf = op_gtf;
	else if (tok == t_le) nd->intf = op_lef;
	else if (tok == t_ge) nd->intf = op_gef;
	else if (tok == t_eq) nd->intf = op_eqf;
	else if (tok == t_neq) nd->intf = op_neqf;
	else error("=, <>, <, >, <=, >=");
	cs_tok_spc_nt();
	nd->ri = parse_ex();

	if (cod) optimize_cmp(nd);
}

S ND* parse_log_termx(ND* nd0) {

	ND* nd;
	if (nd0) {
		nd = mknd();
		parse_cmp(nd, nd0);
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
				nd = mknd();
				parse_cmp(nd, h);
			}
			else {
				nd = parse_log_exx(h);
				expt_ntok(t_par);
			}
		}
	}
	else if (tok == t_vnumarr) {
		nd = mknd();
		parse_arr_cmp(nd);
	}
	else if (is_strfactor()) {
		nd = mknd();
		parse_str_cmp(nd);
	} 
	else {
		nd = mknd();
		parse_cmp(nd, NULL);
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
	return ndx;
}

S ND* parse_log_ex(void) {
	return parse_log_exx(NULL);
}

S ND* parse_sequ(void);

S uint nest_block[16];

S void stat_begin_nest(void) {
	if (!err && sequ_level < 16) nest_block[sequ_level] = codestrln;
	csb(tval);
	cs_spc();
	nexttok();
}

S ND* parse_sequ_end(void) {
	space_add();
	ND* nd = parse_sequ();
	if (tok != t_dot && tok != t_end) {
		cs_nl();
		error("<cmd>, end, .");
	}
	space_sub();
	cs_nl();
	cst(tok);
	return nd;
}

S ND* parse_sequ_if(void) {
	space_add();
	ND* nd = parse_sequ();
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
	return nd;
}

struct vname* xx;

S void parse_subr(void) {

	loop_level += 1;
	stat_begin_nest();
	if (tok != t_name) error_tok(t_name);
	const char* name = getn(tval);
//kc
	struct vname* p = get_vname(proc, name, VAR_SUBR);
	if (p != NULL) error("already defined");
	p = add_vname(proc, name, VAR_SUBR, code_utf8len);
	cs_tok_nt();
	p->sstart = mknd();
	ushort pind = p - proc->vname_p;

	ND* h = parse_sequ_end();
	p = proc->vname_p + pind;
	p->sstart->ex = h;
	
	nexttok();
	loop_level -= 1;
}

S int parse_proc_header(int mode) {

	// mode:0 procdecl
	csb_tok_spc_nt();

	if (tok != t_name) error_tok(t_name);
	const char* name = getn(tval);
	proc = proc_get(name);
	if (proc != NULL) {
		if (mode == 1 && proc->start == NULL) mode = 2;
		else error("already defined");
	}
	else {
		proc = proc_add(name);
		if (proc == NULL) return 0;
	}
	cs_tok_spc_nt();

	int i = 0;
	char typ;
	while (tok != t_dot) {
//TODO: more parameters?
		if (i == 8) {
			error("max 8 parameters");
			return 0;
		}
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
		else if (tok == t_vstrarr) {
			lvar(VAR_STRARR, 1, mode);
			csbrr();
			typ = 't';
		}
		else {
			if (is_enter && tok == t_eof) {
				cst(t_dot);
				cs_spc();
				cst(t_dot);
				space_add();
				cs_nl();
				error("");
				return 0;
			}
			error("., string or number variable");
			return 0;
		}
		if (mode <= 1) proc->parms[i] = typ;
		else if (proc->parms[i] != typ) error("procdecl doesn't match");
		cs_spc();
		i += 1;
	}
	cst(t_dot);
	cs_spc();
	nexttok();
	while (tok != t_dot) {
		if (i == 8) {
			error("max 8 parameters");
			return 0;
		}
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
			if (is_enter && tok == t_eof) {
				cst(t_dot);
				space_add();
				cs_nl();
				error("");
				return 0;
			}
			error("., variable");
			return 0;
		}
		if (mode <= 1) proc->parms[i] = typ;
		else if (proc->parms[i] != typ) error("procdecl doesn't match");
		cs_spc();
		i += 1;
	}
	if (mode <= 1) proc->parms[i] = 0;
	else if (proc->parms[i] != 0) error("procdecl doesn't match");

	cst(t_dot);
	nexttok();
	return 1;
}

S void parse_proc(void) {

	if (!parse_proc_header(1)) return;

	ND* nd = mknd();
	proc->start = nd;
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
	while (proc->parms[i]) {
		byte ptyp;
		char typ = proc->parms[i]; 
		if (typ == 'f') ptyp = PAR_NUM;
		else if (typ == 's') ptyp = PAR_STR;
		else if (typ == 'g' || typ == 't') ptyp = PAR_ARR;

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

S void parse_procdecl(void) {
	parse_proc_header(0);
	proc = proc_p;
}

S void get_onref(const char* s, int* pid, ND*** ppsq) {
	if (strcmp(s, "mouse_down") == 0) {
		*pid = 0;
		*ppsq = &seq.mouse_down;
	}
	else if (strcmp(s, "animate") == 0) {
		*pid = 4;
		*ppsq = &seq.animate;
	}
	else if (strcmp(s, "timer") == 0) {
		*pid = 5;
		*ppsq = &seq.timer;
	}
	else if (strcmp(s, "mouse_up") == 0) {
		*pid = 1;
		*ppsq = &seq.mouse_up;
	}
	else if (strcmp(s, "mouse_move") == 0) {
		*pid = 2;
		*ppsq = &seq.mouse_move;
	}
	else if (strcmp(s, "key") == 0) {
		*pid = 3;
		*ppsq = &seq.key_down;
	}
	else if (strcmp(s, "key_down") == 0) {
		*pid = 3;
		*ppsq = &seq.key_down;
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
		error("mouse_down, mouse_up, mouse_move, key, animate, timer");
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
S void parse_sys_stat(ND* nd) {
	csb_tok_spc_nt();

	nd->vf = op_sys;
	if (strcmp(tval, "botleft") == 0) {
		nd->v1 = 11;
	}
	else if (strcmp(tval, "topleft") == 0) {
		nd->v1 = 12;
	}
	// undocumented
	else if (strcmp(tval, "time") == 0) {
		nd->v1 = 21;
	}
	else {
		error("topleft, botleft");
		return;
	}
	csb_tok_nt();
}

S ND* parse_numarrex(void) {

	ND* ex = mknd();
	if (tok == t_brl) {
		cs_tok_spc_nt();
		ex->arrf = op_numarr_init;

		ND* nd = ex;
		while (tok != t_brr && tok != t_brrl && tok != t_eof && !err) {
			nd->next = parse_ex();
			nd = nd->next;
			cs_spc();
		}
		if (tok == t_brrl) {
			cs("]");
			tok = t_brl;
			strcpy(tval, "[");
		}
		else expt_ntok(t_brr);
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
		ex->ri = parse_ex();
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
		opln_add(ex, fmtline);
	}
	else if (tok == t_number) {
		ex->arrf = op_map_number;
		csb_tok_nt();
		cs_spc();
		ex->le = parse_strarrex();;
	}
	else error("array");
	return ex;
}

S ND* parse_numarrarrex(void) {

	ND* ex = mknd();
	if (tok == t_brl) {
		cs_tok_spc_nt();
		ex->arrf = op_arrarr_init;
		ND* nd = ex;
		while (tok != t_brr && tok != t_eof && !err) {
			nd->next = parse_numarrex();
			nd = nd->next;
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
	else error("array array");
	return ex;
}

S ND* parse_strarrex(void) {

	ND* ex = mknd();
	if (tok == t_brl) {
		ex->arrf = op_strarr_init;
		cs_tok_spc_nt();
		ND* nd = ex;
		while (tok != t_brr && tok != t_eof && !err) {
			nd->next = parse_strex();
			nd = nd->next;
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
		ex->ri = parse_ex();;
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
		opln_add(ex, fmtline);
	}
	else if (tok == t_name && strcmp(tval, "strchars") == 0) {
		ex->arrf = op_strchars;
		csb_tok_spc_nt();
		ex->le = parse_strex();
	}
	else if (tok == t_name && strcmp(tval, "strsplit") == 0 ) {
		ex->arrf = op_strsplit;
		csb_tok_spc_nt();
		ex->le = parse_strex();
		cs_spc();
		ex->ri = parse_strex();
	}
	else error("string array");
	return ex;
}

S ND* parse_strarrarrex(void) {

	ND* ex = mknd();
	if (tok == t_brl) {
		cs_tok_spc_nt();
		ex->arrf = op_arrarr_init;
		ND* nd = ex;
		while (tok != t_brr && tok != t_eof && !err) {
			nd->next = parse_strarrex();
			nd = nd->next;
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
	else error("=, &=");
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
	else error("=, &=");
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
	else error("=, &=");
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
	else error("=, &=");
}

S void parseael_ass(ND* nd) {

	char s[16];
	strcpy(s, tval);
	ushort pos = code_utf8len;
	cs_tok_nt();
	csbrl();
	ND* ndx = mkndx();
	nd->ri = parse_ex();

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
		else error("=, +=");
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
			else error("&=, =");
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
			else error("= += -= *= /=");
			cs_tok_spc_nt();
			ndx->ex2 = parse_ex();
		}
	}
	else {
		error("], ][");
	}
}

S void parse_strael_ass(ND* nd) {

	char s[16];
	strcpy(s, tval);
	ushort pos = code_utf8len;
	cs_tok_nt();
	cs("$[");
	ND* ndx = mkndx();
	nd->ri = parse_ex();

	if (tok == t_brr) {
		//* f$[i] = "apple"
		cs_tok_nt();
		nd->v1 = get_var(VAR_STRARR, RD, s, pos);
		cs_spc();
		if (tok == t_eq) nd->vf = op_strael_ass;
		else if (tok == t_ampeq) nd->vf = op_strael_assp;
		else error("=, &=");
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
			//* f[i][j] = "apple"
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
		error("], ][");
	}
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

S void parse_if_stat(ND* ifst) {

	stat_begin_nest();
	ifst->le = parse_log_ex();
	ifst->ri = parse_sequ_if();
	ifst->vf = op_if;

	while (tok == t_elif) {

		ifst->vf = op_if_else;
		ND* statx = mknd();
		statx->ex = ifst->ri;
		ifst->ri = statx;

		cs_nl();
		stat_begin_nest();
		ifst = mknd();
		opln_add(ifst, fmtline);
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

S void parse_for_stat(ND* nd) {

	ND* ndx = mkndx();
	loop_level += 1;
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
		if (t == 0) error("=, in");

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
					if (strcmp(tval, "to") != 0) error("to");
				}
				else error("to, downto, step");

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
			ndx->vx2 = get_var(VAR_NUM, 0, "_", code_utf8len);
			csb_tok_spc_nt();
			nd->ri = parse_numarrex();
			nd->vf = op_for_in;
		}
	}
	else  {
		nd->v1 = parse_var(VAR_STR, RW);
		cs_spc();
		if (tok != t_name || strcmp(tval, "in") != 0) error("in");
		ndx->vx2 = get_var(VAR_NUM, 0, "_", code_utf8len);
		csb_tok_spc_nt();
		nd->ri = parse_strarrex();
		nd->vf = op_for_instr;
	}
	ndx->ex = parse_sequ_end();
	nexttok();
	loop_level -= 1;
}

// TODO make short (1 statement) repeat, change le ri ?
S void parse_repeat_stat(ND* nd) {

	ND* ndx = mkndx();
	loop_level += 1;
	if (!err && sequ_level < 16) nest_block[sequ_level] = codestrln;
	csb_tok_nt();
	space_add();
	nd->ri = parse_sequ();
	space_sub();
	cs_nl();
	for (int i = 0; i < INDENT; i++) cs_spc();
	if (tok != t_until) error("<cmd>, until");
	csb_tok_spc_nt();

	nd->le = parse_log_ex();
	opln_add(nd, fmtline);

	if (tok == t_dot || tok == t_end) {
		ndx->ex = NULL;
		cs_nl();
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
		ndx->ex = parse_ex();
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else error("array variable");
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
		csbrl();
		nexttok();
		ndx->vx = h;
		nd->ri = parse_ex();
		expt_ntok(t_brrl);
		expt_ntok(t_brr);
	}
	else {
		expt(arrtok);
	}
}

S void parse_arr_swap2(ND* nd, byte arrtok, enum vartyp arrtype, char* s, ushort pos) {

	ND* ndx = nd + 1;
	nd->vf = op_swaparrael;
	nd->v1 = get_var(arrtype + 2, RW, s, pos);
	cs(tval);
	nexttok();
	expt_ntok(t_brr);
	cs_spc();

	if (tok == arrtok) {
		ndx->vx = parse_var(arrtype, RW);
		csbrr();
	}
	else if (tok == arrtok - 2) {
		nd->vf = op_swaparraelx;
		ushort h = get_var(arrtype + 2, RW, tval, code_utf8len);
		if (cod && h != nd->v1) error("must be the same array");
		cs(tval);
		csbrl();
		nexttok();
		ndx->ex = parse_ex();
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
		char s[16];
		ushort pos = code_utf8len;
		strcpy(s, tval);
		cs_tok_nt();
		csbrl();
		ND* ndx = mkndx();
		nd->ri = parse_ex();;

		if (tok == t_brr) {
			//* swap f[i] f[j]
			cs_tok_nt();
			nd->v1 = get_var(VAR_NUMARR, RD, s, pos);
			nd->vf = op_swapnumael;
			cs_spc();

			expt(t_vnumael);
			short h = parse_var(VAR_NUMARR, RD);
			if (h != nd->v1 && cod) error("must be the same array");
			ndx->ex = parse_ex();
			expt_ntok(t_brr);
		}
		else if (tok == t_brrl) {
			parse_arr_swap2(nd, t_vnumarr, VAR_NUMARR, s, pos);
		}
		else {
			expt(t_brr);
			
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
		char s[16];
		strcpy(s, tval);
		ushort pos = code_utf8len;
		cs_tok_nt();
		cs("$[");
		ND* ndx = mkndx();
		nd->ri = parse_ex();;

		if (tok == t_brr) {
			// swap f$[i] f$[j]
			cs_tok_nt();
			nd->v1 = get_var(VAR_STRARR, RD, s, pos);
			nd->vf = op_swapstrael;
			cs_spc();
			expt(t_vstrael);
			short h = parse_var(VAR_STRARR, RD);
			if (h != nd->v1 && cod) error("must be the same array");
			ndx->ex = parse_ex();
			expt_ntok(t_brr);
		}
		else if (tok == t_brrl) {
			parse_arr_swap2(nd, t_vstrarr, VAR_STRARR, s, pos);
		}
		else {
			expt(t_brr);
		}
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

S void parse_call_stat(ND* nd) {

	csb_tok_spc_nt();

	expt(t_name);
	const char* name = getn(tval);

	struct proc* p = proc_get(name);

	if (p == NULL) {
		struct vname* pf = get_vname(proc, name, VAR_SUBR);
		if (pf == NULL && proc != proc_p) pf = get_vname(proc_p, name, VAR_SUBR);
		if (pf == NULL) {
			error("not defined");
			return;
		}
		cs_tok_nt();
		nd->le = pf->sstart;
		nd->vf = op_callsubr;
		return;
	}

	cs_tok_nt();
	nd->le =p->start;
	if (p->start == NULL) {
		procdecl = realloc(procdecl, sizeof(struct procdecl) * (procdecl_len + 1));
		procdecl[procdecl_len].callref = nd;
		procdecl[procdecl_len].proc_i = p - proc_p;
		procdecl_len += 1;
	}
//kc
	nd->vf = op_callproc;

//	if (p == fastproc_addr) {
//		nd->vf = op_fastcall;
//	}
	ND* ndf = nd;
	ushort i = 0;

	while (1) {
		char b = p->parms[i];
		if (b < 'a') break;
		cs_spc();
		if (b == 'f') {
			nd->next = parse_ex();;
			nd = nd->next;
		}
		else if (b == 's') {
			nd->next = parse_strex();
			nd = nd->next;
		}
		else if (b == 'g') {
			nd->next = parse_numarrex();
			nd = nd->next;
		}
		else if (b == 't') {
			nd->next = parse_strarrex();
			nd = nd->next;
		}
		i += 1;
	}

	while (1) {
		char b = p->parms[i];
		if (b < 'A') break;

		cs_spc();
		ND* h = mknd();
		nd->next = h;
		nd = h;
		if (b == 'F') {
			expt(t_name);
			nd->v1 = parse_var(VAR_NUM, RW);
		}
		else if (b == 'S') {
			expt(t_vstr);
			nd->v1 = parse_var(VAR_STR, RW);
		}
		else if (b == 'G') {
			expt(t_vnumarr);
			nd->v1 = parse_var(VAR_NUMARR, RW);
			csbrr();
		}
		else if (b == 'H') {
			expt(t_vnumarrarr);
			nd->v1 = parse_var(VAR_NUMARRARR, RW);
			expt_ntok(t_brr);
		}
		else if (b == 'T') {
			expt(t_vstrarr);
			nd->v1 = parse_var(VAR_STRARR, RW);
			csbrr();
		}
		else if (b == 'U') {
			expt(t_vstrarrarr);
			nd->v1 = parse_var(VAR_STRARRARR, RW);
			expt_ntok(t_brr);
		}
		i += 1;
	}
	nd->next = NULL;
	ndf->ri = ndf->next;
}

S void optimize_ass(ND* nd) {

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
		nd->le = parse_numarrex();;
	}
	else if (tok == t_vstrarr) {
		nd->strf = op_strarrstr;
		nd->le = parse_strarrex();
	}
	else if (tok == t_vnumarrarr) {
		nd->strf = op_numarrstr;
		if (c == ']') {
			nd->strf = op_numarrarrstr;
			nd->v1 = parse_var(VAR_NUMARRARR, RD);
			expt_ntok(t_brr);
		}
		else {
			nd->le = parse_numarrex();
		}
	}
	else {
		nd->strf = op_strarrstr;
		if (c == ']') {
			nd->strf = op_strarrarrstr;
			nd->v1 = parse_var(VAR_STRARRARR, RD);
			expt_ntok(t_brr);
		}
		else {
			nd->le = parse_strarrex();
		}
	}
	return nd;
}

S ND* parse_sequ(void) {

	ND* sequ = NULL;
	ND* ndp = NULL;	// only because of "unused" warning

	while (1) {

		cs_nl();
		if (tok == t_eof && is_enter) {
			error("");
			break;
		}
		if (tok == t_hash) {
			parse_comment();
			nexttok();
		}
		else if (tok <= t_global) {

			if (tok == t_global) {
				parse_global_stat();
			}
			else if (tok == t_proc || tok == t_fastproc) {
				if (sequ_level != 0) error("not allowed here");
				loop_level += 1;
				if (!err && sequ_level < 16) nest_block[sequ_level] = codestrln;

				parse_proc();
//kc				if (tok == t_fastproc && cod) parse_fastproc();

				proc = proc_p;
				loop_level -= 1;
			}
			else if (tok == t_subr) {
				if  (sequ_level != 0) goto statement; // subr inside proc
				parse_subr();
			}
			else if (tok == t_on) {
				if (sequ_level != 0) error("not allowed here");
				parse_on_stat();
			}
			else if (tok == t_procdecl) {
				if (sequ_level != 0) error("not allowed here");
				parse_procdecl();
			}
			else if (tok == t_prefix) {
				if (sequ_level != 0) error("not allowed here");
				if (prefix_len == 0) {
					csb_tok_spc_nt();
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
			else {  // t_input_data
				if (sequ_level != 0) error("not allowed here");
				csb(tval);
				if (c != 0) cs_nl();
				parse_input_data();
				nexttok();
			}
		}

		else {
			ND* nd;
		statement:
			nd = mknd();
			opln_add(nd, fmtline);
			if (sequ == NULL) sequ = nd;
			else ndp->next = nd;
			ndp = nd;

			// -----------------------------------------------------------------------
			if (tok == t_name) {
				nd->v1 = parse_var(VAR_NUM, WR);
				cs_spc();
				if (tok == t_eq) nd->vf = op_flass;
				else if (tok == t_pleq) nd->vf = op_flassp;
				else if (tok == t_mineq) nd->vf = op_flassm;
				else if (tok == t_asteq) nd->vf = op_flasst;
				else if (tok == t_diveq) nd->vf = op_flassd;
				else error("= += -= *= /=");
				cs_tok_spc_nt();
				nd->ri = parse_ex();
				if (cod) {
					optimize_ass(nd);
				}
			}
			else if (tok == t_if) {
				parse_if_stat(nd);
			}
			else if (tok == t_while) {
				loop_level += 1;
				stat_begin_nest();
				nd->le = parse_log_ex();
				nd->ri = parse_sequ_end();
				nd->vf = op_while;
				nexttok();
				loop_level -= 1;
			}
			else if (tok == t_for) {
				parse_for_stat(nd);
			}
			else if (tok == t_call) {
				parse_call_stat(nd);
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
				else error("=, &=");
				cs_tok_spc_nt();
				nd->ri = parse_strex();
			}
			else if (tok == t_subr) {
				if (loop_level != 1 || proc == proc_p) error("not allowed here");
				parse_subr();
				nd->vf = op_nop;
			}
			else if (tok >= t_swap && tok <= t_sys) {

				if (tok == t_swap) {
					parse_swap_stat(nd);
				}
				else if (tok == t_break) {
					if (loop_level == 0) error("not in a loop or procedure");
					csb_tok_nt();
					cs_spc();
					ushort h = tvalf;
					if (tok != t_lnumber || h != tvalf) error("break level");
					if (loop_level < h) error("break level too high");
					cs(tval);
					nd->vf = op_break;
					nd->v1 = h;
					nexttok();
				}
				// ----------------------------------------------------------------------------
				else if (tok == t_clear) {
					csb_tok_nt();
					nd->vf = op_clear;
					prog_props |= 1;
				}
				else if (tok == t_arrbase) {
					parse_arrbase_stat(nd);
				}
				else if (tok == t_drawgrid) {
					csb_tok_nt();
					nd->vf = op_sys;
					nd->v1 = 5;
				}
				else  {				// t_sys
					parse_sys_stat(nd);
				}
			}

			else if (tok >= t_print && tok <= t_curve) {
				csb_tok_spc_nt();
				if (cod) {
					if (tokpr == t_sleep) {
						nd->vf = op_sleep;
					}
					else if (tokpr == t_timer) {
						nd->vf = op_timer;
					}
					else if (tokpr == t_color) {
						nd->vf = op_color;
					}
					else if (tokpr == t_linewidth) {
						nd->vf = op_linewidth;
					}
					else if (tokpr == t_textsize) {
						nd->vf = op_textsize;
					}
					else if (tokpr == t_move) {
						nd->vf = op_move;
					}
					else if (tokpr == t_line) {
						nd->vf = op_line;
						prog_props |= 1;
					}
					else if (tokpr == t_rect) {
						nd->vf = op_rect;
						prog_props |= 1;
					}
					else if (tokpr == t_arc) {
						nd->vf = op_arc;
						prog_props |= 1;
					}
					else if (tokpr == t_rgb) {
						nd->vf = op_rgb;
					}
					else if (tokpr == t_circle) {
						nd->vf = op_circle;
						prog_props |= 1;
					}
					else if (tokpr == t_text) {
						nd->vf = op_text;
						prog_props |= 5;
					}
					else if (tokpr == t_print || tokpr == t_pr) {
						nd->vf = op_print;
						prog_props |= 8;
					}
					else if (tokpr == t_write) {
						nd->vf = op_write;
						prog_props |= 8;
					}
					else if (tokpr == t_background) {
						nd->vf = op_background;
					}
					else if (tokpr == t_mouse_cursor) {
						nd->vf = op_mouse_cursor;
					}
					else if (tokpr == t_polygon) {
						nd->vf = op_polygon;
						prog_props |= 1;
					}
					else if (tokpr == t_curve) {
						nd->vf = op_curve;
						prog_props |= 1;
					}
					else if (tokpr == t_sound) {
						nd->vf = op_sound;
						prog_props |= 2;
					}
					else if (tokpr == t_random_seed) {
						nd->vf = op_random_seed;
					}
					else if (tokpr == t_translate) {
						nd->vf = op_translate;
					}
					else if (tokpr == t_rotate) {
						nd->vf = op_rotate;
					}
					else if (tokpr == t_numfmt) {
						nd->vf = op_numfmt;
					}
					else {
						internal_error(__LINE__);
						return 0;
					}
				}
				if (tokpr == t_pr || tokpr == t_print) {
					if (tok >= t_vnumarr && tok <= t_vstrarrarr) {
						nd->le = parse_strarr_term();
					}
					else {
						nd->le = parse_strex();
					}
				}
				else if (tokpr <= t_text) {
					nd->le = parse_strex();
				}
				else if (tokpr <= t_arc) {
					int t = tokpr;
					ND* ndx;
					if (t >= t_rgb) ndx = mkndx();
					nd->le = parse_ex();
					if (t >= t_move) {
						cs_spc();
						nd->ri = parse_ex();
						if (t >= t_rgb) {
							cs_spc();
							ndx->ex = parse_ex();
						}
					}
				}
				else if (tokpr <= t_curve) {
					nd->le = parse_numarrex();
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
		if (tok == t_dot || tok <= t_end) break;
		if (tok == t_eof && !is_enter) break;
	}
	if (sequ != NULL) ndp->next = NULL;
	return sequ;
}
