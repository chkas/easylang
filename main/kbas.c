/*	kbas.c

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

#include "klib.h"

#define ARRAY_SIZE(x) (int)(sizeof((x)) / sizeof((x)[0]))
#define S static

struct arr {
	union {
		void* p;
		double* pnum;
		STR* pstr;
		byte* pbyte;
		struct arr* parr;
	};
	//uint len;
	int len;
	char base;
	char typ;
};
typedef struct arr ARR;

struct node {
	union {
		struct {
			union {
				double (*numf)(struct node*);
				int (*intf)(struct node*);
				void (*vf)(struct node*);
				STR (*strf)(struct node*);
				ARR (*arrf)(struct node*);
			};
			struct node* next;
			union {
				struct {
					union {
						struct node* le;
						struct {
							short v1;
							short v1a;
						};
					};
					union {
						struct node* ri;
						struct {
							short v2;
							short v2a;
						};
						float cfl32;
					};
				};
				double cfl;
				uint str;
			};
		};

// for extendend op
		struct {
			union {
				struct {
					union {
						struct node* ex;
						struct {
							short vx;
							short vxa;
						};
					};
					union {
						struct node* ex2;
						struct {
							short vx2;
							short vx2a;
						};
					};
					struct node* ex3;
					struct node* ex4;
				};
				struct {
					struct node* bxnd;
					byte bx0;
					byte bx1;
					byte bx2;
					byte bx3;
					byte bx[8];
				};
			};
		};
	};
};
typedef struct node ND;

static char cod;

//#define BLSZ 256
#define BLSZ 512
//#define BLSZ 1024
ND progmem0[BLSZ + 1];

ND* progmem = progmem0;
ND* ndnxt;

ND* mknd(void) {
	if (!cod) return progmem;
	if (ndnxt >= progmem + BLSZ - 2) {
//		fprintf(stderr, "increase memory\n");
		ND* nd = malloc((BLSZ + 1) * sizeof(ND));
		progmem[BLSZ].ex = nd;
		progmem = nd;
		progmem[BLSZ].ex = NULL;
		ndnxt = progmem;
	}
	return ndnxt++;
}
ND* mkndx(void) {
	if (!cod) return progmem + 1;
	return ndnxt++;
}
S void code_free() {
	ND* nd = progmem0[BLSZ].ex;

	while (nd) {
		ND* h = nd[BLSZ].ex;
//		fprintf(stderr, "free\n");
		free(nd);
		nd = h;
	}
	progmem = progmem0;
	progmem[BLSZ].ex = NULL;
	ndnxt = progmem;
}


ushort sysconfig;

const char* errstrs[] = {
	"", "], ][", "=, +=, ..", "=, &=",  "=, <>",
	"=, in", "to, downto, step",
	"<cmd>, end, .", "<cmd>, else, elif, end, .", "<cmd>, until", "<cmd>", "<cmd>", "<cmd>", "variable", "array variable", "array or string variable",
	"number", "string", "number, string", "array", "string array", "array array", "string array array",
	"event", "topleft ...", "=, <>, < ..."
};

enum {
	ERR_OK, ERR_BR, ERR_ASSIGN, ERR_STRASS, ERR_STRCMP,
	ERR_FOR, ERR_FOR2,
	ERR_CMDE, ERR_CMDEL, ERR_CMDU, ERR_CMD0, ERR_CMD1, ERR_CMD, ERR_V, ERR_VARR, ERR_VARRSTR, ERR_NUMB, ERR_STR, ERR_NUMSTR, ERR_ARR, ERR_STRARR, ERR_ARRARR, ERR_STRARRARR,
	ERR_EVT, ERR_SYSCONF, ERR_CMP,
	ERR_LOG, ERR_ARREL
};

const char* tabstrs[] =
	{
	"", ":] :][", ":= :+= :-= :*= :/= ", ":= :&= ", ":= :<> ",
	":= :in :to :range0 ", ":to :downto :step "
};

static char is_tab;
static int caret_pos;

#include "klex.h"
#include "kfunc.h"
#include "kwasm.h"

static char is_enter;

#include "kparse.h"

static const char* sysconf_str[] = { "topleft", "radians", "zero_based", "hex_numbers" };

static void parse_sysconf(void) {
	sysconfig = 0;
	while (1) {
		if (tok == t_hash) {
			parse_comment();
			nexttok();
		}
		else if (tok == t_name && strcmp(tval, "sysconf") == 0) {
			csb_tok_spc_nt();
			int conf = 1;
			int i;
			for (i = 0; i < 4; i++) {
				if (strcmp(tval, sysconf_str[i]) == 0) {
					sysconfig |= conf;
					break;
				}
				conf *= 2;
			}
			if (i == 4) errorx(ERR_SYSCONF);
			csb_tok_nt();
		}
		else break;
		csnl();
	}
}

//------------------------------------------------------------

static STR tabbuf;

void appt(const char* s) {
	str_append(&tabbuf, ":");
	str_append(&tabbuf, s);
	str_append(&tabbuf, " ");
}
void apptab(const char* s, char* ts, short l) {
	if (strncmp(ts, s, l) == 0) appt(s);
}
void apptabi(const char* s, char* ts, short l) {
	if (strncmp(ts, s, l) == 0) {
		str_append(&tabbuf, ": ");
		str_append(&tabbuf, s);
		str_append(&tabbuf, " ");
	}
}
void append_tabb(struct proc* pro, char* ts, short l, short typ) {
	struct vname *v = pro->vname_p;
	if (v) while (v < pro->vname_p + pro->vname_len) {
		if (strncmp(ts, v->name, l) == 0 && (typ == -1  || v->typ % 2 == typ ||  v->typ == typ )) {
			str_append(&tabbuf, ":");
			str_append(&tabbuf, v->name);
			str_append(&tabbuf, vexf(v->typ));
			if (v->typ < 2) str_append(&tabbuf, " ");
		}
		v += 1;
	}
}
void atab_names(char* ts, short l, short typ, byte withproc) {
	append_tabb(proc_p, ts, l, typ);
	if (errproc != proc_p) append_tabb(errproc, ts, l, typ);
	if (withproc) {
		struct proc* p = proc_p + 1;
		while (p < proc_p + proc_len) {
			if (p->typ == typ + 1) apptab(p->name, ts, l);
			p += 1;
		}
	}
}
void atab_arrs(char* ts, short l) {
	atab_names(ts, l, 2, 0);
	atab_names(ts, l, 3, 0);
	atab_names(ts, l, 4, 0);
	atab_names(ts, l, 5, 0);
	atab_names(ts, l, 6, 0);
}

void atab_numfuncs(char* ts, short l) {
	apptab(tokstr[t_len], ts, l);
	for (byte t = t_mouse_x; t <= t_strcompare; t++) {
		apptab(tokstr[t], ts, l);
	}
}
void atab_strfuncs(char* ts, short l) {
	for (byte t = t_input; t <= t_substr; t++) {
		apptab(tokstr[t], ts, l);
	}
}
void atab_strarrfuncs(char* ts, short l) {
	apptab("strchars", ts, l);
	apptab("strsplit", ts, l);
	apptab("strtok", ts, l);
}
void atab_arrfuncs(char* ts, short l) {
	apptab("number", ts, l);
}

static const char* inopstr[] = { "+", "-", "*", "/", "div", "mod", NULL };
static const char* logopstr[] = { "and", "or", NULL };
static const char* cmpstr[] = { "=", "<>", "<", ">", "<=", ">=", NULL };

void apptabis(const char* strs[], char* ts, int l) {
	for (int i = 0; strs[i]; i++) apptabi(strs[i], ts, l);
}

void make_tabbuf(char* ts) {
	//pr("xtabstr:%s error:%s:%d", ts, errorstr, errn);
	str_free(&tabbuf);
	int l = strlen(ts);
	if (errn >= ERR_CMDE && errn <= ERR_CMD) {
		//pr("errnum %d:%d:", ERR_CMDU, errn);
		if (tabinexpr) {
			apptabis(inopstr, ts, l);
		}
		else {
			if (errn == ERR_CMDU) apptab("until", ts, l);
			if (errn <= ERR_CMDEL) apptab("end", ts, l);
			if (errn == ERR_CMDEL) {
				apptab("else", ts, l);
				apptab("elif", ts, l);
			}
			atab_names(ts, l, -1, 1);
			byte tok2 = t_gcurve;
			if (errn >= ERR_CMD0) tok2 = t_global;
			for (byte t = t_if; t <= tok2; t++) {
				if (strncmp(ts, tokstr[t], l) == 0) {
					appt(tokstr[t]);
					if (t == t_func) {
						str_append(&tabbuf, ":");
						str_append(&tabbuf, tokstr[t]);
						str_append(&tabbuf, "$ ");
						str_append(&tabbuf, ":");
						str_append(&tabbuf, tokstr[t]);
						str_append(&tabbuf, "[] ");
					}
				}
			}
			if (errn == ERR_CMD0) apptab("sysconf", ts, l);
		}
	}
	else if (errn == ERR_NUMB) {
		if (tabinexpr) apptabis(inopstr, ts, l);
		atab_names(ts, l, 0, 1);
		atab_numfuncs(ts, l);
		if (!ts[0]) str_append(&tabbuf, ":1:2:3:4:5:6:7:8:9:0");
	}
	else if (errn == ERR_NUMSTR) {
		atab_names(ts, l, 0, 1);
		atab_names(ts, l, 1, 1);
		atab_numfuncs(ts, l);
		atab_strfuncs(ts, l);
	}
	else if (errn == ERR_STR) {
		if (!ts[0]) str_append(&tabbuf, ":\"");
		atab_names(ts, l, 1, 1);
		atab_names(ts, l, 0, 1);
		atab_names(ts, l, 2, 1);
		atab_names(ts, l, 3, 1);
		atab_names(ts, l, 4, 1);
		atab_names(ts, l, 5, 1);
		atab_strfuncs(ts, l);
		atab_numfuncs(ts, l);
		atab_strarrfuncs(ts, l);
		if (!ts[0]) str_append(&tabbuf, ":\"\"");
	}
	else if (errn == ERR_ARR) {
		atab_names(ts, l, 2, 1);
		atab_names(ts, l, 4, 0);
		atab_arrfuncs(ts, l);
	}
	else if (errn == ERR_STRARR) {
		atab_names(ts, l, 3, 1);
		atab_names(ts, l, 5, 1);
		atab_strarrfuncs(ts, l);
	}
	else if (errn == ERR_ARRARR) {
		atab_names(ts, l, 4, 1);
	}
	else if (errn == ERR_STRARRARR) {
		atab_names(ts, l, 5, 1);
	}
	else if (errn == ERR_VARRSTR) {
		// ref arrays or strings
		atab_arrs(ts, l);
		atab_names(ts, l, 1, 0);
	}
	else if (errn == ERR_VARR) {
		// ref arrays (all types)
		atab_arrs(ts, l);
	}
	else if (errn == ERR_EVT) {
		for (byte t = 0; t <= 6; t++ ) {
			apptab(evt_name[t], ts, l);
		}
	}
	else if (errn == ERR_SYSCONF) {
		for (byte t = 0; t <= 3; t++ ) {
			apptab(sysconf_str[t], ts, l);
		}
	}
	else if (errn == ERR_V) {
		atab_names(ts, l, 0, 0);
	}
	else if (errn == t_vstr) {
		atab_names(ts, l, 1, 0);
	}
	else if (errn == t_vnumarr) {
		atab_names(ts, l, 2, 0);
		atab_names(ts, l, 4, 0);
	}
	else if (errn == t_vstrarr) {
		atab_names(ts, l, 3, 0);
		atab_names(ts, l, 5, 0);
	}
	else if (errn == t_vnumarrarr) {
		atab_names(ts, l, 4, 0);
	}
	else if (errn == t_vstrarrarr) {
		atab_names(ts, l, 5, 0);
	}
	else if (errn == ERR_CMP) {
		apptabis(cmpstr, ts, l);
		apptabis(inopstr, ts, l);
	}
	else if (errn == ERR_LOG) {
		apptabis(logopstr, ts, l);
		apptabis(inopstr, ts, l);
	}
	else if (errn == ERR_ARREL) {
		apptab("]", ts, l);
		apptab(",", ts, l);
		if (tabinexpr) apptabis(inopstr, ts, l);
		atab_names(ts, l, 0, 1);
		atab_numfuncs(ts, l);
	}
	else if (errn >= ERR_BR && errn <= ERR_FOR2) {
		char buf[16];
		const char* p = tabstrs[errn];
		while (*p) {
			int i = 0;
			while (1) {
				buf[i] = *p;
				p += 1;
				i += 1;
				if (*p == ':' || *p == 0) break;
			}
			buf[i] = 0;
			if (strncmp(buf + 1, ts, l) == 0) str_append(&tabbuf, buf);
		}
	}
	else { // errn expt(tok)
		apptab(tokstr[errn], ts, l);
		if (tabinexpr) apptabis(inopstr, ts, l);
	}
	str_append(&tabbuf, ":");
	//kc?
	if (fmtline == parseline) str_append(&tabbuf, " ");
	str_append(&tabbuf, ts);
	errorstr = str_ptr(&tabbuf);

	while (codestrln > 0 && codestr[codestrln - 1] == ' ') codestrln--;
	if (codestrln > 0 && codestr[codestrln - 1] == '\n') codestrln--;
	codestr[codestrln] = 0;
}

extern int parse(char* str, int opt, int caret) {

//pr("parse sizeof(ARR) %d", sizeof(ARR));

//extern int parse(const char* str, int opt, int caret) {
	char ts[12];
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

	int slen = strlen(str);
	parse_prepare(str, slen);

	if (is_enter) caret = slen;		// on enter

	is_tab = 0;
	char tabchar = 0;
	if (opt & 1) {
		//pr("slen  %d", slen);
		is_tab = 1;
		int h = slen - 1;
		while (h >= 0 && (isalnum(parse_str[h]) || parse_str[h] == '_')) {
			//pr("  %d", h);
			h -= 1;
		}
		h +=1;
		ts[0] = 0;
		if (caret - h < 11 && h < caret) {
			for (int i = 0; i <= caret - h; i++) {
				ts[i] = parse_str[h + i];
			}
			caret = h;
			tabchar = parse_str[caret];
			parse_str[caret] = 0;
		}
//		cod = 1; //kc?
	}
	nextc();
	nexttok();

	init_klex();

	parse_sysconf();
	if (tok == t_eof && is_enter) errorx(ERR_CMD0);

	ND* sq0 = parse_sequ0();
	proc_p->start = sq0;

	if (tok != t_eof || is_enter) errorx(ERR_CMD1);

	if (wasm) {
		if (errn || fastfunc_errline != -1) {
			free(wasm);
			wasm = NULL;
		}
		else build_fastfuncs();
	}
	if (errn) {
		// always when is_enter or tab
		if (opt & 1) {  // tab
			if  (errtok == t_eof) make_tabbuf(ts);
			else if (tabchar) parse_str[caret] = tabchar;
		}
		else if (errtok == t_eof && errn >= ERR_CMDE && errn <= ERR_CMD) errorstr = "";

		int err_pos = codestrln;

#ifndef __EMSCRIPTEN__
		co(" *** ");
#endif
		while (ind_tok > 0 && parse_str[ind_tok - 1] == ' ') ind_tok--;
		if (ind_tok > 0 && parse_str[ind_tok - 1] == '\n') ind_tok--;
		co(parse_str + ind_tok);

		caret_pos = code_utf8len;

		// active block highlight
		if (nestlevel_err >= 0) {
			ushort npos = nest_block[nestlevel_err];
			codestr[npos + 1] = 'u';
			char ch = codestr[npos + 4];
			if (ch == 'f') codestr[npos + 7] = 'u';	//if
			else if (ch == 'h') codestr[npos + 10] = 'u'; // while
			else if (ch == 'o') codestr[npos + 8] = 'u'; //for
			else if (ch == 'e') codestr[npos + 11] = 'u'; // repeat
			else if (ch == 'n') codestr[npos + 7] = 'u'; // on
			else if (ch == 'a') codestr[npos + 13] = 'u'; // fastproc
			else if (ch == 'u') {
				if (codestr[npos + 7] == '<') codestr[npos + 9] = 'u'; //func
				else if (codestr[npos + 8] == '<') codestr[npos + 10] = 'u'; // func$
				else if (codestr[npos + 9] == '<') codestr[npos + 11] = 'u'; // func[]
				else if (codestr[npos + 10] == '<') codestr[npos + 12] = 'u'; // func$[]
				else codestr[npos + 13] = 'u'; // func[][]
			}
			else {
				codestr[npos + 9] = 'u'; //elif, else, proc, func, subr
			}
		}
		return err_pos;
	}
	// --------------------------------------------------

	if (!cod) return 0;

	if (!input_data) {
		co("\n\n");
	}

	if (opt & 16) {		// strict mode
		struct proc* pr = proc_p;
		while (pr < proc_p + proc_len) {
			struct vname *vn = pr->vname_p;
			if (pr->vname_p) {	// because NULL + 0 is UB
				while (vn < pr->vname_p + pr->vname_len) {
					if (vn->typ <= VAR_NUMARRARR && vn->access != RW) {
						if (vn->access == RD) error_pos("never set", vn->srcpos);
						else error_pos("never used", vn->srcpos);
						return codestrln;
					}
					vn += 1;
				}
			}
			if (pr->start == NULL && pr != proc_p) {
				error_pos("not implemented", pr->varcnt[0]);
				return codestrln;
			}
			pr += 1;
		}
	}

	if (fastfunc_errline != -1) {
		int pos = line2pos_html(fastfunc_errline + 1) - 1;
		if (pos < 0) pos = 0;
		error_pos(" fastfunc error", pos);
		return codestrln;
	}

	caret_pos = caret;
	if (caret_pos >= code_utf8len) caret = code_utf8len;

	int mask = 1;
	if (prog_props & 8) mask |= 2;
	if ((prog_props & 1) || (prog_props & 4)) mask |= 4;

	if (seq.mouse_down || seq.mouse_up ||
			seq.mouse_move || seq.key_down || seq.key_up ||
			seq.animate || seq.timer) {
		mask |= 8;
	}
	return -mask;
}

extern const char* format(void) {
	if (codestr) codestr[codestrln] = 0;
	return codestr;
}

extern int caret(void) {
	return caret_pos;
}

extern void k_free(void) {
	free_rt();
}

static const char* progname = "";

extern int exec(int opt, const char* args) {

//	pr("exec %lu", sizeof(struct str));

#ifndef __EMSCRIPTEN__
	srand((int)(long long)(sys_time() * 1000));
#endif
	freecodestr();
	rt.args = args;
	init_rt();
	gr_init(progname, onstats | (prog_props << 7));
	rt.slow = 0;

	int dbg = opt >> 1;
	if (dbg) {
		rt.slow = 1 << (dbg - 1);
		exec_sequ_slow(proc_p->start);
		gr_debline(0, 0);
	}
	else {
		exec_sequ(proc_p->start);
// show debug out on run in IDE
		if (opt & 1) dbg_outvars();
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
//	pr("sizeof(struct node): %d", sizeof(struct node));
	EM_ASM( postMessage(['started']));
	return 0;
}

#elif defined(__RUN__)

//test
char* code =
	"#\n"
;
char* code4 =
	"#\n"
	"while b + 1 < 100000000 / 2"
	"  b = b + 1 "
	"  s = s + b "
	". "
	"print s "
;

int main(void) {

	fprintf(stderr, "main\n");
	if (parse(code4, 0, 0) < 0) {
		exec(0, "");
//		printf("%s", format());
	}

	return 0;
}

#else

static void err_exit(void) {
	fprintf(stderr, "run [-f] [filename]\n");
	exit(1);
}

int main(int argc, const char* argv[]) {

	int form = 0;

	int i = 1;
	//int opt = 0;
	int opt = 16;	// strict
	if (argc > 1 && strcmp(argv[i], "-f") == 0) {
		form = 1;
		i++;
	}
	FILE* f = stdin;
	if (argc > i) {
		if (strcmp(argv[i], "-") != 0) {
			if (argv[i][0] == '-') err_exit();
			progname = argv[i];
			f = fopen(argv[i], "rb");
			if (!f) {
				fprintf(stderr, "Could not open %s\n", argv[i]);
				exit(1);
			}
		}
		i += 1;
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

