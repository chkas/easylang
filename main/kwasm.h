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
static ushort wvara;
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
	if (fastfunc_errline == -1) fastfunc_errline = getline_nd(nd_stat);
	pr("fastfunc error:%s line:%d", s, fastfunc_errline);
}

#define W_BLOCK 0x02
#define W_LOOP 0x03
#define W_CALL 0x10
#define W_VOID 0x40
#define W_F64 0x7c

#define W_END 0x0b
#define W_BRIF 0x0d
#define W_BR 0x0c
#define W_GET 0x20
#define W_SET 0x21
#define W_TEE 0x22
#define W_GLGET 0x23

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

#define W_EQI 0x46
#define W_NEI 0x47
#define W_LTIS 0x48
#define W_LTI 0x49
#define W_GTIS 0x4A
#define W_GTI 0x4B
#define W_LEIS 0x4C
#define W_LEI 0x4D
#define W_GEIS 0x4E
#define W_GEI 0x4F

#define W_ADDI 0x6a
#define W_SUBI 0x6b
#define W_CONSTI 0x41
#define W_SHL 0x74

#define W_F2I 0xAB // i32.trunc_f64_u
#define W_I2F 0xB8 // f64.convert_i32_u
#define W_DROP 0x1a
#define W_CALL_INDIRECT 0x11

#define W_COPYSIGN 0xA6
#define W_SELECT 0x1B
#define W_LOADI 0x28
#define W_LOADBS 0x2C
#define W_LOADF 0x2B
#define W_STOREF 0x39

static ushort wretlev;
static ushort wlooplev;
static byte loopstack[20];

 
static byte must_cleanup;

static void blstart(byte t) {
	we(t);
	we(W_VOID);
	if (t == W_LOOP) {
		if (wlooplev >= 20) {
			mf_err("too much loop nestings");
			return;
		}
		loopstack[wlooplev] = wretlev;
		wlooplev += 1;
	}
	wretlev += 1;
}
static void blend(byte t) {
	if (t == W_LOOP) wlooplev -= 1;
	wretlev -= 1;
	we(W_END);
}
static void wex(byte cmd, byte a) {
	we(cmd);
	we(a);
}

static void mf_sequ(ND* nd);
static void mf_expr(ND* nd);

static void mf_op(int nr) {
	wex(W_CONSTI, nr);
	we(W_CONST);
	wef(0);
	wex(W_CONSTI, 0);		// systable 0
	we(W_CALL_INDIRECT);
	we(5);	// (i32,f64)->f64
	we(0);
}
static void mf_opf(int nr, ND* arg) {
	wex(W_CONSTI, nr);
	mf_expr(arg);
	wex(W_CONSTI, 0);		// systable 0
	we(W_CALL_INDIRECT);
	we(5);	// (i32,f64)->f64
	we(0);
}
static void mf_opff(int nr, ND* arg, ND* arg2) {
	wex(W_CONSTI, nr);
	mf_expr(arg);
	mf_expr(arg2);
	wex(W_CONSTI, 1);		// systable 1
	we(W_CALL_INDIRECT);
	we(8);	// (i32,f64,f64)->f64
	we(0);
}

static void mf_larrpos(ushort pos, ND* ex) {
	wex(W_GET, pos);
	mf_expr(ex);
	we(W_F2I);
	wex(W_GET, pos + 2);
	we(W_SUBI);
	wex(W_CONSTI, 3);
	we(W_SHL);
	we(W_ADDI);
}
static void mf_arrpos(short id, ND* ex, byte typ) {
	wex(W_GLGET, 1);	// arrays
	we(W_CONSTI);
	int h = (id + 1) * -12;
	if (h < 0) mf_err("expr");
	we(h);
	we(W_ADDI);
	we(W_LOADI);
	we(0x00);
	we(0x00);

	mf_expr(ex);
	we(W_F2I);

#if 0
	we(W_CONSTI);
	we(1);
#else
	wex(W_GLGET, 1); 	// arrays
	we(W_CONSTI);
	we((id + 1) * -12 + 8);
	we(W_ADDI);
	we(W_LOADBS);
	we(0x00);
	we(0x00);
#endif
	we(W_SUBI);
	if (typ == 0) {
		wex(W_CONSTI, 3);
		we(W_SHL);
	}
	we(W_ADDI);
}

static void mf_arrlen(int v) {
	if (v >= 0) {
		wex(W_GET, wvara + v * 3 + 1);
	}
	else {
		wex(W_GLGET, 1); 	// arrays
		wex(W_CONSTI, (v + 1) * -12 + 4);
		we(W_ADDI);
		we(W_LOADI);	// load
		we(0x00);
		we(0x00);
	}
}

static void mf_arrbase(int v) {
	if (v >= 0) {
		wex(W_GET, wvara + v * 3);
	}
	else {
		wex(W_GLGET, 1);
		wex(W_CONSTI, (v + 1) * -12);
		we(W_ADDI);
		we(W_LOADI);
		we(0x00);
		we(0x00);
	}
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
		wex(W_TEE, wvar);
		wex(W_GET, wvar);

		mf_expr(nd->ri);
		wex(W_TEE, wvar + 1);
		we(W_DIV);
		we(W_FLOOR);
		wex(W_GET, wvar + 1);
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
		wex(W_GET, nd->v1);
	}
	else if (p == op_const_fl) {
		we(W_CONST);
		wef(nd->cfl);
	}
	else if ((p == op_callfunc && nd->le->bx3) || p == op_fastcall) {
		ND* ndh = nd->ri;
		while (ndh) {
			mf_expr(ndh);
			ndh = ndh->next;
		}
		wex(W_CALL, nd->le->bx3 - 1);
	}
	else if (p == op_vnum) {
		wex(W_GLGET, 0);	// nums
		we(W_CONSTI);
		int h = nd->v1 * 8;
		if (h < 0) mf_err("expr vnum");
		we(h);
		we(W_ADDI);
		we(W_LOADF);
		we(0x00);
		we(0x00);
	}
	else if (p == op_arrlen) {
		mf_arrlen(nd->v1);
		we(W_I2F);
	}
	else if (p == op_vnumael) {
		if (nd->v1 >= 0) {
			mf_larrpos(wvara + nd->v1 * 3, nd->ri);
		}
		else {
			mf_arrpos(nd->v1, nd->ri, 0);
		}
		we(W_LOADF);
		we(0x00);
		we(0x00);
	}
	else if (p == op_sign) {
		we(W_CONST);
		wef(1);
		mf_expr(nd->le);
		wex(W_TEE, wvar);
		we(W_COPYSIGN);
		we(W_CONST);
		wef(0);

		we(W_CONST);
		wef(0);
		wex(W_GET, wvar);
		we(W_NE);
		we(W_SELECT);
	}

	else if (p == op_random) mf_opf(0, nd->le);
	else if (p == op_randomf) mf_op(1);
	else if (p == op_pi) mf_op(2);
	else if (p == op_sin) mf_opf(3, nd->le);
	else if (p == op_cos) mf_opf(4, nd->le);
	else if (p == op_tan) mf_opf(5, nd->le);
	else if (p == op_asin) mf_opf(6, nd->le);
	else if (p == op_acos) mf_opf(7, nd->le);
	else if (p == op_atan) mf_opf(8, nd->le);

	else if (p == op_atan2) mf_opff(0, nd->le, nd->ri);
	else if (p == op_pow) mf_opff(1, nd->le, nd->ri);
	else if (p == op_log) mf_opff(2, nd->le, nd->ri);

	else if (p == op_vbyteael) {
		if (nd->v1 >= 0) mf_err("local array");
		mf_arrpos(nd->v1, nd->ri, 1);
		we(0x2d);		// load u8 -> i32
		we(0x00);
		we(0x00);
		we(W_I2F);
	}
	else {
		mf_err("expr");
	}
}

static int mf_iscmp(void* p) {
	if (p == op_eqf || p == op_neqf || p == op_lef || p == op_ltf
		|| p == op_gef ||  p == op_gtf) return 1;
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
static void mf_brtrue(ND* nd, byte lev);
static void mf_brfalse(ND* nd, byte lev);

static void mf_brtrue(ND* nd, byte lev) {
	void* p = nd->intf;

	if (p == op_or) {
		mf_brtrue(nd->le, lev);
		mf_brtrue(nd->ri, lev);
	}
	else if (p == op_and) {
		we(W_BLOCK); we(W_VOID);
		mf_brfalse(nd->le, 0);
		mf_brtrue(nd->ri, lev + 1);
		we(W_END);
	}
	else if (mf_iscmp(p)) {
		mf_cmp(nd, lev);
	}
	else {
		mf_err("brtrue");
	}
}

static void mf_brfalse(ND* nd, byte lev) {
	void* p = nd->intf;

	if (p == op_or) {
		we(W_BLOCK); we(W_VOID);
		mf_brtrue(nd->le, 0);
		mf_brfalse(nd->ri, lev + 1);
		we(W_END);
	}
	else if (p == op_and) {
		mf_brfalse(nd->le, lev);
		mf_brfalse(nd->ri, lev);
	}
	else if (mf_iscmp(p)) {
		mf_cmpneg(nd, lev);
	}
	else {
		mf_err("brfalse");
	}
}

static void mf_cond(ND* nd, byte lev) {
	mf_brfalse(nd, lev);
}
static void mf_condrep(ND* nd) {
	mf_brtrue(nd, 1);
}

static void mf_statement(ND* nd) {
	nd_stat = nd;
	void* p = nd->vf;

	if (0) {}
	else if (p == op_while) {
		blstart(W_BLOCK);
		blstart(W_LOOP);

		mf_cond(nd->le, 1);
		mf_sequ(nd->ri);

		wex(W_BR, 0);
		blend(W_LOOP);
		blend(W_BLOCK);
	}
	else if (p == op_for || p == op_fordown || p == op_for_to || p == op_forstep) {
		ND* ndx = nd + 1;
		if (p == op_for_to) {
			we(W_CONST);
			wef(1);
		}
		else mf_expr(ndx->ex2);		// from

		if (nd->v1 < 0) mf_err("loop var");

		wex(W_SET, nd->v1);			// loop var

		mf_expr(nd->ri);			// to
		wex(W_SET, wvar);

		if (p == op_forstep) {
			mf_expr(ndx->ex3);		// step
			wex(W_SET, wvar + 1);
		}

		blstart(W_BLOCK);
		blstart(W_LOOP);

		wex(W_GET, wvar);

		if (p == op_forstep) {
			wex(W_GET, wvar + 1);
			we(W_CONST);
			wef(1);
			wex(W_GET, wvar + 1);
			we(W_COPYSIGN);

			wex(W_TEE, wvar + 1);	// sign
			wex(W_GET, wvar);
			we(W_MUL);

			wex(W_GET, nd->v1);
			wex(W_GET, wvar + 1);	// sign
			we(W_MUL);
		}
		else {
			wex(W_GET, wvar);
			wex(W_GET, nd->v1);
		}
		if (p == op_fordown) we(W_GT);
		else we(W_LT);

		wex(W_BRIF, 1);			// exit loop

		mf_sequ(ndx->ex);

		if (p == op_forstep) {
			wex(W_TEE, wvar + 1);
			wex(W_GET, nd->v1);
			we(W_ADD);
		}
		else {
			wex(W_GET, nd->v1);
			we(W_CONST);
			wef(1);
			if (p == op_fordown) we(W_SUB);
			else we(W_ADD);
		}
		wex(W_SET, nd->v1);

		wex(W_SET, wvar);
		wex(W_BR, 0);

		blend(W_LOOP);
		blend(W_BLOCK);
	}
	else if (p == op_for_in) {

		ND* ndx = nd + 1;

		if (nd->v1 < 0) mf_err("iter variable must be local");
		if (nd->ri->arrf != op_vnumarr) mf_err("array expected");

		wex(W_GET, nd->v1);			// iter var

		wex(W_CONSTI, 0);
		wex(W_SET, wvar + 2);

		blstart(W_BLOCK);
		blstart(W_LOOP);
		wex(W_GET, wvar + 2);

		mf_arrlen(nd->ri->v1);
		we(W_GEI);
		wex(W_BRIF, 1);

		wex(W_GET, wvar + 2);

		mf_arrbase(nd->ri->v1);

		wex(W_GET, wvar + 2);
		wex(W_CONSTI, 3);
		we(W_SHL);
		we(W_ADDI);
		we(W_LOADF);
		we(0x00);
		we(0x00);

		wex(W_SET, nd->v1);			// iter var

		mf_sequ(ndx->ex);

		wex(W_CONSTI, 1);
		we(W_ADDI);

		wex(W_SET, wvar + 2);
		wex(W_BR, 0);

		blend(W_LOOP);
		blend(W_BLOCK);

		// set old iter var, when loop reached end
		wex(W_GET, nd->v1);
		wex(W_GET, wvar + 2);

		mf_arrlen(nd->ri->v1);

		we(W_EQI);
		we(W_SELECT);
		wex(W_SET, nd->v1);
		
	}
	else if (p == op_if) {

		blstart(W_BLOCK);
		mf_cond(nd->le, 0);
		mf_sequ(nd->ri);
		blend(W_BLOCK);

	}
	else if (p == op_if_else) {
		ND* ndx = nd->ri;

		blstart(W_BLOCK);
		blstart(W_BLOCK);

		mf_cond(nd->le, 0);

		mf_sequ(ndx->ex);

		wex(W_BR, 1);
		blend(W_BLOCK);

		mf_sequ(ndx->ex2);

		blend(W_BLOCK);

	}
	else if (p == op_repeat) {

		ND* ndx = nd + 1;

		blstart(W_BLOCK);
		blstart(W_LOOP);

		mf_sequ(nd->ri);
		mf_condrep(nd->le);
		mf_sequ(ndx->ex);

		wex(W_BR, 0);

		blend(W_LOOP);
		blend(W_BLOCK);

	}
	else if (p == op_flassp || p == op_flassm || p == op_flasst || p == op_flassd) {
		if (nd->v1 >= 0) {
			wex(W_GET, nd->v1);
			mf_expr(nd->ri);
			if (p == op_flassp) we(W_ADD);
			else if (p == op_flassm) we(W_SUB);
			else if (p == op_flasst) we(W_MUL);
			else we(W_DIV);
			wex(W_SET, nd->v1);
		}
		else {
			wex(W_GLGET, 0);	// nums
			we(W_CONSTI);
			we((nd->v1 + 1) * -8);
			we(W_ADDI);
			wex(W_TEE, wvar + 2);
			wex(W_GET, wvar + 2);
			we(W_LOADF);
			we(0x00);
			we(0x00);
			mf_expr(nd->ri);
			if (p == op_flassp) we(W_ADD);
			else if (p == op_flassm) we(W_SUB);
			else if (p == op_flasst) we(W_MUL);
			else we(W_DIV);
			we(W_STOREF);	// store
			we(0x00);
			we(0x00);
		}
	}
	else if (p == op_flass) {
		if (nd->v1 >= 0) {	// local
			mf_expr(nd->ri);
			wex(W_SET, nd->v1);
		}
		else {
			wex(W_GLGET, 0);
			we(W_CONSTI);
			we((nd->v1 + 1) * -8);
			we(W_ADDI);
			mf_expr(nd->ri);
			we(W_STOREF);	// store
			we(0x00);
			we(0x00);
		}
	}
	else if (p == op_numael_ass) {

		ND* ndx = nd + 1;
		if (nd->v1 >= 0) {	// local
			mf_larrpos(wvara + nd->v1 * 3, nd->ri);
		}
		else {
			mf_arrpos(nd->v1, nd->ri, 0);
		}
		mf_expr(ndx->ex);
		we(W_STOREF);	// store
		we(0x00);
		we(0x00);
	}
	else if (p == op_numael_assp || p == op_numael_assm || p == op_numael_asst || p == op_numael_assd) {

		ND* ndx = nd + 1;
		if (nd->v1 >= 0) {	// local
			mf_larrpos(wvara + nd->v1 * 3, nd->ri);
		}
		else {
			mf_arrpos(nd->v1, nd->ri, 0);
		}
		wex(W_TEE, wvar + 2);
		wex(W_GET, wvar + 2);
		we(W_LOADF);
		we(0x00);
		we(0x00);
		mf_expr(ndx->ex);
		if (p == op_numael_assp) we(W_ADD);
		else if (p == op_numael_assm) we(W_SUB);
		else if (p == op_numael_asst) we(W_MUL);
		else we(W_DIV);
		we(W_STOREF);	// store
		we(0x00);
		we(0x00);
	}
	else if (p == op_return) {
		if (nd->le) mf_expr(nd->le);
		else {
			we(W_CONST);
			wef(0);
		}
		if (must_cleanup) {
			wex(W_SET, wvar);
			wex(W_BR, wretlev);
		}
		else we(0x0f);
	}


	else if ((p == op_callproc && nd->le->bx3) || p == op_fastcallproc) {
		ND* ndh = nd->ri;
		while (ndh) {
			mf_expr(ndh);
			ndh = ndh->next;
		}
		wex(W_CALL, nd->le->bx3 - 1);
		we(W_DROP);
	}
	else if (p == op_swapnumael) {
		// swap a[i] a[j]
		ND* ndx = nd + 1;

		mf_arrpos(nd->v1, nd->ri, 0);
		wex(W_TEE, wvar + 2);	// &a[i]
		we(W_LOADF);	// loadf
		we(0x00);
		we(0x00);		// a[i]

		wex(W_GET, wvar + 2);	// &a[i]

		mf_arrpos(ndx->vx2, ndx->ex, 0);
		wex(W_TEE, wvar + 3);	// &a[j]
		we(W_LOADF);			// loadf
		we(0x00);
		we(0x00);				// a[j]

		we(W_STOREF);			// storef  a[i] <= a[j]
		we(0x00);
		we(0x00);

		wex(W_SET, wvar);
		wex(W_GET, wvar + 3);	// &a[j]
		wex(W_GET, wvar);

		we(W_STOREF);	// storef  a[j] <= a[i]
		we(0x00);
		we(0x00);
	}

	else if (p == op_numarr_len) {

		if (nd->v1 >= 0) {

			wex(W_GET, wvara + nd->v1 * 3);
			wex(W_GET, wvara + nd->v1 * 3 + 1); // olen

			mf_expr(nd->ri); 				// nlen
			we(W_F2I);
			wex(W_TEE,wvara + nd->v1 * 3 + 1);

			we(W_CONSTI);
			we(2);							// function 2
			we(W_CALL_INDIRECT);
			we(6);							// (i32,i32,i32)->i32
			we(0);
			wex(W_SET, wvara + nd->v1 * 3);
		}
		else {
			wex(W_CONSTI, 1);
			wex(W_CONSTI, -(nd->v1 + 1));
			mf_expr(nd->ri);

			we(W_CONSTI);
			we(3);							// function 3
			we(W_CALL_INDIRECT);
			we(7);							// (i32,i32,f64)
			we(0);
		}
	}
	else if (p == op_numarr_append) {

		if (nd->v1 >= 0) {

			wex(W_GET, wvara + nd->v1 * 3);
			wex(W_GET, wvara + nd->v1 * 3 + 1); // len
			wex(W_GET, wvara + nd->v1 * 3 + 1);
			wex(W_TEE, wvar + 2);
			wex(W_CONSTI, 1);
			we(W_ADDI);
			wex(W_TEE, wvara + nd->v1 * 3 + 1); // nlen
	
			we(W_CONSTI);
			we(2);							// function 2
			we(W_CALL_INDIRECT);
			we(6);							// (i32,i32,i32)->i32
			we(0);

			wex(W_TEE, wvara + nd->v1 * 3);
			wex(W_GET, wvar + 2);
			wex(W_CONSTI, 3);
			we(W_SHL);
			we(W_ADDI);
			mf_expr(nd->ri);
			we(W_STOREF);
			we(0x00);
			we(0x00);
		}
		else {
			wex(W_CONSTI, 0);
			wex(W_CONSTI, -(nd->v1 + 1));
			mf_expr(nd->ri);

			we(W_CONSTI);
			we(3);							// function 3
			we(W_CALL_INDIRECT);
			we(7);							// (i32,i32,f64)
			we(0);
		}
	}
	else if (p == op_break) {
		//pr("break %d %d %d %d", nd->v1, wlooplev, wretlev, loopstack[wlooplev - nd->v1]);
		wex(W_BR, wretlev - loopstack[wlooplev - nd->v1]);
	}
	else if (p == op_swapnum) {
		wex(W_GET, nd->v1);
		wex(W_GET, nd->v2);
		wex(W_SET, nd->v1);
		wex(W_SET, nd->v2);
	}
	else if (p == op_byteael_ass) {
		ND* ndx = nd + 1;
		if (nd->v1 >= 0) mf_err("local array");
		mf_arrpos(nd->v1, nd->ri, 1);
		mf_expr(ndx->ex);
		we(W_F2I);
		we(0x3a);	// i32-> 8 store
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
	if (proc->varcnt[1]) {
		error("in fastfunc strings are not allowed");
		return;
	}
	must_cleanup = 0;
	if (proc->varcnt[2]) {
		must_cleanup = 1;
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

	we(4);							// 4 sections
	we(proc->varcnt[0]);			// count
	we(W_F64);						// f64

	wvara = proc->varcnt[0] + nparm;
	we(proc->varcnt[2] * 3);		// count
	we(0x7f);						// i32

	wvar = proc->varcnt[0] + proc->varcnt[2] * 3 + nparm;
	we(2);			// count
	we(W_F64);		// f64
	we(2);			// count
	we(0x7f);		// i32

// ---------------- start

	if (must_cleanup) {
		we(W_BLOCK);
		we(W_VOID);
	}
	wretlev = 0;

	for (int i = 0; i < proc->varcnt[2]; i++) {		// arrbase default 1
		wex(W_CONSTI, 1);
		wex(W_SET, wvara + i * 3 + 2);
	}
	mf_sequ(proc->start->bxnd);

	if (fastfuncn == 0) {
		// error
		goto cleanup;
	}

	we(W_CONST);
	wef(0);

	if (must_cleanup) {

		wex(W_SET, wvar);
		we(W_END);

		for (int i = 0; i < proc->varcnt[2]; i++) {
			// free local arrays
			wex(W_GET, wvara + i * 3);
			wex(W_CONSTI, 0);
			wex(W_CONSTI, 0);

			wex(W_CONSTI, 2);		// function 2
			we(W_CALL_INDIRECT);
			we(6);			// (i32,i32,i32)->i32
			we(0);
			we(W_DROP);
		}
		wex(W_GET, wvar);
	}
	we(W_END);


	ushort h = wasmi - 2 - fstart;

	if (h >= 16384 - 3) {
		error("fastfunc too big");
		goto cleanup;
	}
	// func size
	wasm[fstart] = (h & 127) | 128;
	wasm[fstart + 1] = h >> 7;

	//printf("fastfunc %s - size %d\n", proc->name, h);
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
	tmp[t++] = 9;				  // number of types
	for (byte j = 0; j <= 4; j++) {
		tmp[t++] = 0x60;		   // func type
		tmp[t++] = j;			  // param count = j
		for (byte i = 0; i < j; i++) tmp[t++] = W_F64;  // f64
		tmp[t++] = 1;			  // result count
		tmp[t++] = W_F64;		   // f64 result
	}
	tmp[t++] = 0x60;
	tmp[t++] = 2;
	tmp[t++] = 0x7f;  // i32
	tmp[t++] = W_F64;  // f64
	tmp[t++] = 1;
	tmp[t++] = W_F64;  // f64

	tmp[t++] = 0x60;
	tmp[t++] = 3;
	tmp[t++] = 0x7f;  // i32
	tmp[t++] = 0x7f;  // i32
	tmp[t++] = 0x7f;  // i32
	tmp[t++] = 1;
	tmp[t++] = 0x7f;  // i32

	tmp[t++] = 0x60;
	tmp[t++] = 3;
	tmp[t++] = 0x7f;  // i32
	tmp[t++] = 0x7f;  // i32
	tmp[t++] = W_F64;
	tmp[t++] = 0;

	tmp[t++] = 0x60;
	tmp[t++] = 3;
	tmp[t++] = 0x7f;  // i32
	tmp[t++] = W_F64;
	tmp[t++] = W_F64;
	tmp[t++] = 1;
	tmp[t++] = W_F64;

	wasmhd[k++] = 0x01;			// section id: Type
	k += emleb(wasmhd + k, t);  // section size
	memcpy(wasmhd + k, tmp, t);
	k += t;

	// --- import
	t = 0;
	tmp[t++] = 4;							// import count = 4

	// -- import 1: memory
	t += emstr(tmp + t, "env");				// module "env"
	t += emstr(tmp + t, "memory");			// field  "memory"
	tmp[t++] = 0x02;						// kind = memory
	tmp[t++] = 0x00;						// limits flags = 0 (min only)
	t += emleb(tmp + t, 1);					// min = 1 page

	// import 2: table (NEW)
	t += emstr(tmp + t, "env");
	t += emstr(tmp + t, "table");
	tmp[t++] = 0x01;  // kind = table
	tmp[t++] = 0x70;  // elemtype = funcref
	tmp[t++] = 0x00;  // limits: min only
	t += emleb(tmp + t, 0); // min = 0

	// -- import 3: globals
	t += emstr(tmp + t, "env");				// module "env"
	t += emstr(tmp + t, "gnum");			// field  "gnum"
	tmp[t++] = 0x03;						// kind = global
	tmp[t++] = 0x7f;						// valtype = i32
	tmp[t++] = 0x01;						// mutable = true

	// -- import 4: arrays
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
				table: sysTable,
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
	fastfunc_errline = -1;
	free(wasm);
	wasm = NULL;
#ifdef __EMSCRIPTEN__
	EM_ASM({
		fastinst = null
	});
#endif
}
