/*	kawasm.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns 
    "christof.kaser@gmail.com".
*/

// fastproc - creates wasm code 
// currently works only partially - experimenting

byte wasm0[] = {
  0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x01, 0x60,
  0x03, 0x7c, 0x7c, 0x7c, 0x01, 0x7c, 0x03, 0x02, 0x01, 0x00, 0x07, 0x08, 
  0x01, 0x04, 0x66, 0x61, 0x73, 0x74, 0x00, 0x00, 0x0a, 0x5d, 0x01, 0x5b
};

byte* wasm = NULL;
ushort wasm_len = 0;

static ushort wasmi;
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
	printf("fastproc error - ");
	printf("%s\n", s);
	fastproc_addr = 0;
	error("fastproc error");
}

#define W_BLOCK 0x02
#define W_LOOP 0x03
#define W_VOID 0x40
#define W_END 0x0b
#define W_BRIF 0x0d
#define W_BR 0x0c
#define W_SET 0x21
#define W_GET 0x20

static void mf_sequ(ND* nd);

static void mf_expr(ND* nd) {

	void* p = nd->vf;
	if (p == op_add || p == op_mult || p == op_div || p == op_sub) {
		mf_expr(nd->le);
		mf_expr(nd->ri);
		
		if (p == op_add) {
			wemit(0xa0);
		}
		else if (p == op_sub) {
			wemit(0xa1);
		}
		else if (p == op_mult) {
			wemit(0xa2);
		}
		else if (p == op_div) {
			wemit(0xa3);
		}
	}
	else if (p == op_lvnum) {
//		printf("get %d\n", nd->v1);
		wemit(W_GET);
		wemit(nd->v1);
	}
	else if (p == op_const_fl) {
		wemit(0x44);
		wemitf(nd->cfl);
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
	if (p == op_eqf) wemit(0x62);
	else if (p == op_neqf) wemit(0x61);
	else if (p == op_ltf) wemit(0x66);
	else if (p == op_gtf) wemit(0x65);
	else if (p == op_lef) wemit(0x64);
	else if (p == op_gef) wemit(0x63);
	else mf_err("cmpneg");
	wemit(W_BRIF);
	wemit(lev);
}
static void mf_cmp(ND* nd, byte lev) {
	void* p = nd->intf;
	mf_expr(nd->le);
	mf_expr(nd->ri);
	if (p == op_eqf) wemit(0x61);
	else if (p == op_neqf) wemit(0x62);
	else if (p == op_ltf) wemit(0x63);
	else if (p == op_gtf) wemit(0x64);
	else if (p == op_lef) wemit(0x65);
	else if (p == op_gef) wemit(0x66);
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
		else {
			mf_err("sequence");
		}
		nd = nd->next;
	}
}

static void parse_fastproc(void) {

//	printf("%d %d %d\n", proc->varcnt[0], proc->varcnt[1], proc->varcnt[2]);
	if (proc->varcnt[1] + proc->varcnt[2] > 0) {
		error("in fastproc only mumbers are allowed");
	}
	fastproc_addr = proc - proc_p;

//kc ---------- compile fast

//	printf("%s\n", proc->parms);

	if (memcmp(proc->parms, "ffF", 4) != 0) {
		error("a fastproc have 2 in- and 1 inout-parameter");
	}
	byte b = proc->varcnt[0] - 3;		// 2 in parm, 1 inout

	free(wasm);
	wasm = malloc(1000);
	wasm_len = 1000;
	memcpy(wasm, wasm0, sizeof(wasm0));	

	wasmi = 36;
	if (b == 0) wemit(0);
	else {
		wemit(1);
		wemit(b);
		wemit(0x7c);
	}
	mf_sequ(proc->start->bxnd);

	wemit(0x20);
	wemit(2);
	wemit(0x0b);

	ushort h = wasmi - 36;
	wasm[0x23] = h;
	wasm[0x21] = h + 2;

	printf("fastproc %s - size %d\n", proc->name, wasmi);

#ifdef __EMSCRIPTEN__
	if (fastproc_addr) {
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
	}
#endif
	free(wasm);
	wasm = 0;
}

