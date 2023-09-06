/*	kawasm.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns 
    "christof.kaser@gmail.com".
*/

// fastfunc - creates wasm code 
// currently works only partially - experimenting

byte* wasm = NULL;
ushort wasm_len = 0;

static ushort wasmi;
static ushort wavar;

static void wemit(byte b) {
	if (wasmi >= wasm_len) {
		wasm_len += 256;
		wasm = realloc(wasm, wasm_len);
	}
	wasm[wasmi++] = b;
}
static void wemitf(double d) {
	if (wasmi >= wasm_len - 7) {
		wasm_len += 256;
		wasm = realloc(wasm, wasm_len);
	}
	*(double*)(wasm + wasmi) = d;
	wasmi += 8;
}
static void mf_err(const char* s) {
	printf("fastfunc error - ");
	printf("%s\n", s);
	fastfunc_addr = 0;
	error("fastfunc error");
}

#define W_BLOCK 0x02
#define W_LOOP 0x03
#define W_VOID 0x40
#define W_END 0x0b
#define W_BRIF 0x0d
#define W_BR 0x0c
#define W_GET 0x20
#define W_SET 0x21
#define W_TEE 0x22

#define W_ADD 0xa0
#define W_SUB 0xa1
#define W_MULT 0xa2
#define W_DIV 0xa3
#define W_FLOOR 0x9c

#define W_EQ 0x61
#define W_NE 0x62
#define W_LT 0x63
#define W_GT 0x64
#define W_LE 0x65
#define W_GE 0x66

static void mf_sequ(ND* nd);

static void mf_expr(ND* nd) {

	void* p = nd->vf;
	if (p == op_add || p == op_mult || p == op_div || p == op_sub 
		 || p == op_lower || p == op_higher || p == op_divi) {

		mf_expr(nd->le);
		mf_expr(nd->ri);
		
		if (p == op_add) wemit(W_ADD);
		else if (p == op_sub) wemit(W_SUB);
		else if (p == op_mult) wemit(W_MULT);
		else if (p == op_div) wemit(W_DIV);
		else if (p == op_lower) wemit(0xa4);
		else if (p == op_higher) wemit(0xa5);
		else if (p == op_divi) {
			wemit(W_DIV);
			wemit(W_FLOOR);
		}
	}
	else if (p == op_mod) {
		mf_expr(nd->le);
		wemit(W_TEE);
		wemit(wavar);
		wemit(W_GET);
		wemit(wavar);

		mf_expr(nd->ri);
		wemit(W_TEE);
		wemit(wavar + 1);
		wemit(W_DIV);
		wemit(W_FLOOR);
		wemit(W_GET);
		wemit(wavar + 1);
		wemit(W_MULT);
		wemit(W_SUB);
	}
	else if (p == op_floor || p == op_abs || p == op_negf || p == op_sqrt) {
		mf_expr(nd->le);

		if (p == op_floor) wemit(W_FLOOR);
		else if (p == op_abs) wemit(0x99);
		else if (p == op_negf) wemit(0x9a);
		else if (p == op_sqrt) wemit(0x9f);
	}
	else if (p == op_lvnum) {
		wemit(W_GET);
		wemit(nd->v1);
	}
	else if (p == op_const_fl) {
		wemit(0x44);
		wemitf(nd->cfl);
	}
	else if (p == op_callfunc && proc->start->bxnd == nd->le->bxnd) {
		ND* ndh = nd->ri;
		while (ndh) {
			mf_expr(ndh);
			ndh = ndh->next;
		}
		wemit(0x10);
		wemit(0);
	}
	else {
		mf_err("expr");
	}
}

static int mf_iscmp(void* p) {
	if (p == op_eqf || p == op_neqf || p == op_lef || p == op_ltf || p == op_gef ||  p == op_gtf) return 1;
	return 0; 
}

static void mf_cmpneg(ND* nd, byte lev) {
	void* p = nd->intf;
	mf_expr(nd->le);
	mf_expr(nd->ri);
	//reverse
	if (p == op_eqf) wemit(W_NE);
	else if (p == op_neqf) wemit(W_EQ);
	else if (p == op_ltf) wemit(W_GE);
	else if (p == op_gtf) wemit(W_LE);
	else if (p == op_lef) wemit(W_GT);
	else if (p == op_gef) wemit(W_LT);
	else mf_err("cmpneg");
	wemit(W_BRIF);
	wemit(lev);
}
static void mf_cmp(ND* nd, byte lev) {
	void* p = nd->intf;
	mf_expr(nd->le);
	mf_expr(nd->ri);
	if (p == op_eqf) wemit(W_EQ);
	else if (p == op_neqf) wemit(W_NE);
	else if (p == op_ltf) wemit(W_LT);
	else if (p == op_gtf) wemit(W_GT);
	else if (p == op_lef) wemit(W_LE);
	else if (p == op_gef) wemit(W_GE);
	else mf_err("cmp");
	wemit(W_BRIF);
	wemit(lev);
}

static void mf_andneg(ND* nd, byte lev) {
	while (nd->intf == op_and) {
		mf_cmpneg(nd->le, lev);
		nd = nd->ri;
	}
	mf_cmpneg(nd, lev);
}
static void mf_and(ND* nd, byte lev) {
	while (nd->intf == op_and) {
		mf_cmp(nd->le, lev);
		nd = nd->ri;
	}
	mf_cmp(nd, lev);
}


static void mf_repand(ND* nd) {
	void* p = nd->intf;

	if (mf_iscmp(p)) {
		mf_cmp(nd, 1);
	}
	else if (nd->intf == op_and) {

		wemit(W_BLOCK);
		wemit(W_VOID);

		mf_andneg(nd, 0);

		wemit(W_BR);
		wemit(2);
		wemit(W_END);
	}

	else {
		mf_err("repand");
	}
}
static void mf_condrep(ND* nd) {
	while (nd->intf == op_or) {
		mf_repand(nd->le);
		nd = nd->ri;
	}
	mf_repand(nd);
}

static void mf_cond(ND* nd, byte lev) {

	if (nd->intf == op_or) {
		wemit(W_BLOCK);
		wemit(W_VOID);
		while (nd->intf == op_or) {
			mf_and(nd->le, lev);
			nd = nd->ri;
		}
		mf_and(nd, lev);

		wemit(W_BR);
		wemit(lev + 1);
		wemit(W_END);
	}
	else {
		mf_andneg(nd, lev);
	}
}

static void mf_sequ(ND* nd) {
	while (nd) {
		void* p = nd->vf;

		if (0) {
		}
		else if (p == op_while) {			

			wemit(W_BLOCK);
			wemit(W_VOID);
			wemit(W_LOOP);
			wemit(W_VOID);

			mf_cond(nd->le, 1);
			mf_sequ(nd->ri);

			wemit(W_BR);
			wemit(0);
			wemit(W_END);
			wemit(W_END);

		}
		else if (p == op_if) {			

			wemit(W_BLOCK);
			wemit(W_VOID);

			mf_cond(nd->le, 0);
			mf_sequ(nd->ri);

			wemit(W_END);

		}
		else if (p == op_if_else) {			
			ND* ndx = nd->ri;

			wemit(W_BLOCK);
			wemit(W_VOID);
			wemit(W_BLOCK);
			wemit(W_VOID);

			mf_cond(nd->le, 0);

			mf_sequ(ndx->ex);

			wemit(W_BR);
			wemit(1);
			wemit(W_END);

			mf_sequ(ndx->ex2);

			wemit(W_END);

		}
		else if (p == op_repeat) {			

			ND* ndx = nd + 1;

			wemit(W_BLOCK);
			wemit(W_VOID);
			wemit(W_LOOP);
			wemit(W_VOID);

			mf_sequ(nd->ri);
			//

			mf_condrep(nd->le);
			
			mf_sequ(ndx->ex);

			wemit(W_BR);
			wemit(0);

			wemit(W_END);
			wemit(W_END);

		}
		else if (p == op_flassp || p == op_flassm) {
			wemit(W_GET);
			wemit(nd->v1);
			if (nd->v1 < 0) {
				mf_err("flass global");
			}
			mf_expr(nd->ri);
			if (p == op_flassp) wemit(0xa0);
			else wemit(0xa1);

			wemit(W_SET);
			wemit(nd->v1);
		}
		else if (p == op_flass) {
			mf_expr(nd->ri);
			wemit(W_SET);
			wemit(nd->v1);
		}
		else if (p == op_return) {
			mf_expr(nd->le);
			wemit(0x0f);
		}
		else {
			mf_err("sequence");
		}
		nd = nd->next;
	}
}

byte wasm0[] = {
  0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x01, 0xff, 0x01, 0x60
};
byte wasm1[] = {
  0x01, 0x7c, 0x03, 0x02, 0x01, 0x00, 0x07, 0x08, 0x01, 0x04, 0x66, 0x61, 
  0x73, 0x74, 0x00, 0x00, 0x0a
};

static void parse_fastfunc(void) {

//	printf("%d %d %d\n", proc->varcnt[0], proc->varcnt[1], proc->varcnt[2]);
	if (proc->varcnt[1] + proc->varcnt[2] > 0) {
		error("in fastfunc only mumbers are allowed");
		return;
	}
	fastfunc_addr = proc - proc_p;

	free(wasm);
	wasm = malloc(1000);
	wasm_len = 1000;
	wasmi = sizeof(wasm0);
	memcpy(wasm, wasm0, wasmi);	

	// parameter
	byte nparm;

	if (strcmp(proc->parms, "") == 0) nparm = 0;
	else if (strcmp(proc->parms, "f") == 0) nparm = 1;
	else if (strcmp(proc->parms, "ff") == 0) nparm = 2;
	else if (strcmp(proc->parms, "fff") == 0) nparm = 3;
	else {
		error("a fastfunc have only in parameter");
		return;
	}
	wasm[9] = 5 + nparm;

	wemit(nparm);
	for (byte i = 0; i < nparm; i++) wemit(0x7c);

	memcpy(wasm + wasmi, wasm1, sizeof(wasm1));	
	wasmi += sizeof(wasm1);

	// code size
	wasmi += 2;
	wemit(0x1);
	// func size
	wasmi += 2;

	ushort fstart = wasmi;

	byte b = proc->varcnt[0] - nparm;
	wavar = b + nparm;
	b += 2;
	wemit(1);
	wemit(b);
	wemit(0x7c);

	mf_sequ(proc->start->bxnd);

//	wemit(W_GET);
//	wemit(nparm - 1);
	wemit(W_END);

	ushort h = wasmi - fstart;

	if (h >= 16384 - 3) {
		error("fastfunc too big");
		return;
	}
	wasm[fstart - 2] = (h & 127) | 128;
	wasm[fstart - 1] = h >> 7;
	h += 3;
	wasm[fstart - 5] = (h & 127) | 128;
	wasm[fstart - 4] = h >> 7;

	printf("fastfunc %s - size %d\n", proc->name, wasmi);

#ifdef __EMSCRIPTEN__

	EM_ASM(
		fastarr = Array();
	);
	for (int i = 0; i < wasmi; i++) {
	    EM_ASM_({
			fastarr.push(getValue($0));
		}, wasm + i);
	}
    EM_ASM(
        var mod = new WebAssembly.Module(Uint8Array.from(fastarr));
        fastinst = new WebAssembly.Instance(mod);
    );

#endif
	free(wasm);
	wasm = 0;
}

