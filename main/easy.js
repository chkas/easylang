const WORKER = "easyw.js"
/*	easy.js

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

window["kaRun"] = kaRun
window["kaFormat"] = kaFormat
window["kaTab"] = kaTab
window["kaStop"] = kaStop
window["kaRunning"] = kaRunning
window["easykey"] = easykey
window["easyrun"] = easyrun
window["easyrunxr"] = easyrunxr
window["easyinit"] = easyinit
window["easyinp"] = easyinp
window["easystop"] = easystop
window["outp"] = outp

var eProg = []
var initState = 0
var eCan = null
var eOut = null
var eFunc = null
var isRunning = false

function kaRunning() {
	return isRunning
}
function easystop() {
	if (isRunning) kaStop()
}

function setCanv(ca) {
	eCan = ca
	if (!ca) return
	eCan.on = false
	if (eCan.width == 300 && eCan.height == 150) {
		eCan.width = 800
		eCan.height = 800
	}
}

function easyrun(prog, ca = null, out = null, caret = -1) {
	eProg.push([prog, ca, out, caret])
	if (initState == 0) {
		easyinit(eProg[0][1])
	}
	if (initState < 2) return;
	else tryrun()
}
function tryrun() {
	if (isRunning) return
	if (eProg.length != 0) {
		var h = eProg.shift()
		setCanv(h[1])
		if (h[1]) canvInit()
		eOut = h[2]
		if (eOut) eOut.value = ""
		isRunning = true
		worker.postMessage(["runx", h[0], 2, h[3]])
	}
}
function easyrunxr() {
	worker.postMessage(["runxr"])
}

function msgFunc(msg, d = null) {
	if (eFunc) eFunc(msg, d)
}

function canvInit() {
	canvSetOff()
	c = eCan.getContext("2d")
	eCan["xctx"] = c
	textsize(8)
	linewidth(1)
	c.backImg = null
	c.backColor = null
	c.setTransform(1,0,0,1,0,0)
	c.translate(0.04, 0.04)
	c.scale(8, 8)
	c.globalCompositeOperation = "source-over"
}
function kaRun(s, opt = 0, pos = -1) {
	eCan = canv0
	eOut = out0
	if (eCan) canvInit()
	isRunning = true
	worker.postMessage(["run", s, opt, pos])
}
function kaTab(s) {
	worker.postMessage(["tab", s])
}
function kaFormat(s, id = null) {
	if (id == null) {
		worker.postMessage(["format", s])
	}
	else {
		if (worker) worker.postMessage(["formatID", s, id ])
	}
}

var pingT

function stopSleep() {
	if (sleepTimer) {
		clearTimeout(sleepTimer)
		sleepTimer = null
	}
}
function stopAll() {
	audStop()
	stopSleep()
}
function kaStop() {
	stopAll()
	if (eCan && eCan.on) {
		worker.postMessage(["stop_ping"])
		canvSetOff()
		pingT = setTimeout(function() {
			pingT = null
			console.log("stop timeout")
			worker.terminate()
			startWorker()
		}, 300)
	}
	else {
		worker.terminate()
		startWorker()
	}
}

var c = null

function canvSetOff() {
	if (eCan && eCan.on) {
		eCan.on = false

		eCan.removeEventListener("mousedown", canvMouseDown)
		eCan.removeEventListener("mouseup", canvMouseUp)
		eCan.removeEventListener("mousemove", canvMouseMove)
		eCan.removeEventListener("mouseout", canvMouseOut)

		eCan.removeEventListener("touchstart", canvTouchStart)
		eCan.removeEventListener("touchend", canvTouchEnd)
		eCan.removeEventListener("touchmove", canvTouchMove1)
		eCan.removeEventListener("touchmove", canvTouchMove2)

		eCan.removeEventListener("keydown", canvKeydown)
		eCan.removeEventListener("keyup", canvKeyup)
		eCan.removeAttribute("tabIndex");
		if (eCan.aniFrame) {
			cancelAnimationFrame(eCan.aniFrame)
			eCan.aniFrame = null
		}
		eCan.style.cursor = "default"
		worker.postMessage(["done"])
	}
}
function circ(x, y, w) {
	c.beginPath()
	c.arc(x, y, w, 0, 2 * Math.PI)
	c.fill()
}
function line(x0, y0, x, y) {
	c.beginPath()
	c.moveTo(x0, y0)
	c.lineTo(x, y)
	c.stroke()
	circ(x0, y0, c.lineWidth / 2)
	circ(x, y, c.lineWidth / 2)
}
function color(r, g, b) {
	var col = "rgb(" + r + "," + g + "," + b + ")"
	c.fillStyle = col
	c.strokeStyle = col
}
function textsize(sz) {
//	c.font = sz + "px Courier New"
	c.font = sz + "px monospace"
}
function linewidth(w) {
	c.lineWidth = w
}
function curve(l) {
	if (l.length < 2) return
	var x = l[0][0]
	var y = l[0][1]
	circ(x, y, c.lineWidth / 2)
	c.beginPath()
	c.moveTo(x, y)
	var x1 = l[1][0]
	var y1 = l[1][1]
	var xn
	var yn
	if (l.length == 2) {
		c.lineTo(x1, y1)
		xn = x1
		yn = y1
	}
	else {
		var x2 = l[2][0]
		var y2 = l[2][1]
		if (l.length == 3) {
			c.quadraticCurveTo(x1, y1, x2, y2);
			xn = x2
			yn = y2
		}
		else {
			xn = l[3][0]
			yn = l[3][1]
			c.bezierCurveTo(x1, y1, x2, y2, xn, yn);
		}
	}
	c.stroke()
	circ(xn, yn, c.lineWidth / 2)
}
function polyg(l) {
	if (l.length < 2) return
	c.beginPath()
	var y = l[0][1]
	c.moveTo(l[0][0], y)
	for (var i = 1; i < l.length; i++) {
		y = l[i][1]
		c.lineTo(l[i][0], y)
	}
	c.fill()
}
function sys(n) {
	if (n == 2) {
		// set image background
		c.globalCompositeOperation = "source-over"
		c.save()
		c.setTransform(1,0,0,1,0,0)
		c.backImg = c.getImageData(0, 0, 800, 800)
		c.backColor = null
		c.restore()
	}
	else if (n == 3) {
		// color -1
		var col = window.getComputedStyle(eCan, null).color
		c.fillStyle = col
		c.strokeStyle = col
	}
	else if (n == 4) {
		// color -2
		var nd = eCan
		while (true) {
			var h = window.getComputedStyle(nd, null).backgroundColor
			if (h.startsWith("rgb(")) break
			nd = nd.parentNode
			if (nd == null) {
				h = "rgb(0,0,0)"
				break
			}
		}
		c.fillStyle = h
		c.strokeStyle = h
	}
	else if (n == 5) {
		// background -2
		c.backColor = "black";
		c.backImg = null
		sys(11)
		c.globalCompositeOperation = "lighter";
	}
	else if (n == 11) {
		// clear
		c.save()
		c.setTransform(1,0,0,1,0,0)
		if (c.backImg) c.putImageData(c.backImg, 0, 0)
		else if (c.backColor) {
			c.fillStyle = c.backColor
			c.fillRect(0, 0, 800, 800)
		}
		else c.clearRect(0, 0, 800, 800)
		c.restore()
	}
	else if (n == 12) {
		// drawgrid
		var lw = c.lineWidth
		var ss = c.strokeStyle
		c.lineWidth = 0.1
		c.beginPath()
		var i
		for (i = 1; i < 10; i++) {
			c.moveTo(0, 10 * i)
			c.lineTo(100, 10 * i)
			c.moveTo(10 * i, 0)
			c.lineTo(10 * i, 100)
		}
		c.strokeStyle = "#888"
		c.stroke()
		c.lineWidth = lw
		c.strokeStyle = ss
	}
	else {
		console.log("** sys " + n + " not handled")
	}
}

function grafCommand(d) {
	var h
	switch (d[0]) {
	case 2:
		line(d[1], d[2], d[3], d[4])
		break
	case 3:
		circ(d[1], d[2], d[3])
		break
	case 4:
		c.fillRect(d[1], d[2], d[3], d[4])
		break
	case 5:
		polyg(d[1])
		break
	case 6:
		c.fillText(d[3], d[1], d[2])
		break
	case 7:
		sys(d[1])
		break
	case 8:
		linewidth(d[1])
		break
	case 9:
		color(d[1], d[2], d[3])
		break
	case 10:
		textsize(d[1])
		break
	case 11:
		if (eCan.on) {
			if (d[1] < cursors.length) eCan.style.cursor = cursors[d[1]]
		}
		break
	case 12:
		curve(d[1])
		break
	case 13:
		c.translate(d[1], d[2])
		break
	case 14:
		c.rotate(d[1])
		break
	case 15:
		c.globalCompositeOperation = "source-over"
		c.backColor = "rgb(" + d[1] + "," + d[2] + "," + d[3] + ")";
		c.backImg = null
		// clear
		sys(11)
		break
	case 16:
		// circseg
		c.beginPath()
		c.arc(d[1], d[2], d[3], d[4] * Math.PI / 180, d[5] * Math.PI / 180)
		c.fill()
		break
	case 17:
		c.scale(d[1], d[1])
		break
	}
}

var cursors = [ "default", "crosshair", "pointer" ]

function grafList(cmds) {
	for (var i = 0; i < cmds.length; i++) {
		grafCommand(cmds[i])
	}
}

var aud = null
var sound_vals

function audStop() {
	if (aud) {
		aud.close()
		if (aud.timer) clearTimeout(aud.timer)
		aud = null
	}
}

function soundNext() {
	var h = sound_vals.shift()
	var msec = h[1] * 1000
	aud.osc.frequency.setValueAtTime(h[0], aud.currentTime)
	aud.gain.gain.setTargetAtTime(1, aud.currentTime, 0.01)
	aud.timer = setTimeout(soundDone, msec)
}

function soundDone() {
	aud.gain.gain.setTargetAtTime(0, aud.currentTime, 0.02)
	if (sound_vals.length != 0) {
		aud.timer = setTimeout(soundNext, 150)
	}
}

function initAudio() {
	var AudioContext = window.AudioContext || window.webkitAudioContext
	aud = new AudioContext()
	aud.osc = aud.createOscillator()
	aud.gain = aud.createGain()
	aud.gain.gain.setValueAtTime(0, aud.currentTime)
	aud.osc.connect(aud.gain)
	aud.gain.connect(aud.destination)
	aud.osc.start()
}

function sound(vals) {
	if (!aud) initAudio();
	if (aud.timer) {
		clearTimeout(aud.timer)
		aud.timer = null
		aud.gain.gain.setTargetAtTime(0, aud.currentTime, 0.02)
	}
	sound_vals = vals
	if (sound_vals.length != 0) soundNext()
}

var isMouseDown = false

function workerStarted() {
	window["sab"] = null
	if (typeof SharedArrayBuffer == "function") {
		window["sab"] = new SharedArrayBuffer(112)
	}
	else {
		console.log("Warning: SharedArrayBuffer not available")
	}
	worker.postMessage(["init", window["sab"], navigator.language.substring(0, 2)])

	if (initState == 1) loadInfo(null)
	initState = 2
	isRunning = false
	tryrun()
	msgFunc("ready")
}

var nlsaved
function outp(s) {
	if (eOut) {
		if (nlsaved) {
			s = "\n" + s
			nlsaved = false
		}
		var l = s.length - 1
		if (s[l] == "\n") {
			s = s.substr(0, l)
			nlsaved = true
		}
		var so = eOut.value
		if (so.length > 60000) so = so.substr(1000)
		eOut.value = so + s
		eOut.scrollTop = eOut.scrollHeight
	}
	else {
		console.log(s)
	}
}

function actAudio() {

	if (!aud) initAudio()
	else {
		aud.resume()
		if (aud.state == "running") {
			eCan.removeEventListener("mousedown", actAudio)
			eCan.removeEventListener("touchstart", actAudio)
			eCan.removeEventListener("touchend", actAudio)
		}
	}
}

//--------------------------------------

var evts

function canvMouseDown(e) {
	var r = eCan.getBoundingClientRect()
	isMouseDown = true
	var sc = eCan.width / r.width / 8
	evtdo([ "mouse", 0, (e.clientX - r.left) * sc, (e.clientY - r.top) * sc ])
	eCan.focus()
	e.preventDefault()
}
function canvMouseOut(e) {
	if (isMouseDown) {
		e.clientX = 0
		e.clientY = 0
		canvMouseUp(e)
	}
}
function canvTouchStart(e) {
	lastTouch = e.touches[0]
	e.clientX = lastTouch.clientX
	e.clientY = lastTouch.clientY
	canvMouseDown(e)
}

function canvTouchEnd(e) {
	e.clientX = lastTouch.clientX
	e.clientY = lastTouch.clientY
	canvMouseUp(e)
}

function canvTouchMove1(e) {
	lastTouch = e.touches[0]
}
function canvTouchMove2(e) {
	lastTouch = e.touches[0]
	e.clientX = lastTouch.clientX
	e.clientY = lastTouch.clientY
	canvMouseMove(e)
}

function canvMouseUp(e) {
	var r = eCan.getBoundingClientRect()
	isMouseDown = false
	var sc = eCan.width / r.width / 8
	var x = (e.clientX - r.left) * sc
	var y = (e.clientY - r.top) * sc
	evtdo(["mouse", 1, x, y ])
	e.preventDefault()
}
function canvMouseMove(e) {
	var r = eCan.getBoundingClientRect()
	var sc = eCan.width / r.width / 8
	var x = (e.clientX - r.left) * sc
	var y = (e.clientY - r.top) * sc
	evtdo(["mouse", 2, x, y ])
	e.preventDefault()
}

// ------------------------------------------

var lastTouch
var sleepTimer

function workerMessage(event) {
	var d = event.data
	var cmd = d[0]
	switch (cmd) {
	case "list":
		grafList(d[1])
		break
	case "print":
		outp(d[1])
		break
	case "sleep":
		if (d[1] > 0)
			sleepTimer = setTimeout(function() {
				sleepTimer = null
				waitDone(["sleep"])
			}, d[1] * 1000);
		lookEvents()
		break
	case "ide":
		d.shift()
		var msg = d.shift()
		if (msg == "src_err") isRunning = false
		msgFunc(msg, d)
		break
	case "stderr":
		console.log(d[1])
		break
	case "started":
		console.log("started")
		workerStarted()
		break
	case "done":
		isRunning = false
		canvSetOff()
		msgFunc("stopped")
		tryrun()
		break
	case "events":
		if (evts) for (msg of evts) worker.postMessage(msg)
		evts = null
		break
	case "stop_pong":
		clearTimeout(pingT)
		pingT = null
		isRunning = false
		msgFunc("stopped")
		tryrun()
		break
	case "sound":
		sound(d[1])
		break
	case "init":
		nlsaved = false
		if ((d[1] & 128) == 0) break
		if (!eCan) {
			console.log("error: no canvas")
			worker.terminate()
			msgFunc("info", [0])
			startWorker()
			return
		}
		// set default color
		sys(3)
		if (d[1] & 127) {
			eCan.on = true
			msgFunc("canvon")
			evts = []
			waitEvent = false
			eCan.focus()
			if (d[1] & 1) {
				eCan.addEventListener("mousedown", canvMouseDown)
				eCan.addEventListener("touchstart", canvTouchStart)
			}
			if (d[1] & 2) {
				eCan.addEventListener("mouseup", canvMouseUp)
				eCan.addEventListener("touchend", canvTouchEnd)
				eCan.addEventListener("mouseout", canvMouseOut)
				if ((d[1] & 4) == 0) {
					eCan.addEventListener("touchmove", canvTouchMove1)
				}
			}
			if (d[1] & 4) {
				eCan.addEventListener("mousemove", canvMouseMove)
				eCan.addEventListener("touchmove", canvTouchMove2)
			}
			if (d[1] & 8) {
				eCan.addEventListener("keydown", canvKeydown)
				eCan.tabIndex = 0
				// if (!"ontouchstart" in document)
				eCan.focus()
			}
			if (d[1] & 16) {
				eCan.addEventListener("keyup", canvKeyup)
			}
			if (d[1] & 32) {
				if (!eCan.aniFrame) {
					eCan.aniFrame = requestAnimationFrame(animate)
				}
			}
		}
		if (d[1] & 256) {
			eCan.addEventListener("mousedown", actAudio)
			eCan.addEventListener("touchstart", actAudio)
			eCan.addEventListener("touchend", actAudio)
		}
		break
	case "exit":
		canvSetOff()
		stopAll()
		worker.terminate()
		msgFunc("info", [0])
		startWorker()
		break
	case "error":
		isRunning = false
		msgFunc("error")
		break
	default:
		console.log("internal error: 1, " + d);
	}
}

function startWorker() {
	worker = new Worker(WORKER)
	worker.onmessage = workerMessage
}

var timePrev = 0
function animate(t) {
	if (t - timePrev > 12) {
		evtdo(["animate"])
		timePrev = t
	}
	eCan.aniFrame = requestAnimationFrame(animate)
}

function canvKeydown(e) {
	evtdo(["key", 2, e.key])
	e.preventDefault()
}
function canvKeyup(e) {
	evtdo(["key", 3, e.key])
	e.preventDefault()
}
var waitEvent
function waitDone(msg) {
	waitEvent = false
	var vw = new Uint16Array(window["sab"])

	var evt
	if (msg[0] == "mouse") {
		evt = msg[1]
	}
	//else if (msg[0] == "animate") {
	//	evt = 5
	//}
	else if (msg[0] == "key") {
		evt = msg[1] + 1
	}
	else evt = 6

	vw[4] = evt
	if (evt <= 2) {
		vw[5] = msg[2] * 600
		vw[6] = msg[3] * 600
	}
	else if (evt <= 4) {
		var a = msg[2]
		vw[5] = a.length + 1
		for (var i = 0; i < a.length; i++) {
			vw[i + 6] = a.charCodeAt(i)
		}
	}
	stopSleep()
	sabNotify(1, 1)
}
function lookEvents() {
	if (!evts) return
	waitEvent = true
	if (evts.length) {
		waitDone(evts.shift())
	}
}
function evtdo(msg) {
	if (!evts) worker.postMessage(msg)
	else if (msg[0] != "animate") {
		if (waitEvent) waitDone(msg)
		else evts.push(msg)
	}
}

var worker = null
var canv0 = null
var out0 = null

function loadInfo(s) {
	if (eOut) {
		if (s) outp(s + "\n")
		else eOut.value = ""
	}
	else if (eCan) {
		if (s) {
			canvInit()
			c.fillText(s, 10, 10)
		}
		else if (c) sys(11)
	}
}

function easyinit(ca, out = null, msg_func = null) {
	out0 = out
	eOut = out
	eFunc = msg_func
	canv0 = ca
	setCanv(ca)
	if (typeof WebAssembly != "object") {
		loadInfo("no wasm support")
		msgFunc("nowasm")
	}
	else {
		startWorker()
		setTimeout(function() {
			if (initState == 1) loadInfo("Loading ...")
		}, 1000);
	}
	initState = 1
}

function easykey(s) {
	worker.postMessage(["key", 2, s])
}

function sabNotify(a, b) {
	var vw = new Int32Array(window["sab"])
	Atomics.store(vw, a, b)
	Atomics.notify(vw, a)
}

function easyinp(s) {
	var vw = new Uint16Array(window["sab"])
	if (s) {
		vw[4] = s.length + 1
		for (var i = 0; i < s.length; i++) {
			vw[i + 5] = s.charCodeAt(i)
		}
	}
	else {
		vw[4] = 0
	}
	sabNotify(1, 1)
}

if (window["easyscript"]) {
	var ca = window["easycanv"]
	if (!ca) ca = document.querySelector("canvas")
	easyrun(window["easyscript"], ca)
}

