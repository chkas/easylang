/*	kbasw.c

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "created by" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

var timer

function cancelTimer() {
	if (timer) {
		clearTimeout(timer)
		timer = null
	}
}
function timerF() {
	Module.ccall("evt_func", "null", ["int", "string"], [2, null])
	update()
}
function setTimer(s) {
	cancelTimer()
	if (s >= 0) timer = setTimeout(timerF, 1000 * s)
}
function update() {
	if (cmds.length > 0) {
		postMessage(["list", cmds])
		cmds = []
	}
}

function push(v) {
	cmds.push(v)
	if (cmds.length > 300000) update()
}

function parsex(d) {
	var res = Module.ccall("parse", "int", ["string", "int", "int"], [d[1], d[2], d[3]])
	if (d[3] != -1) {
		var src = Module.ccall("format", "string", null, null)
		var pos = Module.ccall("caret", "int", null, null)
		if (res >= 0) {
			var err = Module.ccall("errstr", "string", null, null)
			postMessage(["ide", "src_err", src, res, pos, err])
		}
		else postMessage(["ide", "src", src, res, pos])
	}
	else {
		if (res >= 0) postMessage(["error"])
	}
	return res
}

function runx(dbg = 0) {
	cmds = []
	var on = 0
	try {
		on = Module.ccall("exec", null, ["int", "string"], [dbg, null])
	}
	catch(e) {
		update()
		postMessage(['print', "" + e])
		postMessage(['exit'])
		return
	}
	update()
	if (on == 0) postMessage(["done"])
}

onmessage = function(e) {
	var d = e.data
	var cmd = d[0]

	if (cmd == "mouse") {
		Module.ccall("evt_mouse", "null", ["int", "float", "float"], [d[1], d[2], d[3]])
		update()
	}
	else if (cmd == "animate") {
		Module.ccall("evt_func", "null", ["int", "string"], [1, null])
		update()
	}
	else if (cmd == "key") {
		Module.ccall("evt_func", "null", ["int", "string"], [0, d[1]])
		update()
	}
	else if (cmd == "keyup") {
		Module.ccall("evt_func", "null", ["int", "string"], [8, d[1]])
		update()
	}
	else if (cmd == "stop_ping") {
		cancelTimer()
		Module.ccall("k_free", "null", null, null)
		postMessage(["stop_pong"])
	}
	else if (cmd == "init") {
		sab = d[1]
		lang = d[2]
	}
	else if (cmd == "run") {
		if (parsex(d) < 0) runx(d[2] >> 8)
	}
	else if (cmd == "runx") {
		var res = parsex(d)
		if (d[3] == -1 && res < 0) {
			runx(0)
		}
	}
	else if (cmd == "runxr") {
		runx(0)
	}
	else if (cmd == "format") {
		var res = Module.ccall("parse", "int", ["string", "int", "int"], [d[1], 8 + 6, 0])
		var src = Module.ccall("format", "string", null, null)
		var pos = Module.ccall("caret", "int", null, null)
		var err = Module.ccall("errstr", "string", null, null)
		postMessage(["ide", "src_nl", src, res, pos, err])
	}
	else if (cmd == "formatID") {
		Module.ccall("parse", "int", ["string", "int", "int"], [d[1], 6, 0])
		var src = Module.ccall("format", "string", null, null)
		postMessage(["ide", "src2", src, d[2]])
	}
	else if (cmd == "error") {
		var s = Module.ccall("error", "string", null, null)
		postMessage(["ide", "error", s])
	}
	else if (cmd == "done") {
		cancelTimer()
	}
}

function errmsg(s) {
	console.log(s)
	postMessage(["ide", "print", s])
}
function input() {
	if (sab == null) {
		errmsg("Error: 'input' needs 'SharedArrayBuffer' in browser\n")
		return
	}
	update()
	postMessage(["ide", "input"])
	var vw = new Int32Array(sab)
	Atomics.wait(vw, 1, 0)
	Atomics.store(vw, 1, 0)
	vw = new Uint16Array(sab)

	if (vw[4] != 0) {
		var s = String.fromCharCode.apply(null, vw.slice(5, vw[4] + 4))
		Module.ccall("evt_func", "null", ["int", "string"], [3, s])
	}
	else {
		Module.ccall("evt_func", "null", ["int", "string"], [4, ""])
	}
}
function sleep(sec) {
	if (sab == null) {
		errmsg("Error: 'sleep' needs 'SharedArrayBuffer' in browser\n")
	}
	update()
	if (sec > 0) {
		postMessage(["sleep", sec])
		var vw = new Int32Array(sab)
		Atomics.wait(vw, 1, 0)
		Atomics.store(vw, 1, 0)
	}
}

function step() {
	update()
	postMessage(["ide", "step"])
	var vw = new Int32Array(sab)
	Atomics.wait(vw, 0, 0)
	Atomics.store(vw, 0, 0)
	Module.ccall("evt_func", "null", ["int"], [5 + vw[2]])
}

