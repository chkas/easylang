/*	kawasm.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns 
    "christof.kaser@gmail.com".
*/

// DOESN'T WORK - EXPERIMENTING

#if 1
//#ifdef __EMSCRIPTEN__

//test
/*
unsigned char wasm[] = {
  0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x01, 0x07, 0x01, 0x60,
  0x02, 0x7c, 0x7c, 0x01, 0x7c, 0x03, 0x02, 0x01, 0x00, 0x07, 0x08, 0x01,
  0x04, 0x66, 0x61, 0x73, 0x74, 0x00, 0x00, 0x0a, 0x09, 0x01, 0x07, 0x00,
  0x20, 0x00, 0x20, 0x01, 0xa2, 0x0b
};
unsigned int wasm_len = 42;


unsigned char wasm[] = {
  0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x01, 0x07, 0x01, 0x60,
  0x02, 0x7c, 0x7c, 0x01, 0x7c, 0x03, 0x02, 0x01, 0x00, 0x07, 0x08, 0x01,
  0x04, 0x66, 0x61, 0x73, 0x74, 0x00, 0x00, 0x0a, 0x5d, 0x01, 0x5b, 0x01,
  0x06, 0x7c, 0x02, 0x40, 0x03, 0x40, 0x20, 0x06, 0x44, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0xf0, 0x3f, 0xa0, 0x21, 0x06, 0x20, 0x03, 0x20, 0x02,
  0xa1, 0x20, 0x00, 0xa0, 0x22, 0x07, 0x20, 0x07, 0xa2, 0x22, 0x03, 0x20,
  0x05, 0x20, 0x05, 0xa0, 0x20, 0x04, 0xa2, 0x20, 0x01, 0xa0, 0x22, 0x04,
  0x20, 0x04, 0xa2, 0x22, 0x02, 0xa0, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x10, 0x40, 0x63, 0x45, 0x0d, 0x01, 0x20, 0x07, 0x21, 0x05, 0x20,
  0x06, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x60, 0x40, 0x63, 0x0d,
  0x00, 0x0b, 0x0b, 0x20, 0x06, 0x0b
};
unsigned int wasm_len = 126;

*/

byte wasm[1000] = {
  0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x01, 0x60,
  0x03, 0x7c, 0x7c, 0x7c, 0x01, 0x7c, 0x03, 0x02, 0x01, 0x00, 0x07, 0x08, 
  0x01, 0x04, 0x66, 0x61, 0x73, 0x74, 0x00, 0x00, 0x0a, 0x5d, 0x01, 0x5b
};

#endif

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
static void mf_expr(ushort o) {

	void* p = codp[o].vf;
	if (p == op_add || p == op_mult) {
		mf_expr(codp[o].o1);
		mf_expr(codp[o].o2);
		
		if (p == op_add) {
			printf("add\n");
			wemit(0xa0);
		}
		else if (p == op_mult) {
			printf("mult\n");
			wemit(0xa2);
		}
	}
	else if (p == op_lvnum) {
		printf("get %d\n", codp[o].o1);
		wemit(0x20);
		wemit(codp[o].o1);
	}
	else if (p == op_const_fl) {
		printf("const\n");
		wemit(0x44);
		*(double*)(wasm + wi) = (double)codp[o].cfl;
		wi += 8;
	}
	else if (p == op_const_flx) {
		printf("const\n");
		wemit(0x44);
		wemitf(codp[o + 1].cdbl);
	}
	else {
		printf("expr_xx\n");
	}
}

static int mf_iscmp(void* p) {
	if (p == op_eqf || p == op_neqf || p == op_lef || p == op_ltf || p == op_gef ||  p == op_gtf) return 1;
	return 0; 
}

static void mf_and(ushort o) {
	void* p = codp[o].intf;
	if (mf_iscmp(p)) {
		printf("op_cmpf\n");
		mf_expr(codp[o].o1);
		mf_expr(codp[o].o2);
		if (p == op_eqf) wemit(0x61);
		else if (p == op_neqf) wemit(0x62);
		else if (p == op_ltf) wemit(0x63);
		else if (p == op_gtf) wemit(0x64);
		else if (p == op_lef) wemit(0x65);
		else if (p == op_gef) wemit(0x66);
		wemit(0x0d); //br_if
	}
	else {
		printf("op_andxx\n");
	}
}

static void mf_or(ushort o) {
	while (codp[o].intf == op_or) {
		mf_and(codp[o].o1);
		o = codp[o].o2;
	}
	mf_and(o);
}

static void mf_sequ(ushort o) {	while (1) {
		void* p = codp[o].vf;
		if (p == op_while) {			
			printf("op_while\n");
			mf_sequ(codp[o].o2);
		}
		else if (p == op_repeat) {			
			printf("op_repeat\n");
			wemit(0x02);
			wemit(0x40);
			wemit(0x03);
			wemit(0x40);
			mf_sequ(codp[o].o2);
			//

			mf_or(codp[o].o1);
			

			mf_sequ(codp[o].o3);

			wemit(0x0c);
			wemit(0);
			wemit(0x0b);
			wemit(0x0b);

		}
		else if (p == op_flass) {
			mf_expr(codp[o].o2);
			// local.set 
			wemit(0x21);
			wemit(codp[o].o1);
			printf("op_flass %d\n", codp[o].o1);
		}
		else if (p == op_intass16) {
			printf("op_intass\n");
		}
		else if (p == op_intassp16) {
			printf("op_intassp\n");
		}
		else {
			printf("op_xx\n");
		}
		o = codp[o].next;
		if (o == UMO) break;
//		break;
	}
	printf("\n");
}


static void parse_fastproc(void) {

	printf("%d %d %d\n", proc->varcnt[0], proc->varcnt[1], proc->varcnt[2]);
	if (proc->varcnt[1] + proc->varcnt[2] > 0) {
		error("in fastproc only mumbers are allowed");
	}
	fastproc_addr = proc;

//kc ---------- compile fast

	printf("%s\n", proc->name);
//	ushort ox = proc->start - 1;
	printf("%d %d %d\n", proc->varcnt[0], proc->varcnt[1], proc->varcnt[2]);

	printf("%s\n", proc->parms);
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

//	printf("%d %d %d\n", codp[ox].bx0, codp[ox].bx1, codp[ox].bx2);

	mf_sequ(proc->start);

	wemit(0x20);
	wemit(2);
	wemit(0x0b);

	printf("size %d\n", wi);
	ushort h = wi - 36;
	wasm[0x23] = h;
	wasm[0x21] = h + 2;

#ifdef __EMSCRIPTEN__

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
#endif
}

