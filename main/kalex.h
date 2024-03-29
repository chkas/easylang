/*	kalex.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "created by" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

static const char* token_list[] = {
	"",
	"else", "elif", "until", "end",
	"proc", "func", "fastfunc", "procdecl","funcdecl", "subr", "on", "prefix", "input_data", "global",
	"if", "while", "for", "repeat",
	"and", "or", "not", "mod", "mod1", "div", "div1",
	"call",  "len",

	"print", "pr", "write", "text",
	"sleep", "timer", "textsize", "linewidth", "coord_rotate", "circle",
	"color", "background", "mouse_cursor", "random_seed",
	"move", "line", "coord_translate", "rect", "numfmt",
	"color3", "circseg",
	"sound", "polygon", "curve",

	"return", "swap", "clear", "break", "drawgrid", "arrbase", "sys",

	"systime", "error", "mouse_x", "mouse_y", "randomf", "pi",
	"random", "randint", "sqrt", "log10", "abs", "sign", "bitnot", "floor", "sin", "cos", "tan", "asin", "acos", "atan",
	"atan2", "pow", "bitand", "bitor", "bitxor", "bitshift", "lower", "higher",
	"number", "strcode", "strpos", "strcmp",

	"input", "sysfunc", "keybkey", "strchar", "timestr", "strjoin", "substr",

	"+", "-", "*", "/", "#", "<", ">", ".", "=", "&",
	"(", ")", "[", "]", "][", "<>", "<=", ">=", "&=", "+=", "*=", "/=", "-=",

	"number", "string",
	"name", "string variable",

	"array element", "string array element",
	"array", "string array",
	"array array", "string array array",
	""
};

enum token_tok {
	t_default = 0,
	t_else, t_elif, t_until, t_end,
	t_proc, t_func, t_fastfunc, t_procdecl, t_funcdecl, t_subr, t_on, t_prefix, t_input_data, t_global,
	t_if, t_while, t_for, t_repeat,
	t_and, t_or, t_not, t_mod, t_mod1, t_divi, t_divi1,
	t_call, t_len,

	t_print, t_pr, t_write, t_text,
	t_sleep, t_timer, t_textsize, t_linewidth, t_rotate, t_circle,
	t_color, t_background, t_mouse_cursor, t_random_seed,
	t_move, t_line, t_translate, t_rect, t_numfmt,
	t_rgb, t_circseg,
	t_sound, t_polygon, t_curve,

	t_return, t_swap, t_clear, t_break, t_drawgrid, t_arrbase, t_sys,
	
	t_systime, t_error, t_mouse_x, t_mouse_y, t_randomf, t_pi,
	t_random, t_randint, t_sqrt, t_log10, t_abs, t_sign, t_bitnot, t_floor, t_sin, t_cos, t_tan, t_asin, t_acos, t_atan,
	t_atan2, t_pow, t_bitand, t_bitor, t_bitxor, t_bitshift, t_lower, t_higher,
	t_number, t_strord, t_strpos, t_strcompare,

	t_input, t_sysfunc, t_keyb_key, t_strchar, t_timestr, t_strjoin, t_substr,

	t_plus, t_minus, t_mult, t_div, t_hash, t_lt, t_gt, t_dot, t_eq, t_amp,
	t_pal, t_par, t_brl, t_brr, t_brrl, t_neq, t_le, t_ge, t_ampeq, t_pleq, t_asteq, t_diveq, t_mineq,

	t_lnumber, t_lstr,
	t_name, t_vstr,

	t_vnumael, t_vstrael,
	t_vnumarr, t_vstrarr,
	t_vnumarrarr, t_vstrarrarr,

	t_eof
};

static byte tok;
static byte tokpr;

static char is_numfunc() { return tok >= t_systime && tok <= t_strcompare; }
static char is_strfunc() { return tok >= t_input && tok <= t_substr; }

static char err;
static int ind_tok, indc;

static char is_enter;

static const char* parse_str;

#define INDENT 3

static char nlspc[16 * INDENT + 2] = { '\n', 0 };
static char* spc = nlspc + 1;
static short sequ_level;

static void space_add() {
	if (sequ_level < 15) strcpy(spc + sequ_level * INDENT, "    ");
	sequ_level += 1;
}
static void space_sub() {
	sequ_level -= 1;
	if (sequ_level <= 15) spc[sequ_level * INDENT] = 0;
}

//------------------------------------------------

static char syntax_high;

static int utf8len(const char* s) {
	int len = 0;
	while (1) {
		int c = (unsigned char)*s;
		if (!c) break;
		if (c < 0x80) len++;
		else if (c >= 0xc0) {
			len++;
			if (c >= 0xf0) len++;	// js is utf16
		}
		s++;
	}
	return len;
}

static int codestrspc;
static int codestrln;
static char* codestr;

static void freecodestr() {
	free(codestr);
	codestrln = 0;
	codestr = NULL;
	codestrspc = 0;
}

static int code_utf8len;

static void col(const char* s, int h) {
	while (codestrln + h > codestrspc) {
		codestrspc += 1024;
		codestr = _realloc(codestr, codestrspc + 1);
	}
	memcpy(codestr + codestrln, s, h);
	codestrln += h;
}
static void csnlspc() {
	if (err) return;
	int h = INDENT * sequ_level + 1;
	col(nlspc, h);
	code_utf8len += h;
}

static void co(const char* s) {
	col(s, strlen(s));
}
static void coc(char c) {
	if (codestrln >= codestrspc) {
		codestrspc += 1024;
		codestr = _realloc(codestr, codestrspc + 1);
	}
	codestr[codestrln] = c;
	codestrln += 1;
}

static void cs(const char* s) {
	if (err) return;
	int h = strlen(s);
	col(s, h);
	code_utf8len += h;
}

static void cs_spc(void) {
	if (err) return;
	coc(' ');
	code_utf8len += 1;
}
static void csbrrsp() {
	if (err) return;
	col("] ", 2);
	code_utf8len += 2;
}
static void csbrr() {
	if (err) return;
	coc(']');
	code_utf8len += 1;
}
static void csbrl() {
	if (err) return;
	coc('[');
	code_utf8len += 1;
}

static const char* errorstr = "";

const char* errstr(void) {
	return errorstr;
}

#ifndef __EMSCRIPTEN__
void error_line(const char* s, int pos) {
	int i = 0;
	int line = 1;
	int col = 1;
	// error pos input file
	while (i < pos) {
		if (parse_str[i] == '\n') {
			line += 1;
			col = 0;
		}
		if (parse_str[i] == '\t') {
			pos -= 1;
		}
		col++;
		i++;
	}
	fprintf(stderr, "Error: %d:%d - %s\n", line, col, s);
}
#endif

static ushort loop_level;
static short nestlevel_err;

static void error(const char* s) {
	if (err) return;
	if (syntax_high) {
		nestlevel_err = sequ_level - 1;
		if (nestlevel_err >= 16) nestlevel_err = -1;
	}
	err = 1;
	cs_spc();
	errorstr = s;
	cod = 0;
#ifndef __EMSCRIPTEN__
	error_line(s, ind_tok);
#endif
}

static void error_pos(const char* s, int pos) {

	if (err) return;
	code_utf8len = pos;
	ind_tok = pos;
	err = 1;
	errorstr = s;
	cod = 0;
#ifndef __EMSCRIPTEN__
	error_line(s, pos);
#endif
}

static void error_tok(int t) {
	error(token_list[t]);
}

static void internal_error(int n) {
	fprintf(stderr, "internal error: %d\n", n);
	error("internal error");
}

static void esc_html(const char* s) {
	while (*s) {
		if (*s == '&') co("&amp;");
		else if (*s == '<') co("&lt;");
		else coc(*s);
		s += 1;
	}
}

#if 0
static void csx(const char* s) {
	if (err) return;
	if (*s == 0) return;
	code_utf8len += utf8len(s);
	if (syntax_high) {
		esc_html(s);
	}
	else co(s);
}
#endif

static void csi(const char* s) {
	if (err) return;
	if (*s == 0) return;
	code_utf8len += utf8len(s);
	if (syntax_high) {
		co("<i>");
		esc_html(s);
		co("</i>");
	}
	else co(s);
}

static char* bold1;
static char* bold2;

static void csb(const char* s) {
	if (err) return;
	code_utf8len += strlen(s);
	co(bold1);
	co(s);
	co(bold2);
}
static void csf(const char* s) {
	if (err) return;
	code_utf8len += strlen(s);
	if (syntax_high) {
		co("<s>");
		co(s);
		co("</s>");
	}
	else
		co(s);
}

static void cst(int t) {
	if (t < t_plus) csb(token_list[t]);
	else cs(token_list[t]);
}

static char tval[24];

static int fmtline;

static byte has_semicolon;

static void cs_nl() {
	if (has_semicolon) {
		cs(" ; ");
		has_semicolon = 0;
	}
	else {
		if (fmtline > 0) csnlspc();
		fmtline += 1;
	}
}

static char cp, c, cn;
static int indc_add;

#define EOT 0

static void nextc() {
	cp = c;
	c = cn;
	if (err) {
		cn = EOT;
		return;
	}
	cn = parse_str[indc];
	if (cn != EOT) indc++;
	else indc_add++;

}

static double tvalf;

static void read_number(void) {
	char *p;
	if (cn == EOT) indc++;
	const char *p0 = parse_str + indc - 2;
	tvalf = strtod(p0, &p);
	indc = p - parse_str;
	if (p > p0 + 23) p = (char*)p0 + 23;
	memcpy(tval, p0, p - p0);
	tval[p - p0] = 0;
	cp = parse_str[indc - 1];
	c = parse_str[indc];
	if (c == EOT) {
		indc_add++;
		if (cn != EOT) {
			cn = EOT;
			indc_add++;
		}
	}
	else {
		indc++;
		cn = parse_str[indc];
		if (cn != EOT) indc++;
		else indc_add++;
	}
}

static void read_line(char* buf, int sz) {
	int i = 0;
	while (1) {
		if (c == '\r') nextc();
		if (c == '\n') {
			nextc();
			break;
		}
		if (c == EOT) break;
		if (i < sz - 1) {
			buf[i] = c;
			i += 1;
		}
		nextc();
	}
	if (i < sz) buf[i] = 0;
}


#if 0
static void parse_comment() {

	char buf[1024];
	cs("# ");
	if (c == ' ') nextc();
	read_line(buf, 1024);
	csi(buf);
}
#else
static void parse_comment() {
	char buf[1024];
	if (c != '#') {
		cs("# ");
		if (c == ' ') nextc();
		read_line(buf, 1024);
		csi(buf);
	}
	else {
		nextc();
		cs("##");
		while (1) {
			read_line(buf, 1024);
			int h = strlen(buf);
			if (h >= 3 && strcmp(buf + h - 3, "# #") == 0) break;
			csi(buf);
			if (c == EOT) return;
			cs("\n");
			fmtline += 1;

		}
		cs(spc);
		cs("# #");
	}
}
#endif

static char* input_data = NULL;
static uint input_data_size = 0;

static void parse_input_data() {

	read_line(NULL, 0);
	char buf[65536];
	while (1) {
		read_line(buf, 65536);
//		csx(buf);
		csi(buf);
		if (cod) {
			uint h = input_data_size + strlen(buf) + 1;
			input_data = realloc(input_data, h);
			strcpy(input_data + input_data_size, buf);
			input_data_size = h;
		}
		if (c == EOT) break;
		cs_nl();
	}
}
static int tbl_a[] = { t_and, t_abs, t_asin, t_acos, t_atan, t_atan2, t_arrbase, 0 } ;
static int tbl_b[] = { t_break, t_background, t_bitand, t_bitor, t_bitxor, t_bitshift, t_bitnot, 0 } ;
static int tbl_c[] = { t_call, t_clear, t_color, t_circle, t_cos, t_rgb, t_circseg, t_curve, t_rotate, t_translate, 0 } ;
static int tbl_d[] = { t_divi, t_divi1, t_drawgrid, 0 } ;
static int tbl_e[] = { t_else, t_elif, t_end, t_error, 0 };
static int tbl_f[] = { t_for, t_func, t_floor, t_funcdecl, t_fastfunc, 0 };
static int tbl_g[] = { t_global, 0 };
static int tbl_h[] = { t_higher, 0 };
static int tbl_i[] = { t_if, t_input, t_input_data, 0 };
static int tbl_j[] = { 0 };
static int tbl_k[] = { t_keyb_key, 0 };
static int tbl_l[] = { t_len, t_lower, t_line, t_linewidth, t_log10, 0 };
static int tbl_m[] = { t_mod, t_mod1, t_move, t_mouse_x, t_mouse_y, t_mouse_cursor, 0 };
static int tbl_n[] = { t_not, t_numfmt, t_number, 0 };
static int tbl_o[] = { t_or, t_on, 0 };
static int tbl_p[] = { t_print, t_proc, t_procdecl, t_pr, t_pi, t_pow, t_polygon, t_prefix, 0 };
static int tbl_q[] = { 0 };
static int tbl_r[] = { t_repeat, t_return, t_randomf, t_randint, t_rect, t_random_seed, t_random, 0 };
static int tbl_s[] = { t_swap, t_subr, t_sleep, t_systime, t_substr, t_sqrt, t_sin, t_strord, t_strpos, t_strcompare, t_sysfunc, t_strchar, t_strjoin, t_sign, t_sound, t_sys, 0 };
static int tbl_t[] = { t_tan, t_timestr, t_text, t_timer, t_textsize, 0 };
static int tbl_u[] = { t_until, 0 };
static int tbl_v[] = { 0 };
static int tbl_w[] = { t_while, t_write, 0 };

static int* tbl_all[] = {
	tbl_a, tbl_b, tbl_c, tbl_d, tbl_e, tbl_f, tbl_g, tbl_h,
	tbl_i, tbl_j, tbl_k, tbl_l, tbl_m, tbl_n, tbl_o, tbl_p,
	tbl_q, tbl_r, tbl_s, tbl_t, tbl_u, tbl_v, tbl_w
} ;

static void nexttok() {

	tokpr = tok;
	if (err) {
		tok = t_eof;
		return;
	}
	while (1) {
		if (c ==  ';') has_semicolon = 1;
		else if (c == EOT || (c > ' ' && c != ',')) break;
		// if (c != ' ' && c != '\t' && c != '\n' && c != ',' && c != ';' && c != '\r') break;
		nextc();
	}

	ind_tok = indc + indc_add - 2;

	if (c == EOT) {
		tok = t_eof;
		strcpy(tval, "eof");
		nextc();
		return;
	}

	if (c == '"') {
		tok = t_lstr;
		return;
	}

	if (isdigit(c) || (!isalnum(cp) && c == '-' && isdigit(cn))) {
		read_number();
		tok = t_lnumber;
		return;
	}
	if (isalpha(c) || c == '_') {
		int i = 0;
		while (1) {
			if (i < 15) tval[i++] = c;
			else error("name to long");
			nextc();
			if (!isdigit(c) && !isalpha(c) && c != '_') break;
		}
		tval[i] = 0;
//		int ti = t_default + 1;

#if 0
		int ti = 1;
		while (ti <= t_substr) {
			if (strcmp(token_list[ti], tval) == 0) {
				tok = ti;
				return;
			}
			ti += 1;
		}
#else
		if (tval[1]) {
			int fc = tval[0];
			if (fc >= 'a' && fc <= 'w') {
				int* tbl = tbl_all[fc - 'a'];
				while (*tbl) {
					if (strcmp(token_list[*tbl], tval) == 0) {
						tok = *tbl;
						return;
					}
					tbl += 1;
				}
			}
		}
#endif
		// name
		if (c == '[') {
			nextc();
			if (c == ']') {
				tok = t_vnumarr;
				nextc();

				if (c == '[') {
					nextc();
					tok = t_vnumarrarr;
				}

			}
			else {
				tok = t_vnumael;
			}
		}
		else if (c == '$') {
			nextc();
			if (c == '[') {
				nextc();
				if (c == ']') {
					tok = t_vstrarr;
					nextc();
					if (c == '[') {
						nextc();
						tok = t_vstrarrarr;
					}
				}
				else {
					tok = t_vstrael;
				}
			}
			else {
				tok = t_vstr;
			}
		}
		else {
			tok = t_name;
		}
		return;
	}
	nextc();
	tval[0] = cp;
	tval[1] = c;
	tval[2] = 0;
	if (c == '=') {
		for (int ti = t_le; ti <= t_mineq; ti++) {
			if (token_list[ti][0] == cp) {
				tok = ti;
				nextc();
				return;
			}
		}
		if (cp == '!') {
			tval[0] = cp = '<';
			tval[1] = c = '>';
		}
		else if (cp == '=') {
			nextc();
		}
	}
	if (c == '>' && cp == '<') {
		tok = t_neq;
		nextc();
		return;
	}
	if (c == '[' && cp == ']') {
		tok = t_brrl;
		nextc();
		return;
	}
	tval[1] = 0;
	for (int ti = t_plus; ti <= t_brr; ti++) {
		if (token_list[ti][0] == cp) {
			tok = ti;
			return;
		}
	}
	tok = t_default;
}

// -------------------------------------------------------------------------------
//#define UMO (ushort)-1

static char* cstrs_p;
static unsigned cstrs_len;

static void cstrs_free() {
	if (cstrs_p) {
		free(cstrs_p);
		cstrs_p = NULL;
		cstrs_len = 0;
	}
}

static uint cstrs_add(const char* s) {
	ushort l = strlen(s) + 2;
	cstrs_p = (char*)_realloc(cstrs_p, cstrs_len + l);
	*(cstrs_p + cstrs_len) = 0;
	strcpy(cstrs_p + cstrs_len + 1, s);
	cstrs_len += l;
	return cstrs_len - l;
}
// --------------------------------------------------------

struct vname {
	char name[16];
	union {
		struct {
			short id;
			ushort srcpos;
		};
		ND* sstart;
	};
	byte typ;
	byte access;
};

struct proc {
	struct vname *vname_p;
	char name[16];
	char parms[16];
	ushort vname_len;
	ND* start;
// float, str, (intarr + numarr + strarr)
	ushort varcnt[3];
	byte typ;
	byte anonym_id;
};
struct procdecl {
	ushort proc_i;
	ND* callref;
};

static struct proc* proc;
static struct proc* proc_p;
static ushort proc_len;
static struct procdecl* procdecl;
static ushort procdecl_len;

//---------------------------------------------------------------

static char prefix[16];
static int prefix_len;
static char name_anonym[5];

static const char* getn(const char* name) {
	if (name[0] == '_' && name[1] == 0) {
		proc->anonym_id += 1;
		sprintf(name_anonym, "_%d", proc->anonym_id);
		name = name_anonym;
	}
	if (prefix_len) {
		if (prefix_len + strlen(name) > 15) {
			error("name too long");
			return name;
		}
		strcpy(prefix + prefix_len, name);
		name = prefix;
	}
	return name;
}

static struct proc* proc_get(const char* name) {
	struct proc *p = proc_p;
	while (p < proc_p + proc_len) {
		if (strcmp(name, p->name) == 0) return p;
		p += 1;
	}
	return NULL;
}

static struct proc* proc_add(const char* name) {
	proc_len += 1;
	proc_p = (struct proc *)_realloc(proc_p, proc_len * sizeof(struct proc));
	struct proc* p = proc_p + proc_len - 1;
	memset(p, 0, sizeof(struct proc));
	strcpy(p->name, name);
	return p;
}

static void proc_free(void) {

	if (proc_p == NULL) return;
	struct proc *p = proc_p;
	while (p < proc_p + proc_len) {
		free(p->vname_p);
		p += 1;
	}
	free(proc_p);
	proc_p = NULL;
	proc_len = 0;
	free(procdecl);
	procdecl = NULL;
	procdecl_len = 0;
}

static struct {
	ND* mouse_down;
	ND* mouse_up;
	ND* mouse_move;
	ND* key_down;
	ND* animate;
	ND* timer;
} seq;

static ushort prog_props;

enum vartyp { VAR_NUM, VAR_STR,
	VAR_NUMARR, VAR_STRARR,
	VAR_NUMARRARR, VAR_STRARRARR, VAR_SUBR };

static struct vname* get_vname(struct proc* f, const char* name, char typ) {

	struct vname *p = f->vname_p;
	if (!f->vname_p) return NULL;   // because NULL + 0 is UB
	while (p < f->vname_p + f->vname_len) {
		if (p->typ == typ && strcmp(name, p->name) == 0) return p;
		p += 1;
	}
	return NULL;
}

static struct vname* add_vname(struct proc* f, const char* name, char typ, ushort pos) {
	if (f->vname_len % 8 == 0) {
		f->vname_p = (struct vname *)_realloc(f->vname_p, (f->vname_len + 8) * sizeof(struct vname));
	}
	struct vname *p = f->vname_p + f->vname_len;
	f->vname_len += 1;
	strcpy(p->name, name);
	p->typ = typ;
	p->srcpos = pos;
	return p;
}

enum varaccess { WR = 1, RD, RW };

enum arrtyp { ARR_XXX, ARR_NUM, ARR_STR, ARR_ARR, ARR_AEL, ARR_AELSTR };

enum paramtyp { PAR_NUM, PAR_STR, PAR_ARR, PAR_RNUM, PAR_RSTR, PAR_RARR};

static const char* vex(ushort typ) {
	if (typ == VAR_NUM) return "";
	else if (typ == VAR_STR) return "$";
	else if (typ == VAR_NUMARR) return "[";
	else if (typ == VAR_STRARR) return "$[";
	else if (typ == VAR_NUMARRARR) return "[][";
	else return "$[][";
}

static void lvar(byte typ, byte access, byte mode) {

	if (cod && mode) {
		const char* name = getn(tval);
		if (name == name_anonym) access = RW;

		struct vname* p = get_vname(proc, name, typ);
		if (p != NULL) error("already used");

		p = add_vname(proc, name, typ, code_utf8len);
		if (p == NULL) return;
		p->access = access;
		ushort h = typ;
		if (typ > VAR_NUMARR) h = VAR_NUMARR;
		p->id = proc->varcnt[h];
		proc->varcnt[h] += 1;
	}
	cs(tval);
	cs(vex(typ));
	nexttok();
}

static struct vname* add_var(struct proc* f, const char* name, ushort typ, ushort pos) {
	struct vname* p = add_vname(f, name, typ, pos);
	p->access = 0;
	if (typ > VAR_NUMARR) typ = VAR_NUMARR;
	p->id = f->varcnt[typ];
	f->varcnt[typ] += 1;
	return p;
}

static short get_var(ushort typ, ushort access, const char* name, ushort pos) {
	if (!cod) return 0;
	name = getn(name);
	if (name == name_anonym) access = RW;

	struct vname* p;
	if (proc == proc_p) {
		p = get_vname(proc_p, name, typ);
		if (p == NULL) p = add_var(proc_p, name, typ, pos);
		p->access |= access;
		return -(p->id + 1);
	}

	// in proc
	p = get_vname(proc, name, typ);
	if (p) {
		p->access |= access;
		return p->id;
	}
	p = get_vname(proc_p, name, typ);
	if (p == NULL) {
		// create local variable
		p = add_var(proc, name, typ, pos);
		p->access |= access;
		return p->id;
	}
	p->access |= access;
	return -(p->id + 1);
}

static short parse_var(ushort typ, ushort access) {
	short id = get_var(typ, access, tval, code_utf8len);
	cs(tval);
	cs(vex(typ));
	nexttok();
	return id;
}

// -------------------------------------------------------------------------------

struct opln {
	ND* nd;
	ushort line;
};

static struct opln* opln_p;
static ushort opln_len;

static void opln_add(ND* nd, ushort line) {
	if (cod) {
		if (opln_len % 64 == 0) {
			opln_p = (struct opln*)_realloc(opln_p, (opln_len + 64) * sizeof(struct opln));
		}
		opln_p[opln_len].nd = nd;
		opln_p[opln_len].line = line;
		opln_len += 1;
	}
}

// ---------------------------------------------------------

static ushort onstats;

static void parse_clean() {
	freecodestr();

	cstrs_free();
	code_free();

	proc_free();

	free(opln_p);
	opln_p = NULL;
	opln_len = 0;

	free(input_data);
	input_data = NULL;
}
static void parse_prepare() {
	parse_clean();

	code_utf8len = 0;
	spc[0] = 0;
	err = 0;
	cn = ' ';
	indc_add = 0;
	indc = 0;
	ind_tok = 0;
	has_semicolon = 0;
	onstats = 0;

	input_data_size = 0;
	prefix_len = 0;
	loop_level = 0;

	uint h = strlen(parse_str);
	codestrspc = h + h / 2;
	codestr = _realloc(NULL, codestrspc + 1);
	proc = proc_add("_GLOBAL_");

	seq.mouse_down = NULL;
	seq.mouse_up = NULL;
	seq.mouse_move = NULL;
	seq.key_down = NULL;
	seq.animate = NULL;
	seq.timer = NULL;
	prog_props = 0;
}

