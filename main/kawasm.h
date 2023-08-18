/*	kawasm.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns 
    "christof.kaser@gmail.com".
*/

// EXPERIMENTING

byte wasm[1000] = {
  0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x01, 0x60,
  0x03, 0x7c, 0x7c, 0x7c, 0x01, 0x7c, 0x03, 0x02, 0x01, 0x00, 0x07, 0x08, 
  0x01, 0x04, 0x66, 0x61, 0x73, 0x74, 0x00, 0x00, 0x0a, 0x5d, 0x01, 0x5b
};

static ushort wi;
static void wemit(byte b) {
	if (wi >= 1000) {
		error("fastproc too big");
		return;
	}
	wasm[wi++] = b;
}
static void wemitf(double d) {
	if (wi >= 1000 - 7) {
		error("fastproc too big");
		return;
	}
	*(double*)(wasm + wi) = d;
	wi += 8;
}
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
		wemit(0x20);
		wemit(nd->v1);
	}
	else if (p == op_const_fl) {
		wemit(0x44);
		wemitf(nd->cfl);
	}
	else {
		printf("fastproc error - expr\n");
		fastproc_addr = 0;
		error("fastproc error");
	}
}

static int mf_iscmp(void* p) {
	if (p == op_eqf || p == op_neqf || p == op_lef || p == op_ltf || p == op_gef ||  p == op_gtf) return 1;
	return 0; 
}

static void mf_and(ND* nd) {
	void* p = nd->intf;
	if (mf_iscmp(p)) {
		mf_expr(nd->le);
		mf_expr(nd->ri);
		if (p == op_eqf) wemit(0x61);
		else if (p == op_neqf) wemit(0x62);
		else if (p == op_ltf) wemit(0x63);
		else if (p == op_gtf) wemit(0x64);
		else if (p == op_lef) wemit(0x65);
		else if (p == op_gef) wemit(0x66);
		wemit(0x0d); //br_if
		wemit(1);
	}
	else {
		printf("fastproc error - and\n");
		fastproc_addr = 0;
		error("fastproc error");
	}
}

static void mf_or(ND* nd) {
	while (nd->intf == op_or) {
		mf_and(nd->le);
		nd = nd->ri;
	}
	mf_and(nd);
}

static void mf_sequ(ND* nd) {
	while (nd) {
		void* p = nd->vf;

		if (0) {
		}
		else if (p == op_repeat) {			

			ND* ndx = nd + 1;

			wemit(0x02);
			wemit(0x40);
			wemit(0x03);
			wemit(0x40);
			mf_sequ(nd->ri);
			//

			mf_or(nd->le);
			
			mf_sequ(ndx->ex);

			wemit(0x0c);
			wemit(0);
			wemit(0x0b);
			wemit(0x0b);

		}
		else if (p == op_flassp) {
			mf_expr(nd->ri);
			wemit(0x20);
			wemit(nd->v1);
			wemit(0xa0);
			// local.set 
			wemit(0x21);
			wemit(nd->v1);
		}
		else if (p == op_flass) {
			mf_expr(nd->ri);
			// local.set 
			wemit(0x21);
			wemit(nd->v1);
		}
		else {
			printf("fastproc error - sequence\n");
			fastproc_addr = 0;
			error("fastproc error");
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
	wi = 36;
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

	ushort h = wi - 36;
	wasm[0x23] = h;
	wasm[0x21] = h + 2;

	printf("fastproc %s - size %d\n", proc->name, wi);

#ifdef __EMSCRIPTEN__
	if (fastproc_addr) {
		EM_ASM(
			fastarr = Array();
		);
		for (int i = 0; i < wi; i++) {
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
}

