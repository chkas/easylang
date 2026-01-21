/*	kwasm.h

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

	A derivative of this software must contain the built-in function
	sysfunc "creator" or an equivalent function that returns
	"christof.kaser@gmail.com".
*/

// fastfunc - creates wasm code
// currently works only partially - experimenting

static byte* wasm = NULL;
static ushort wasm_len = 0;

static ushort wasmi;
static ushort wvar;
static byte fastfuncn;

static void we(byte b) {
	if (wasmi >= wasm_len) {
		wasm_len += 256;
		wasm = _realloc(wasm, wasm_len);
	}
	wasm[wasmi++] = b;
}
static void wef(double d) {
	if (wasmi >= wasm_len - 7) {
		wasm_len += 256;
		wasm = _realloc(wasm, wasm_len);
	}
	memcpy(wasm + wasmi, &d, 8);
	wasmi += 8;
}

static ND* nd_stat;

int fastfunc_errline;

static void mf_err(const char* s) {
	fastfuncn = 0;
	if (fastfunc_errline == 0) fastfunc_errline = getline_nd(nd_stat);
	pr("fastfunc error:%s line:%d", s, fastfunc_errline);
}

#define W_BLOCK 0x02
#define W_LOOP 0x03
#define W_CALL 0x10
#define W_VOID 0x40
#define W_END 0x0b
#define W_BRIF 0x0d
#define W_BR 0x0c
#define W_GET 0x20
#define W_SET 0x21
#define W_TEE 0x22

#define W_ADD 0xa0
#define W_SUB 0xa1
#define W_MUL 0xa2
#define W_DIV 0xa3
#define W_FLOOR 0x9c
#define W_ABS 0x99
#define W_NEG 0x9a
#define W_SQRT 0x9f
#define W_MIN 0xa4
#define W_MAX 0xa5
#define W_CONST 0x44

#define W_EQ 0x61
#define W_NE 0x62
#define W_LT 0x63
#define W_GT 0x64
#define W_LE 0x65
#define W_GE 0x66


#define W_ADDI 0x6a
#define W_SUBI 0x6b
#define W_CONSTI 0x41
#define W_SHL 0x74

#define W_F2I 0xAB // i32.trunc_f64_u
#define W_I2F 0xB8 // f64.convert_i32_u
#define W_DROP 0x1a
/*
#define
*/

static void mf_sequ(ND* nd);
static void mf_expr(ND* nd);

static void mf_arrpos(short id, ND* ex) {
	we(0x23);	// get global 1 (arrays)
	we(0x01);
	we(0x41);
	int h = (id + 1) * -12;
	if (h < 0) mf_err("expr");
	we(h);
	we(W_ADDI);

	we(0x28);
	we(0x00);
	we(0x00);

	mf_expr(ex);
	we(W_F2I);

#if 0
	we(W_CONSTI);
	we(1);
#else
	// arrbase
	we(0x23);
	we(0x01);
	we(0x41);
	we((id + 1) * -12 + 8);
	we(W_ADDI);
	we(0x2C);	// read char
	we(0x00);
	we(0x00);
#endif
	we(W_SUBI);

	we(W_CONSTI);
	we(3);
	we(W_SHL);
	we(W_ADDI);
}

static void mf_expr(ND* nd) {

	void* p = nd->vf;
	if (p == op_add || p == op_mult || p == op_div || p == op_sub
		 || p == op_lower || p == op_higher || p == op_divi) {

		mf_expr(nd->le);
		mf_expr(nd->ri);
		
		if (p == op_add) we(W_ADD);
		else if (p == op_sub) we(W_SUB);
		else if (p == op_mult) we(W_MUL);
		else if (p == op_div) we(W_DIV);
		else if (p == op_lower) we(W_MIN);
		else if (p == op_higher) we(W_MAX);
		else if (p == op_divi) {
			we(W_DIV);
			we(W_FLOOR);
		}
	}
	else if (p == op_mod) {
		mf_expr(nd->le);
		we(W_TEE);
		we(wvar);
		we(W_GET);
		we(wvar);

		mf_expr(nd->ri);
		we(W_TEE);
		we(wvar + 1);
		we(W_DIV);
		we(W_FLOOR);
		we(W_GET);
		we(wvar + 1);
		we(W_MUL);
		we(W_SUB);
	}
	else if (p == op_floor || p == op_abs || p == op_negf || p == op_sqrt) {
		mf_expr(nd->le);

		if (p == op_floor) we(W_FLOOR);
		else if (p == op_abs) we(W_ABS);
		else if (p == op_negf) we(W_NEG);
		else if (p == op_sqrt) we(W_SQRT);
	}
	else if (p == op_lvnum) {
		we(W_GET);
		we(nd->v1);
	}
	else if (p == op_const_fl) {
		we(0x44);
		wef(nd->cfl);
	}
	else if ((p == op_callfunc && nd->le->bx3) || p == op_fastcall) {
		ND* ndh = nd->ri;
		while (ndh) {
			mf_expr(ndh);
			ndh = ndh->next;
		}
		we(W_CALL);
		we(nd->le->bx3 - 1);
	}
	else if (p == op_vnum) {
		we(0x23);	// get global 0 (nums)
		we(0x00);
		we(0x41);
		int h = nd->v1 * 8;
		if (h < 0) mf_err("expr vnum");
		we(h);
		we(W_ADDI);
		we(0x2B);	// loadf
		we(0x00);
		we(0x00);
	}
	else if (p == op_arrlen) {
		we(0x23);
		we(0x01);	// arrays
		we(0x41);

		int h = (nd->v1 + 1) * -12 + 4;
		if (h < 0) mf_err("expr");
		we(h);
		we(W_ADDI);

		we(0x28);	// load
		we(0x00);
		we(0x00);
		we(W_I2F);
	}
	else if (p == op_vnumael) {
		mf_arrpos(nd->v1, nd->ri);
		we(0x2B);	// loadf
		we(0x00);
		we(0x00);

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
	if (p == op_eqf) we(W_NE);
	else if (p == op_neqf) we(W_EQ);
	else if (p == op_ltf) we(W_GE);
	else if (p == op_gtf) we(W_LE);
	else if (p == op_lef) we(W_GT);
	else if (p == op_gef) we(W_LT);
	else mf_err("cmpneg");
	we(W_BRIF);
	we(lev);
}

static void mf_cmp(ND* nd, byte lev) {
	void* p = nd->intf;
	mf_expr(nd->le);
	mf_expr(nd->ri);
	if (p == op_eqf) we(W_EQ);
	else if (p == op_neqf) we(W_NE);
	else if (p == op_ltf) we(W_LT);
	else if (p == op_gtf) we(W_GT);
	else if (p == op_lef) we(W_LE);
	else if (p == op_gef) we(W_GE);
	else mf_err("cmp");
	we(W_BRIF);
	we(lev);
}
static void mf_andneg(ND* nd, byte lev) {
	if (nd->intf != op_and) {
		mf_cmpneg(nd, lev);
		return;
	}
	mf_andneg(nd->le, lev);
	mf_cmpneg(nd->ri, lev);
}

static void mf_and(ND* nd, byte lev) {
	if (nd->intf != op_and) {
		mf_cmp(nd, lev);
		return;
	}
	mf_and(nd->le, lev);
	mf_cmp(nd->ri, lev);
}

static void mf_repand(ND* nd) {
	void* p = nd->intf;

	if (mf_iscmp(p)) {
		mf_cmp(nd, 1);
	}
	else if (nd->intf == op_and) {

		we(W_BLOCK);
		we(W_VOID);

		mf_andneg(nd, 0);

		we(W_BR);
		we(2);
		we(W_END);
	}
	else {
		mf_err("repand");
	}
}

static void mf_condrep(ND* nd) {
	if (nd->intf != op_or) {
		mf_repand(nd);
		return;
	}
	mf_condrep(nd->le);
	mf_repand(nd->ri);
}

static void mf_or(ND* nd) {
	if (nd->intf != op_or) {
		mf_and(nd, 0);
		return;
	}
	mf_or(nd->le);
	mf_and(nd->ri, 0);
}

static void mf_cond(ND* nd, byte lev) {
	if (nd->intf == op_or) {
		we(W_BLOCK);
		we(W_VOID);

		mf_or(nd);

		we(W_BR);
		we(lev + 1);
		we(W_END);
	}
	else {
		mf_andneg(nd, lev);
	}
}
static void mf_statement(ND* nd) {
	nd_stat = nd;
	void* p = nd->vf;

	if (0) {}
	else if (p == op_while) {

		we(W_BLOCK);
		we(W_VOID);
		we(W_LOOP);
		we(W_VOID);

		mf_cond(nd->le, 1);
		mf_sequ(nd->ri);

		we(W_BR);
		we(0);
		we(W_END);
		we(W_END);
	}
	else if (p == op_for || p == op_fordown || p == op_for_to || p == op_forstep) {
		ND* ndx = nd + 1;
		if (p == op_for_to) {
			we(W_CONST);
			wef(1);
		}
		else mf_expr(ndx->ex2);		// from

		if (nd->v1 < 0) mf_err("loop var");

		we(W_SET);
		we(nd->v1);				// loop var

		mf_expr(nd->ri);		// to
		we(W_SET);
		we(wvar);

		if (p == op_forstep) {
			mf_expr(ndx->ex3);		// step
			we(W_SET);
			we(wvar + 1);
		}

		we(W_BLOCK);
		we(W_VOID);
		we(W_LOOP);
		we(W_VOID);

		we(W_GET);
		we(wvar);

		if (p == op_forstep) {
			we(W_GET);
			we(wvar + 1);
			we(W_CONST);
			wef(1);
			we(W_GET);
			we(wvar + 1);
			we(0xA6); 	// copysign

			we(W_TEE);
			we(wvar + 1);	// sign
			we(W_GET);
			we(wvar);
			we(W_MUL);

			we(W_GET);
			we(nd->v1);
			we(W_GET);
			we(wvar + 1);	// sign
			we(W_MUL);
		}
		else {
			we(W_GET);
			we(wvar);
			we(W_GET);
			we(nd->v1);
		}
		if (p == op_fordown) we(W_GT);
		else we(W_LT);

		we(W_BRIF);			// exit loop
		we(1);

		mf_sequ(ndx->ex);

		if (p == op_forstep) {
			we(W_TEE);
			we(wvar + 1);
			we(W_GET);
			we(nd->v1);
			we(W_ADD);
		}
		else {
			we(W_GET);
			we(nd->v1);
			we(W_CONST);
			wef(1);
			if (p == op_fordown) we(W_SUB);
			else we(W_ADD);
		}
		we(W_SET);
		we(nd->v1);

		we(W_SET);
		we(wvar);
		we(W_BR);
		we(0);

		we(W_END);
		we(W_END);
	}
	else if (p == op_if) {

		we(W_BLOCK);
		we(W_VOID);

		mf_cond(nd->le, 0);
		mf_sequ(nd->ri);

		we(W_END);

	}
	else if (p == op_if_else) {
		ND* ndx = nd->ri;

		we(W_BLOCK);
		we(W_VOID);
		we(W_BLOCK);
		we(W_VOID);

		mf_cond(nd->le, 0);

		mf_sequ(ndx->ex);

		we(W_BR);
		we(1);
		we(W_END);

		mf_sequ(ndx->ex2);

		we(W_END);

	}
	else if (p == op_repeat) {

		ND* ndx = nd + 1;

		we(W_BLOCK);
		we(W_VOID);
		we(W_LOOP);
		we(W_VOID);

		mf_sequ(nd->ri);
		mf_condrep(nd->le);
		mf_sequ(ndx->ex);

		we(W_BR);
		we(0);

		we(W_END);
		we(W_END);

	}
	else if (p == op_flassp || p == op_flassm || p == op_flasst || p == op_flassd) {
		if (nd->v1 >= 0) {
			we(W_GET);
			we(nd->v1);
			mf_expr(nd->ri);
			if (p == op_flassp) we(W_ADD);
			else if (p == op_flassm) we(W_SUB);
			else if (p == op_flasst) we(W_MUL);
			else we(W_DIV);
			we(W_SET);
			we(nd->v1);
		}
		else {
			we(0x23);	// get global 0 (nums)
			we(0x00);
			we(0x41);
			we((nd->v1 + 1) * -8);
			we(W_ADDI);
			we(W_TEE);
			we(wvar + 3);
			we(W_GET);
			we(wvar + 3);
			we(0x2B);	// loadf
			we(0x00);
			we(0x00);
			mf_expr(nd->ri);
			if (p == op_flassp) we(W_ADD);
			else if (p == op_flassm) we(W_SUB);
			else if (p == op_flasst) we(W_MUL);
			else we(W_DIV);
			we(0x39);	// store
			we(0x00);
			we(0x00);
		}
	}
	else if (p == op_flass) {
		if (nd->v1 >= 0) {	// local
			mf_expr(nd->ri);
			we(W_SET);
			we(nd->v1);
		}
		else {
			we(0x23);
			we(0x00);
			we(0x41);
			int h = (nd->v1 + 1) * -8;
			we(h);
			we(W_ADDI);
			mf_expr(nd->ri);
			we(0x39);	// store
			we(0x00);
			we(0x00);
		}
	}
	else if (p == op_flael_ass) {

		ND* ndx = nd + 1;

		mf_arrpos(nd->v1, nd->ri);
		mf_expr(ndx->ex);

		we(0x39);	// store
		we(0x00);
		we(0x00);
	}

	else if (p == op_flael_assp || p == op_flael_assm || p == op_flael_asst || p == op_flael_assd) {

		ND* ndx = nd + 1;
		mf_arrpos(nd->v1, nd->ri);
		we(W_TEE);
		we(wvar + 3);
		we(W_GET);
		we(wvar + 3);
		we(0x2B);	// loadf
		we(0x00);
		we(0x00);
		mf_expr(ndx->ex);

		if (p == op_flael_assp) we(W_ADD);
		else if (p == op_flael_assm) we(W_SUB);
		else if (p == op_flael_asst) we(W_MUL);
		else we(W_DIV);

		we(0x39);	// store
		we(0x00);
		we(0x00);
	}
	else if (p == op_return) {
		if (nd->le) mf_expr(nd->le);
		else {
			we(W_CONST);
			wef(0);
		}
		we(0x0f);
	}


	else if ((p == op_callproc && nd->le->bx3) || p == op_fastcallproc) {
		ND* ndh = nd->ri;
		while (ndh) {
			mf_expr(ndh);
			ndh = ndh->next;
		}
		we(W_CALL);
		we(nd->le->bx3 - 1);
		we(W_DROP);
	}
	else if (p == op_swapnumael) {
		// swap a[i] a[j]
		ND* ndx = nd + 1;

		mf_arrpos(nd->v1, nd->ri);
		we(W_TEE);
		we(wvar + 3);	// &a[i]
		we(0x2B);	// loadf
		we(0x00);
		we(0x00);		// a[i]


		we(W_GET);
		we(wvar + 3);	// &a[i]

		mf_arrpos(ndx->vx2, ndx->ex);
		we(W_TEE);
		we(wvar + 4);	// &a[j]
		we(0x2B);	// loadf
		we(0x00);
		we(0x00);		// a[j]

		we(0x39);	// storef  a[i] <= a[j]
		we(0x00);
		we(0x00);

		we(W_SET);
		we(wvar);
		we(W_GET);
		we(wvar + 4);	// &a[j]
		we(W_GET);
		we(wvar);

		we(0x39);	// storef  a[j] <= a[i]
		we(0x00);
		we(0x00);
	}
	else {
		mf_err("sequence");
	}

}
static void mf_sequ(ND* nd) {
	while (nd) {
		mf_statement(nd);
		nd = nd->next;
	}
}

static void parse_fastfunc(void) {

	// parameter
	byte nparm;

	if (strcmp(proc->parms, "") == 0) nparm = 0;
	else if (strcmp(proc->parms, "f") == 0) nparm = 1;
	else if (strcmp(proc->parms, "ff") == 0) nparm = 2;
	else if (strcmp(proc->parms, "fff") == 0) nparm = 3;
	else if (strcmp(proc->parms, "ffff") == 0) nparm = 4;
	else {
		error("a fastfunc has only max 4 number parameter");
		return;
	}
	if (proc->varcnt[1] + proc->varcnt[2] > 0) {
		error("in fastfunc only mumbers are allowed");
		return;
	}
	if (wasm == NULL) {
		wasm = _realloc(NULL, 1000);
		wasm_len = 1000;
		wasmi = 0;
		fastfuncn = 0;
	}
	fastfuncn += 1;
	proc->start->bx3 = fastfuncn;

	ushort fstart = wasmi;
	// func size
	wasmi += 2;

	byte b = proc->varcnt[0] - nparm;
	wvar = b + nparm;
	b += 3;

	we(2);
	we(b);			// count
	we(0x7c);		// f64
	we(2);			// count
	we(0x7f);		// i32

	mf_sequ(proc->start->bxnd);

	if (fastfuncn == 0) {
		// error
		goto cleanup;
	}

	we(0x44);	// constf
	wef(0);

	we(W_END);

	ushort h = wasmi - 2 - fstart;

	if (h >= 16384 - 3) {
		error("fastfunc too big");
		goto cleanup;
	}
	// func size
	wasm[fstart] = (h & 127) | 128;
	wasm[fstart + 1] = h >> 7;

	// printf("fastfunc %s - size %d\n", proc->name, h);
	return;

cleanup:

	free(wasm);
	wasm = NULL;
}


static int emleb(byte* out, uint v) {
	int n = 0;
	do {
		byte b = v & 0x7F;
		v >>= 7;
		if (v) b |= 0x80;
		out[n++] = b;
	} while (v);
	return n;
}
static int emstr(byte* out, const char* s) {
	int len = strlen(s);
	int n = emleb(out, len);
	memcpy(out + n, s, len);
	return n + len;
}

static void build_fastfuncs(void) {

	byte wasmhd[2048];
	byte tmp[1024];

	int k = 0;
	int t;

	memcpy(wasmhd + k, "\0asm", 4); k += 4;
	memcpy(wasmhd + k, "\1\0\0\0", 4); k += 4;

	// --- type
	t = 0;
	tmp[t++] = 5;				  // number of types
	for (byte j = 0; j <= 4; j++) {
		tmp[t++] = 0x60;		   // func type
		tmp[t++] = j;			  // param count = j
		for (byte i = 0; i < j; i++) tmp[t++] = 0x7c;  // f64
		tmp[t++] = 1;			  // result count
		tmp[t++] = 0x7c;		   // f64 result
	}

	wasmhd[k++] = 0x01;			// section id: Type
	k += emleb(wasmhd + k, t);  // section size
	memcpy(wasmhd + k, tmp, t);
	k += t;

	// --- import
	t = 0;
	tmp[t++] = 3;							// import count = 2

	// -- import 1: memory
	t += emstr(tmp + t, "env");				// module "env"
	t += emstr(tmp + t, "memory");			// field  "memory"
	tmp[t++] = 0x02;						// kind = memory
	tmp[t++] = 0x00;						// limits flags = 0 (min only)
	t += emleb(tmp + t, 1);					// min = 1 page

	// -- import 2: globals
	t += emstr(tmp + t, "env");				// module "env"
	t += emstr(tmp + t, "gnum");			// field  "gnum"
	tmp[t++] = 0x03;						// kind = global
	tmp[t++] = 0x7f;						// valtype = i32
	tmp[t++] = 0x01;						// mutable = true

	t += emstr(tmp + t, "env");
	t += emstr(tmp + t, "garr");
	tmp[t++] = 0x03;
	tmp[t++] = 0x7f;
	tmp[t++] = 0x01;

	wasmhd[k++] = 0x02;						// section id: Import
	k += emleb(wasmhd + k, t);
	memcpy(wasmhd + k, tmp, t);
	k += t;

	// --- function
	t = 0;

	tmp[t++] = fastfuncn;					// number of functions

	byte nparm;
	struct proc* p = proc_p;
	while (p < proc_p + proc_len) {
		if (p->start->bx3 != 0) {
			if (strcmp(p->parms, "") == 0) nparm = 0;
			else if (strcmp(p->parms, "f") == 0) nparm = 1;
			else if (strcmp(p->parms, "ff") == 0) nparm = 2;
			else if (strcmp(p->parms, "fff") == 0) nparm = 3;
			else nparm = 4;
			tmp[t++] = nparm;				// type index (0..4)
		}
		p += 1;
	}
	wasmhd[k++] = 0x03;					  // section id: Function
	k += emleb(wasmhd + k, t);
	memcpy(wasmhd + k, tmp, t);
	k += t;

	// --- export
	// "a","b","c",.
	t = 0;

	tmp[t++] = fastfuncn;					// number of exports
	for (byte i = 0; i < fastfuncn; i++) {
		tmp[t++] = 1;				// str len
		tmp[t++] = 'a' + i;
		tmp[t++] = 0;				// export kind
		tmp[t++] = i;				// func index
	}
	wasmhd[k++] = 0x07;				// section id: Export
	k += emleb(wasmhd + k, t);
	memcpy(wasmhd + k, tmp, t);
	k += t;

	// --- code
	int ncount = emleb(tmp, fastfuncn);
	uint payload_size = wasmi + ncount;

	wasmhd[k++] = 0x0A;						// section id: Code
	k += emleb(wasmhd + k, payload_size);	// section size
	memcpy(wasmhd + k, tmp, ncount);
	k += ncount;							// function count

#ifdef __EMSCRIPTEN__
	EM_ASM({
		var hdrView = HEAPU8.subarray($0, $0 + $1);
		var bodyView = HEAPU8.subarray($2, $2 + $3);
		var bytes = new Uint8Array(hdrView.length + bodyView.length);
		bytes.set(hdrView, 0);
		bytes.set(bodyView, hdrView.length);

		var mod = new WebAssembly.Module(bytes);
		Module['gnum'] = new WebAssembly.Global({ value: 'i32', mutable: true }, 0);
		Module['garr'] = new WebAssembly.Global({ value: 'i32', mutable: true }, 0);

		fastinst = new WebAssembly.Instance(mod, {
			env: {
				// memory: Module['wasmMemory'],
				memory: wasmMemory,
				gnum: Module['gnum'],
				garr: Module['garr']
			}
		});

	}, wasmhd, k, wasm, wasmi);
#endif
	free(wasm);
	wasm = NULL;
}

static void wasm_clean(void) {
	fastfunc_errline = 0;
	free(wasm);
	wasm = NULL;
#ifdef __EMSCRIPTEN__
	EM_ASM({
		fastinst = null
	});
#endif
}
