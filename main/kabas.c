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

#define S static

struct arr {
	union {
		void* p;
		double* pnum;
		STR* pstr;
		struct arr* parr;
	};
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
			union {
				struct {
					union {
						struct node* le;
						short v1;
					};
					union {
						struct node* ri;
						short v2;
						float cfl32;
					};
				};
				double cfl;
				uint str;
			};
			struct node* next;
		};

// for extendend op
		struct {
			union {
				struct {
					union {
						struct node* ex;
						short vx;
					};
					union {
						struct node* ex2;
						short vx2;
					};
					struct node* ex3;
				};
				struct {
					byte bx0;
					byte bx1;
					byte bx2;
					byte bx3;
					byte bx[8];
					struct node* bxnd;
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

#include "kalex.h"
#include "kafunc.h"
//#include "kawasm.h"
#include "kaparse.h"

//--------------------------------------------------------------------------------------

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
	proc_p->start = parse_sequ();
	if (tok != t_eof) {
		cs_nl();
		error("<cmd>");
	}

	if (err) { 
		// always when is_enter
		int err_pos = codestrln;

#if !defined(__EMSCRIPTEN__)
		co(" *** ");
#endif
		while (ind_tok > 0 && parse_str[ind_tok - 1] == ' ') ind_tok--;
		if (ind_tok > 0 && parse_str[ind_tok - 1] == '\n') ind_tok--;

		co(parse_str + ind_tok);
 
		caret_pos = code_utf8len;
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
			else {
				codestr[npos + 9] = 'u'; //elif, else, proc, func, subr
			}
		}
		return err_pos;
	}

	co("\n");
	if (!cod) return 0;

	proc = proc_p;
	while (proc < proc_p + proc_len) {
		struct vname *p = proc->vname_p;
		if (proc->vname_p) {	// because NULL + 0 is UB
			while (p < proc->vname_p + proc->vname_len) {
				if (p->typ <= VAR_NUMARRARR && p->access != RW) {
					if (p->access == RD) error_pos("never set", p->srcpos);
					else error_pos("never used", p->srcpos);
					caret_pos = code_utf8len;
					return codestrln;
				}
				p += 1;
			}
		}
		proc += 1;
	}
	caret_pos = pos;
	if (caret_pos >= code_utf8len) pos = code_utf8len;

	int mask = 1;
	if (prog_props & 8) mask |= 2;
	if ((prog_props & 1) || (prog_props & 4)) mask |= 4;

	if (seq.mouse_down || seq.mouse_up || 
			seq.mouse_move || seq.key_down ||
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

	//printf("exec %lu\n", sizeof(struct str));
#ifndef __EMSCRIPTEN__	
	srand((int)(long long)(sys_time() * 1000));
#endif
	freecodestr();
	rt.args = args;
	init_rt();
	gr_init(progname, onstats | (prog_props << 6));
	rt.slow = 0;

	int dbg = opt >> 1; 
	if (dbg) {
		rt.slow = 1 << (dbg - 1);
		exec_sequ_slow(proc_p->start);
		gr_debline(0);
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
	EM_ASM( postMessage(['started']));
	return 0;
}

#elif defined(__RUN__)

//test
//char* code = "fastproc mul a b . r . i = 1 while i <= 5 i += 1 . r = a * b r += 2 . call mul 2 3 r print r";
char* code1 = "fastproc mul a b . r . r = a * b . call mul 2 3 r print r";
char* code2 = "proc f .. print 4 . call f";

char* codefr = "proc iter cx cy . iter . "
   "iter = 1 "
   "repeat "
      "y = (x + x) * y + cy "
      "x = xx - yy + cx "
      "xx = x * x "
      "yy = y * y "
      "until xx + yy > 4 or iter = 128 "
      "iter += 1 "
   ". "
". "
"call iter 0.6 0.5 iter "
"pr iter";

char* code4 = 
	"while b + 1 < 1000000000 / 2"
	"  b = b + 1 "
	"  s = s + b "
	". "
	"print s "
;
char* code = 
	"a[]=[7 8] proc f a .. if a = 1 pr a[a] . . call f 1 a -= 2 pr a  "
;

int main(void) {

	fprintf(stderr, "main\n");
	if (parse(code, 0, 0) < 0) {
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
