/*	easy_ide.js

	Copyright (c) Christof Kaser christof.kaser@gmail.com.
	All rights reserved.

	This work is licensed under the terms of the GNU General Public
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function
    sysfunc "creator" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/
function eid(id) { return document.getElementById(id) }

var infostr = `Easylang IDE tips:
 • TAB key completes your input
 • Shift+Enter to run program
`

var hambtn = eid("hambtn")
var hamcnt = eid("hamcnt")
var runBtn = eid("runBtn")
var stBtn = eid("stBtn")
var btns = eid("btns")
var tabs = eid("tabs")
var tab1 = eid("tab1")
var tab2 = eid("tab2")
var tab3 = eid("tab3")
var dbgSel = eid("dbgSel")
var dbgcls = eid("dbgcls")
var inp = eid("inp")
var tut = eid("tut")
var incol = eid("incol")
var outcol = eid("outcol")
var dragb = eid("dragb")
var dragb2 = eid("dragb2")
var canv = eid("canv")
var out = eid("out")
var col1 = eid("col1")
var docx = eid("docx")
var labinp = eid("labinp")
var input = eid("input")
var container = eid("container")
var storage = eid("storage")
var tutchng = eid("tutchng")
var tutchng2 = eid("tutchng2")
var tutinf = eid("tutinf")
var expnd = eid("expnd")
var dbgBtn = eid("dbgBtn")
var dbgSpn = eid("dbgSpn")
var trSpn = eid("trSpn")
var dbg = eid("dbg")
var stepBtn = eid("stepBtn")
var step2Btn = eid("step2Btn")
var step3Btn = eid("step3Btn")
var urlBtn = eid("urlBtn")
var url2Btn = eid("url2Btn")
var url3Btn = eid("url3Btn")
var strictBtn = eid("strictBtn")
var themeBtn = eid("themeBtn")
var fontp = eid("fontp")
var fontm = eid("fontm")
var chngTheme = window["chngTheme"]

var txt_header = window["txt_header"]
var txt_tutor_id = window["txt_tutor_id"]
var txt_locale_id = window["txt_locale_id"]
var tut_descr = window["tut_descr"]
var tut_file = window["tut_file"]
window["txt_tutor"] = ""
window["txt_locale"] = ""

var pres
var txt_tutor
var txt_locale

function append(cnt, e) { cnt.appendChild(document.createElement(e)) }
function appendTxt(cnt, s) { cnt.appendChild(document.createTextNode(s)) }
function create(s) { return document.createElement(s) }
function removeChilds(e) { while (e.firstChild) e.removeChild(e.firstChild) }

function show(e) { e.style.display = "" }
function hide(e) { e.style.display = "none" }
function isVisible(e) { return e.style.display == "" }

async function compr(txt) {
	var enc = new TextEncoder()
	var buffer = await new Response(new Response(enc.encode(txt)).body.pipeThrough(new CompressionStream('deflate-raw'))).arrayBuffer()
	var s = ""
	var bytes = new Uint8Array(buffer)
	for (var i = 0; i < bytes.byteLength; i++) {
		s += String.fromCharCode(bytes[i])
	}
	return btoa(s)
}
async function decompr(txt) {
	var s = atob(txt)
	var buf = new ArrayBuffer(s.length)
	var bytes = new Uint8Array(buf)
	for (var i = 0; i < s.length; i++) {
		bytes[i] = s.charCodeAt(i)
	}
	var stream = new Response(buf).body.pipeThrough(new DecompressionStream('deflate-raw'))
	var h = await new Response(stream).arrayBuffer()
	var dec = new TextDecoder("utf8")
	return dec.decode(h)
}

themeBtn.onclick = function() {
	chngTheme()
	inp.focus()
	hide(hamcnt)
}
fontp.onclick = function() {
	var s = Number(inp.style.fontSize.slice(0, -2))
	if (s < 24) s += 1
	inp.style.fontSize = "" + s + "px"
	out.style.fontSize = "" + (s - 1) + "px"
}
fontm.onclick = function() {
	var s = Number(inp.style.fontSize.slice(0, -2))
	if (s > 6) s -= 1
	inp.style.fontSize = "" + s + "px"
	out.style.fontSize = "" + (s - 1) + "px"
}
hambtn.onclick = function() {
	if (isVisible(hamcnt)) hide(hamcnt)
	else show(hamcnt)
}
document.addEventListener("click", function(event) {
  if (event.target !== hambtn && !hambtn.contains(event.target)) {
    hide(hamcnt)
  }
})

dbgBtn.onclick = function() {
	dbgShow(!isVisible(dbgSpn))
	hide(hamcnt)
}
dbgcls.onclick = function() {
	dbgShow(false)
}
function showurl(t) {
	out.value = t
	hide(hamcnt)
	kaStop()
	prepOut(4)
	show_qr(t)
}
urlBtn.onclick = async function() {
	var h = await compr(inp.textContent)
	var t = location.origin + "/ide/#cod=" + h
	showurl(t)
}
url2Btn.onclick = async function() {
	var h = await compr(inp.textContent)
	var t = location.origin + "/run/#cod=" + h
	showurl(t)
}
url3Btn.onclick = async function() {
	var h = await compr(inp.textContent)
	var t = "mailto:your@mailaddr?subject=Your%20code&body=" + location.origin + "/ide/#cod=" + h
	showurl(t)
}

var strictMode

function strictSet() {
	if (strictMode) {
		strictBtn.textContent = "Strict mode ✓"
		window.localStorage["xstrict"] = "true"
	}
	else {
		strictBtn.textContent = "Strict mode"
		window.localStorage["xstrict"] = "false"
	}
}
strictBtn.onclick = function() {
	strictMode = !strictMode
	strictSet()
}

show(container)

function tutUpd() {
	var fr = document.createDocumentFragment()
	if (!txt_tutor) return
	var lang = navigator.language.substring(0, 2)
	if (txt_locale.indexOf(lang) == -1) lang = ""
	lang += " "
	pres = []
	var smpls = txt_tutor.split("\n\n")
	if (smpls[0].charAt(0) === "\n") smpls[0] = smpls[0].slice(1)
	var k = lang.length + 1
	for (var i = 0; i < smpls.length; i++) {
		var s = smpls[i]
		if (s.startsWith("*")) {
			if (s.startsWith("*" + lang)) {
				var b = create("h3")
				appendTxt(b, s.substring(k))
				fr.appendChild(b)
			}
		}
		else if (s.startsWith("+")) {
			if (s.startsWith("+" + lang)) {
				var b = create("p")
				var s0 = s.substring(k)
				var sn = ""
				var st = true
				for (var h = 0; h < s0.length; h++) {
					var c = s0[h]
					if (c == "*") {
						if (s0[h + 1] == "*") {
							sn += c
							h++
						}
						else {
							if (st) sn += "<tt translate=no>"
							else sn += "</tt>"
							st = !st
						}
					}
					else if (c == "<") sn += "&lt;"
					else sn += c
				}
				b.innerHTML = sn
				fr.appendChild(b)
			}
		}
		else if (s.startsWith("@")) {
			if (s.startsWith("@" + lang)) {
				var ar = s.substring(k).split("@")
				var lnk = create("a")
				lnk.href = ar[0]
				lnk.target = "_blank"
				appendTxt(lnk, ar[1])
				fr.appendChild(lnk)
			}
		}
		else if (s == "-") append(fr,"hr")
		else if (s.startsWith("##")) {
			var ca = create("canvas")
			ca.tabindex = 0
			ca.style.width = "260px"
			ca.style.height = "260px"
			ca.style.marginBottom = "12px"
			if (s[2] != "\n") {
				var h = Number(s.substring(2, 4))
				ca.width = 800
				ca.height = 8 * h
				ca.style.height = h * 2.6 + "px"
			}
			fr.appendChild(ca)
			easyrun(s.substring(s.indexOf("\n") + 1), ca)
		}
		else {
			var pre = create("pre")
			pre.setAttribute("translate", "no")
			pre.innerHTML = s
			if (runBtn) {
				kaFormat(s, pres.push(pre) - 1)
				var btn = create("button")
				btn.className = "tut"
				btn.textContent = "Load"
				btn.pre = pre
				btn.onclick = function() {
					loadClick(this, true)
				}
				fr.appendChild(btn)
			}
			fr.appendChild(pre)
		}
	}
	txt_tutor = null
	tut.appendChild(fr)
}

function runCode(code, caret) {
	dbg.value = ""
	tailSrc = null
	stepBtn.disabled = true
	showRun(false)
	var opt = 256 + 2
	if (strictMode) opt += 16
	if (canv.width != 800) {
		canv.width = 800
		canv.height = 800
		canvInit();
	}
	kaRun(code, opt, caret)
}

var codeToRun
var todoLnk
var todoEnter
var todoPop

function tryRunCode() {
	if (todoEnter) {
		enter()
		todoEnter = false
	}
	else if (codeToRun) {
		runCode(codeToRun, 0)
		codeToRun = null
	}
	else if (todoLnk) {
		showTut(todoLnk)
		history.pushState(tutf, "", location.href)
		todoLnk = null
	}
	else if (todoPop) {
		if (todoPop.state) showTut(todoPop.state)
		else doTutChng()
		todoPop = null
	}
}

var loadBtn

function loadClick(btn, istut) {
	if (!initDone) return
	if (loadBtn) {
		loadBtn.textContent = "Load"
		clearTimeout(loadBtn.timeout)
	}
	if (stBtn.disabled || loadBtn == btn) {
		removeCnd()
		stBtn.disabled = true
		loadBtn = null
		var code
		if (istut) code = btn.pre.textContent
		else code = window.localStorage[btn.ref]

		if (doco || !istut && doce) onTab(3)

		if (runBtn.run) runCode(code, 0)
		else {
			codeToRun = code
			doStop()
		}
		return
	}
	loadBtn = btn
	btn.textContent = "Overwrite?"
	btn.timeout = setTimeout(function() {
		loadBtn.textContent = "Load"
		loadBtn = null
	}, 3000)
}

var delBtn

function delClick(btn) {
	if (delBtn) {
		delBtn.textContent = "Delete"
		clearTimeout(delBtn.timeout)
	}
	if (delBtn == btn) {
		window.localStorage.removeItem(btn.ref)
		var scrl = tut.scrollTop
		storeUpd()
		tut.scrollTop = scrl
		delBtn = null
		return
	}
	delBtn = btn
	btn.textContent = "Really?"
	btn.timeout = setTimeout(function() {
		delBtn.textContent = "Delete"
		delBtn = null
	}, 3000)
}

function expandClick(btn) {
	if (btn.textContent == "Expand") {
		btn.preview = btn.pre.textContent
		btn.pre.textContent = window.localStorage[btn.ref]
		btn.textContent = "Collapse"
		show(btn.nextSibling)
	}
	else {
		btn.pre.textContent = btn.preview
		btn.textContent = "Expand"
		hide(btn.nextSibling)
		btn.nextSibling.textContent = "Copy"
	}
}
function copyClick(btn) {
	navigator.clipboard.writeText(window.localStorage[btn.ref])
	btn.textContent = "Copied"
}
function storeUpd() {
	var fr = document.createDocumentFragment()
	removeChilds(storage)
	var ar = Object.keys(window.localStorage || {})
	ar.sort()
	for (var i = ar.length - 1; i >= 0; i--) {
		var k = ar[i]
		if (k[0] != "k") continue
		var st = window.localStorage[k]
		var ind = st.indexOf("\n")
		if (ind == -1) ind = st.length
		else {
			var i2 = st.indexOf("\n", ind + 1)
			if (i2 != -1) ind = i2
		}
		var pre = create("pre")
		pre.setAttribute("translate", "no")
		appendTxt(pre, st.substring(0, ind))

		var btn
		if (runBtn) {
			btn = create("button")
			btn.className = "tut"
			btn.textContent = "Load"
			btn.ref = k

			btn.onclick = function() {
				loadClick(this, false)
			}
			fr.appendChild(btn)
		}
		btn = create("button")
		btn.className = "del"
		btn.textContent = "Delete"
		btn.ref = k

		btn.onclick = function() {
			delClick(this)
		}
		fr.appendChild(btn)

		btn = create("button")
		btn.className = "del"
		btn.textContent = "Expand"
		btn.ref = k
		btn.pre = pre
		btn.onclick = function() {
			expandClick(this)
		}
		fr.appendChild(btn)

		btn = create("button")
		hide(btn)
		btn.className = "del"
		btn.textContent = "Copy"
		btn.ref = k
		btn.onclick = function() {
			copyClick(this)
		}
		fr.appendChild(btn)

		fr.appendChild(pre)
	}
	storage.appendChild(fr)
}

var tutf = null

function showTut(f) {
	removeChilds(tut)
	var script = create("script")
	script.onload = function () {
		txt_tutor = window["txt_tutor"]
		txt_locale = window["txt_locale"]
		show(tutchng)
		show(tutchng2)
		hide(tutinf)
		removeChilds(tut)
		onTab(1)
	}
	window["txt_locale"] = ""
	script.src = f
	document.head.appendChild(script)
	tutf = f
}

window.onpopstate = function(evt) {
	if (!runBtn.run) {
		doStop()
		todoPop = evt
		return
	}
	if (evt.state) showTut(evt.state)
	else doTutChng()
}

function onTutChng() {
	history.back()
}

function lnClick(lnk) {
	if (!initDone) return
	if (!runBtn.run) {
		todoLnk = lnk.file
		doStop()
		return
	}
	showTut(lnk.file)
	history.pushState(tutf, "", location.href)
}

function doTutChng() {
	docx.scrollTop = 0
	hide(tutchng)
	hide(tutchng2)
	show(tutinf)
	removeChilds(tut)
	tut.innerHTML = txt_header
	var lnk
	for (var i = 0; i < tut_descr.length; i++) {
		var p = create("p")
		lnk = create("div")
		lnk.setAttribute("class", "lnk")
		lnk.file = tut_file[i]
		lnk.onclick = function() {
			lnClick(this)
		}
		appendTxt(lnk, tut_descr[i])
		p.appendChild(lnk)
		tut.appendChild(p)
	}
	txt_locale = txt_locale_id
	txt_tutor = txt_tutor_id
	tutUpd()
	tutf = null
}

docx.posTut = 0
docx.posSt = 0
docx.tab = 1

function onTab(on) {
	var off = docx.tab
	if (!on) on = 1
	docx.tab = on
	eid("tab" + off).disabled = false
	eid("tab" + on).disabled = true
	eid("tab" + off).style.zIndex = 4 - off
	eid("tab" + on).style.zIndex = 10

	if (off == 1) docx.posTut = docx.scrollTop
	else if (off == 2) docx.posSt = docx.scrollTop
	else if (off == 3 && doce) col1.removeChild(doce)

	if (on == 3 && off <= 2) col1.removeChild(docx)

	if (on == 3) {
		col1.appendChild(doce)
	}
	else {
		if (off == 3) col1.appendChild(docx)
		hide(docx.children[2 - on])
		if (on == 1) {
			tutUpd()
			show(docx.children[0])
			docx.scrollTop = docx.posTut
		}
		else {
			storeUpd()
			show(docx.children[1])
			docx.scrollTop = docx.posSt
		}
		docx.tabdoc = on
		docx.focus()
	}
}

var doce = null
var doco = null

function expandEdit() {
	if (docx.tab > 2) onTab(docx.tabdoc)

	incol.insertBefore(btns, inp)

	container.insertBefore(incol, outcol)
	doce = null
	hide(tab3)
	show(dragb)
	show(tut)
	hide(expnd)
	col1.style.width = "200px"
	incol.style.width = "300px"
	outcol.style.width = "200px"
	resize3()
}
function expandOut() {
	hideOutm()
	onTab(3)
	container.appendChild(outcol)
	doco = null
	show(dragb2)
	col1.style.width = "200px"
	outcol.style.width = "200px"
	hamcnt.style.right = ""
	show(dbgBtn)
	show(out)
	resize2()
}

function collapseEdit() {
	container.removeChild(incol)
	incol.style.width = "100%"
	doce = create("div")
	doce.style.height = "100%"
	tabs.insertBefore(btns, dragb)
	doce.appendChild(incol)
	show(tab3)
	hide(dragb)
	onTab(3)
	resize2()
}
function resizeOutm() {
	var w = incol.offsetWidth
	if (isVisible(out)) w += 60
	doco.style.height = w + "px"
	inp.style.height = "calc(100% - " + (w + 36) + "px)"
}
function hideOutm() {
	inp.style.height = "100%"
	hide(doco)
}
function showOutm() {
	tab3.disabled = false
	show(doco)
}

function collapseOut() {
	container.removeChild(outcol)
	outcol.style.width = "100%"
	doco = create("div")
	doco.appendChild(outcol)
	incol.appendChild(doco)
	hide(dragb2)
	hide(expnd)
	col1.style.width = "100%"
	hamcnt.style.right = "10px"
	hide(dbgBtn)

	if (!runBtn.run) {
		if (isVisible(canv)) {
			hide(out)
			resizeOutm()
		}
		showOutm()
	}
	onTab(3)
}

function resize2() {
	var w = container.offsetWidth
	var dw = col1.offsetWidth
	var ow = outcol.offsetWidth

	dw = dw * w / (ow + dw + 5)
	if (dw > w * 3 / 4) dw = w * 3 / 4;
	if (dw < 320) dw = 320;
	dw = Math.round(dw)
	ow = w - dw - 6

	var h = outcol.offsetHeight - 56
	if (ow > h) {
		dw += ow - h
		ow = h
	}
	col1.style.width = dw + "px"
	outcol.style.width = ow + "px"
}

function resize3() {
	var w = container.offsetWidth
	var iw = incol.offsetWidth
	var ow = outcol.offsetWidth
	var dw = col1.offsetWidth
	var f = w / (iw + ow + dw + 11)

	dw *= f
	iw *= f
	ow *= f
	if (dw < 200) {
		ow -= (200 - dw) / 2
		dw = 200
	}
	if (iw < 200) {
		dw -= (200 - iw) / 2
		ow -= (200 - iw) / 2
	}
	if (ow < 120) {
		dw -= (120 - ow) / 2
		ow = 120
	}
	dw = Math.round(dw)
	ow = Math.round(ow)
	iw = w - dw - ow - 12

	var h = outcol.offsetHeight - 56
	if (ow > h) {
		iw += ow - h
		ow = h
	}
	incol.style.width = iw + "px"
	col1.style.width = dw + "px"
	outcol.style.width = ow + "px"
}

function resizeAll() {
	if (!isVisible(container)) return
	var w = container.offsetWidth

	if (!doce && !doco) {
		if (w < 600) {
			collapseEdit()
			hide(expnd)
			if (w < 500) collapseOut()
		}
		else resize3()
	}
	else if (!doco) {
		if (w < 500) collapseOut()
		else if (w > 600 && !isVisible(expnd)) expandEdit()
		else resize2()
	}
	else {
		if (w > 500) {
			expandOut()
			if (w > 600) expandEdit()
		}
		else if (isVisible(outcol) && isVisible(canv)) resizeOutm()
	}
}

window.onresize = resizeAll

var drag = 0
var pageX0, leftW, rightW, colH

function dragexit() {
	window.removeEventListener("mousemove", dragmove)
	window.removeEventListener("mouseup", dragstop)
	dragb.removeEventListener("touchend", dragstop)
	dragb2.removeEventListener("touchend", dragstop)
	dragb.removeEventListener("touchmove", tmove)
	dragb2.removeEventListener("touchmove", tmove)
	drag = 0
}

function dragstop(e) {
	dragexit()
	e.preventDefault()
}

function draginit() {
	dragb.addEventListener("touchmove", tmove)
	dragb2.addEventListener("touchmove", tmove)
	dragb.addEventListener("touchend", dragstop)
	dragb2.addEventListener("touchend", dragstop)
	window.addEventListener("mousemove", dragmove)
	window.addEventListener("mouseup", dragstop)
}

function dragstart(e) {
	draginit()
	pageX0 = e.pageX
	drag = 1
	leftW = col1.offsetWidth
	rightW = incol.offsetWidth
	e.preventDefault()
}

function dragstart2(e) {
	draginit()
	pageX0 = e.pageX
	rightW = outcol.offsetWidth
	colH = outcol.offsetHeight

	if (!doce) {
		drag = 2
		leftW = incol.offsetWidth
	}
	else {
		drag = 3
		leftW = col1.offsetWidth
	}
	e.preventDefault()
}

function dragmove(e) {
	if (drag == 0) return
	var d =  e.pageX - pageX0
	var l = leftW + d
	var r = rightW - d

	if (drag == 1) {
		if (l < 180 && d < 0) {
			collapseEdit()
			show(expnd)
			dragexit()
			return
		}
		if (r < 200 && d > 0) return
		col1.style.width = l + "px"
		incol.style.width = r + "px"
	}
	else {
		if (l < 320 && d < 0) return
		if (r < 110 && d > 0) return
		var h = colH - r - 40
		if (h < 16 && d < 0) return

		if (drag == 2) incol.style.width = l + "px"
		else col1.style.width = l + "px"

		outcol.style.width = r + "px"
	}
}

dragb.addEventListener("mousedown", dragstart)
dragb2.addEventListener("mousedown", dragstart2)

function touch_mode() {
	if (dragb.style.width != "32px") {
		dragb.style.width = "32px"
		dragb2.style.marginRight = "4px"
		dragb2.style.width = "32px"
	}
}

dragb.addEventListener("touchstart", function(e) {
	e.pageX = e.touches[0].pageX
	touch_mode()
	dragstart(e)
})

dragb2.addEventListener("touchstart", function(e) {
	e.pageX = e.touches[0].pageX
	touch_mode()
	dragstart2(e)
})

function tmove(e) {
	e.pageX = e.touches[0].pageX
	dragmove(e)
}
function store() {
	removeCnd()
	var sec = Math.floor(Date.now() / 1000)
	window.localStorage["k" + sec] = inp.textContent
	stBtn.disabled = true
	storeUpd()
	inp.focus()
}

inp.onmousedown = function() {
	removeCnd()
}
var undoStack = []
var undoPos = 0
function undoAdd(t, c = 0) {
	while (undoStack.length - 1 > undoPos) undoStack.pop()
	if (undoStack.length > 9) undoStack.shift()
	undoStack.push([t, c])
	undoPos = undoStack.length
}
var enterTime = 0
function enter() {
	if (Date.now() - enterTime < 300) {
		runx()
		return
	}
	enterTime = Date.now()
	var inps = inp.textContent
	var p = getCaret()
	undoAdd(inps, p)
	if (p != 0 && inps[p - 1] != "\n") {
		while (p < inps.length && inps[p] != "\n") p++
	}
	var s = inps.substring(0, p)
	tailSrc = inps.substring(p)
	if (tailSrc.length == 0) tailSrc = "\n"
	else if ((s.length == 0 || s[s.length - 1] == "\n") && tailSrc[0] != "\n") {
		tailSrc = "\n" + tailSrc
	}
	else if (tailSrc[0] == "\n") {
		var i = 1
		while (tailSrc[i] == " ") i++
		if (tailSrc[i] == "\n") tailSrc = tailSrc.substring(i)
	}
	kaFormat(s)
}
var searchS = ""
function search() {
	if (window.getSelection() != "") searchS = window.getSelection().toString()
	var p = getCaret()
	var s = inp.textContent.substring(p + 1)
	var m = s.search(searchS)
	if (m != -1) m = p + m + 1
	else {
		s = inp.textContent.substring(0, p)
		m = s.search(searchS)
	}
	if (m != -1) {
		scrollToPos(m)
		setCaret(m)
	}
}
function tabu() {
	var inps = inp.textContent
	var p = getCaret()
	var s = inps.substring(0, p)
	tailSrc = " " + inps.substring(p)
	kaTab(s)
}

function issel() {
	return window.getSelection().anchorOffset != window.getSelection().extentOffset
}
inp.onkeydown = function(e) {
	var k = e.keyCode
	if (cnd.tab) {
		if (k == 9 || cnd.tabk == 8 && k == 8) {
			e.preventDefault()
			cnd.tabind = (cnd.tabind + 1) % cnd.tabopts.length
			cnd.firstChild.nodeValue = cnd.tabopts[cnd.tabind]
			return
		}
		if (k == 8) {	// bs
			e.preventDefault()
			cnd.firstChild.nodeValue = cnd.tabopts[cnd.tabopts.length - 1]
		}
		cnd.className = ""
		makeCnd()
		//return
	}
	if (cnd.act) {
		removeCnd()
		if (k == 8) e.preventDefault()
	}
	if (k == 9 || k == 8 && e.shiftKey) {	// tab or shift+bs
		e.preventDefault()
		if (!runBtn.run) {
			doStop()
			return
		}
		cnd.tabk = k
		tabu()
		return
	}
	if (e.ctrlKey || e.metaKey) {
		if (k == 86 || k == 88) {	// v x
			undoAdd(inp.textContent, getCaret())
			stBtn.disabled = false
		}
		else if (k == 82 || k == 13) {	// r enter
			e.preventDefault()
			runx()
		}
		else if (k == 83) {		// s
			e.preventDefault()
			if (!stBtn.disabled) store()
		}
		else if (k == 70) {		// f
			e.preventDefault()
			search()
		}

		else if (k == 90) {		// z undo
			e.preventDefault()
			if (e.shiftKey) {
				undoPos += 1
				if (undoPos >= undoStack.length) undoPos = undoStack.length
				else {
					inp.textContent = undoStack[undoPos][0]
					setCaret(undoStack[undoPos][1], false)
				}
			}
			else {
				if (undoPos == undoStack.length) {
					undoAdd(inp.textContent)
					undoPos -= 1
				}
				undoPos -= 1
				if (undoPos < 0) undoPos = 0
				else {
					inp.textContent = undoStack[undoPos][0]
					setCaret(undoStack[undoPos][1], false)
				}
			}
		}


/*
// Ctrl-M
		else if (k == 76) {
			e.preventDefault()
			test()
		}
*/
		else if (k == 85 || k == 79 || k == 219 || k == 72 		// u o [ h
				|| k == 74 || k == 75 || k == 76 || k == 66) { 	// j k l b
			e.preventDefault()
		}
		return
	}
	if (k == 13) {		// enter
		e.preventDefault()
		if (e.shiftKey) {
			runx()
			return
		}
		if (!runBtn.run) {
			todoEnter = true
			doStop()
			return
		}
		enter()
	}
	// delete space tab
	if (stBtn.disabled) {
		if (k >= 46 || k == 32 || k <= 9 ) {
			stBtn.disabled = false
			undoAdd(inp.textContent)
		}
	}
	if (k == 8 && issel()) undoAdd(inp.textContent)
}

inp.addEventListener("paste", function(e) {
	e.preventDefault()
	var paste = e.clipboardData.getData("text/plain")
	var el = document.createElement('p')
	el.appendChild(document.createTextNode(paste))
	document.execCommand('insertHTML', false, el.innerHTML)
})

inp.addEventListener("drop", function(e) {
	e.preventDefault();
	var file = e.dataTransfer.files[0], reader = new FileReader()
	reader.onload = function(event) {
//		inp.textContent = event.target.result
		var n = event.target.result.charCodeAt(0)
		if (n == 35 || n >= 65 && n <= 90 || n >= 97 && n <= 122) {
			document.execCommand('selectAll', false, null)
			document.execCommand('insertHTML', false, event.target.result)
		}
	}
	reader.readAsText(file)
})

// ------------------

var tailSrc
var cnd
function makeCnd() {
	cnd = create("span")
	appendTxt(cnd, " ")
	cnd.className = "high"
}
makeCnd()

function caret(nd, n) {
	var r = document.createRange()
	r.setStart(nd, n)
	r.setEnd(nd, n)
	var sel = window.getSelection()
	sel.removeAllRanges()
	sel.addRange(r)
}

function removeCnd() {
	if (cnd.tab) {
		cnd.className = ""
		makeCnd()
	}
	else if (cnd.act) {
		cnd.act = false
		if (document.contains(cnd)) {
			var n1 = cnd.previousSibling
			var n2 = cnd.nextSibling
			if (n1.nodeValue && n2.nodeValue) {
				var s = n1.nodeValue + n2.nodeValue
				var p = cnd.parentNode
				p.removeChild(n1)
				p.removeChild(n2)
				var nd = document.createTextNode(s)
				p.insertBefore(nd, cnd)
				cnd.parentNode.removeChild(cnd)
				caret(nd, n1.nodeValue.length)
			}
			else {
				cnd.parentNode.removeChild(cnd)
				if (n1.nodeValue) caret(n1, n1.nodeValue.length)
				else if (n2.nodeValue) caret(n2, 0)
			}
		}
		if (cnd.err) {
			cnd.firstChild.nodeValue = " "
			cnd.err = false
		}
	}
}
function getCaret() {
	var sel = window.getSelection()
	if (!sel || sel.anchorNode == inp) return 0
	var pos = 0
	var nd = inp.firstChild
	while (true) {
		if (nd == sel.anchorNode) {
			pos += sel.anchorOffset
			return pos
		}
		if (nd.firstChild) nd = nd.firstChild
		else {
			if (nd.tagName == "BR") pos += 1
			else pos += nd.length
			while (!nd.nextSibling) {
				nd = nd.parentNode
				if (nd == inp) return 0
			}
			nd = nd.nextSibling
		}
	}
}
function setCaret(dest, showCnd = true) {
	if (dest < 0) return
	var pos = 0
	var nd = inp.firstChild
	outer:
	while (true) {
		if (nd.firstChild) nd = nd.firstChild
		else {
			if (nd.tagName == "BR") pos += 1
			else {
				if (pos + nd.length >= dest) {
					pos = dest - pos
					break
				}
				pos += nd.length
			}
			while (!nd.nextSibling) {
				nd = nd.parentNode
				if (nd == inp) {
					nd = inp.firstChild
					pos = 0
					break outer
				}
			}
			nd = nd.nextSibling
		}
	}
	if (showCnd) {
		var p = nd.parentNode
		var n1 = document.createTextNode(nd.nodeValue.substring(0, pos))
		p.insertBefore(n1, nd)
		p.insertBefore(cnd, nd)
		var n2 = document.createTextNode(nd.nodeValue.substring(pos))
		p.insertBefore(n2, nd)
		p.removeChild(nd)
		if (cnd.tab) caret(n2, 0)
		else caret(n1, pos)
		cnd.act = true
	}
	else caret(nd, pos)
}
function scrollToLine(lc, nln) {
	var lpp = nln * inp.clientHeight / inp.scrollHeight
	var ltop = nln * inp.scrollTop / inp.scrollHeight
	if (lc < ltop || lc > ltop + lpp - 1) {
		inp.scrollTop = (lc - 1) * inp.scrollHeight / nln
	}
}

function scrollToPos(pos) {
	var lines = inp.textContent.split("\n")
	var ln = lines.length
	var a = 0
	var lc
	for (lc = 0; lc < ln; lc++) {
		a += lines[lc].length + 1
		if (a > pos) break
	}
	scrollToLine(lc, ln)
}

function showError(err, pos) {
	scrollToPos(pos)
	cnd.firstChild.nodeValue = " " + err + " "
	cnd.err = true
	inp.focus()
}

function gotSrcNl(src, res, pos, err) {
	inp.innerHTML = src.substring(0, res)
	appendTxt(inp, src.substring(res) + tailSrc)
	if (err) {
		if (err[0] == ":") {
			cnd.tabopts = err.substr(1).split(":")
			cnd.tabind = 0
			cnd.firstChild.nodeValue = cnd.tabopts[0]
			cnd.tab = true
		}
		else {
			showError(err, pos)
		}
	}
	else if (tailSrc.length < 10) {
		inp.scrollTop = inp.scrollHeight - inp.clientHeight
	}
	setCaret(pos)
}
	
function gotSrcErr(src, res, pos, err) {
	if (doco) onTab(3)
	inp.innerHTML = src.substring(0, res)
	appendTxt(inp, src.substring(res))
	showRun()
	setCaret(pos)
	showError(err, pos)
}

// ------------------

function selectLine(sel, car) {
	var ln = 1
	var nd, uNd, nNd, n
	for (nd = inp.firstChild; nd; nd = nd.nextSibling) {
		if (nd.nodeName == "U") {
			while (nd.firstChild) inp.insertBefore(nd.firstChild, nd)
			inp.removeChild(nd)
			break
		}
	}
	for (nd = inp.firstChild; nd; nd = nNd) {
		nNd = nd.nextSibling
		var s = nd.nodeValue
		var i = -2
		if (s) {
			if (sel == 1 && ln == 1 && !uNd) i = -1
			else {
				for (i = 0; i < s.length; i++) {
					if (s[i] == "\n") {
						if (uNd) break
						ln++
						if (ln == sel) break
					}
				}
			}
		}
		else {
			if (ln == 1 && sel == 1 && !uNd) uNd = create("U")
			if (uNd) uNd.appendChild(nd)
		}
		if (i >= -1) {
			if (i == s.length && uNd) uNd.appendChild(nd)
			else if (ln == sel) {
				var s1 = s.substring(0, i)
				var s2 = s.substring(i + 1)
				if (!uNd) {
					if (ln != 1) {
						n = document.createTextNode(s1 + "\n")
						inp.insertBefore(n, nd)
					}
					uNd = create("U")
					var h = s2.indexOf("\n")
					if (h >= 0) {
						appendTxt(uNd, s2.substring(0, h))
						inp.insertBefore(uNd, nd)
						n = document.createTextNode(s2.substring(h))
						inp.replaceChild(n, nd)
						break
					}
					else {
						inp.removeChild(nd)
						appendTxt(uNd, s2)
					}
				}
				else {
					appendTxt(uNd, s1)
					inp.insertBefore(uNd, nd)
					n = document.createTextNode("\n" + s2)
					inp.replaceChild(n, nd)
					break
				}
			}
		}
	}
	ln = 0
	for (nd = inp.firstChild; nd; nd = nd.nextSibling) {
		s = nd.nodeValue
		if (s) for (i = 0; i < s.length; i++) if (s[i] == "\n") ln++
	}
	scrollToLine(sel - 1, ln)

	if (car) caret(uNd.lastChild, uNd.lastChild.length)
}

function prepOut(mode) {
	if (!doco) {
		if (mode & 4) show(canv)
		else {
			hide(canv)
			canv.height = 800
		}
		return
	}
	if (mode & 4) {
		if (mode & 2) show(out)
		else hide(out)
		show(canv)
		resizeOutm()
	}
	else {
		hide(canv)
		inp.style.height = "calc(70% - 36px)"
		doco.style.height = "30%"
		show(out)
	}
	showOutm()
}

function gotSrc(src, res, pos) {
	inp.innerHTML = src
	setCaret(pos, false)
	prepOut(-res)
}

function showRun(on = true) {
	runBtn.run = on
	dbgSel.disabled = !on
	if (on) {
		runBtn.textContent = "Run"
		stepBtn.textContent = "Trace"
		stepBtn.disabled = false
		hide(step2Btn)
		hide(step3Btn)
		show(trSpn)
		inp.contentEditable = true
	}
	else {
		out.value = ""
		canv.className = "run"
		runBtn.textContent = "Stop"
	}
}
function ideMsgFunc(msg, d) {
	if (msg == "output") {
		dbg.value = d[0]
	}
	else if (msg == "ready") {
		ready()
	}
	else if (msg == "nowasm") {
		runBtn = null
		onTab(1)
		inp.contentEditable = false
		console.log("no wasm")
		out.value = "You need a browser with WebAssembly enabled."
		doTutChng()
	}
	else if (msg == "stopped") {
		if (runBtn.run) return
		showRun()
		runBtn.disabled = false
		canv.className = ""
		inp.focus()
		tryRunCode()
	}
	else if (msg == "info") {
		console.log("info " + d[0])
		if (d[0] == 1) dbgShow(true)
		else if (d[0] == 0) {
			// exception, worker restarted
			runBtn.disabled = true
			hide(labinp)
		}
	}
	else if (msg == "src") {
		gotSrc(d[0], d[1], d[2])
	}
	else if (msg == "src_err") {
		gotSrcErr(d[0], d[1], d[2], d[3])
	}
	else if (msg == "src_nl") {
		gotSrcNl(d[0], d[1], d[2], d[3])
	}
	else if (msg == "src2") {
		pres[d[1]].innerHTML = d[0]
	}
	else if (msg == "selline") {
		removeCnd()
		selectLine(d[0], d[1])
	}
	else if (msg == "input") {
		input.value = ""
		show(labinp)
		input.focus()
	}
}

input.onkeydown = function(e) {
	var k = e.keyCode
	if (k == 13 || k == 68 && e.ctrlKey) {	// enter ctrl-d
		if (k == 13) easyinp(input.value)
		else easyinp(null)
		hide(labinp)
		e.preventDefault()
		inp.focus()
	}
}

runBtn.run = true

function runx() {
	if (runBtn.disabled) return
	if (runBtn.run) {
		removeCnd()
		runCode(inp.textContent, getCaret())
	}
	else doStop()
}

function doStop() {
	runBtn.disabled = true
	hide(labinp)
	kaStop()
}

window.addEventListener("keydown", function(e) {
	if (e.keyCode == 82 && e.ctrlKey || e.keyCode == 116) {	// ctrl-r f5
		e.preventDefault()
	}
})

function runDebug() {
	removeCnd()
	dbg.value = ""
	var h = dbgSel.selectedIndex
	if (h == 0 && !window["sab"]) h = 1
	if (h == 0) {
		stepBtn.textContent = "Step"
		show(step2Btn)
		show(step3Btn)
		h = 6
	}
	else {
		h = 5 - h
		stepBtn.disabled = true
	}
	hide(trSpn)
	h <<= 9
	inp.contentEditable = false
	tailSrc = null
	showRun(false)
	if (strictMode) h += 16
	kaRun(inp.textContent, h + 2, 0)
}
function stepNoti(w) {
	var vw = new Int32Array(window["sab"])
	Atomics.store(vw, 2, w)
	Atomics.store(vw, 0, 1)
	Atomics.notify(vw, 0)
}
stepBtn.onclick = function() {
	if (runBtn.run) runDebug()
	else stepNoti(0)
}
step2Btn.onclick = function() {
	stepNoti(1)
}

step3Btn.onclick = function() {
	stepNoti(2)
}

function dbgShow(on) {
	if (on) {
		inp.style.height = "calc(70% - 36px)"
		show(dbgSpn)
	}
	else {
		hide(dbgSpn)
		inp.style.height = "calc(100% - 38px)"
	}
}

tutchng.onclick = onTutChng
tutchng2.onclick = onTutChng
expnd.onclick = expandEdit
tab1.onclick = function() { onTab(1) }
tab2.onclick = function() { onTab(2) }

tab3.onclick = function() {
	if (docx.tab == 3) {
		tab3.disabled = true
		hideOutm()
	}
	else onTab(3)
}

runBtn.disabled = true
runBtn.onclick = runx
stBtn.onclick = store

var initDone
var initTut

function ready() {
	canv.className = ""
	showRun()
	runBtn.disabled = false
	stepBtn.disabled = false

	if (!initDone) {
		inp.setAttribute("autocorrect", false)
		inp.setAttribute("autocomplete", "off")
		inp.setAttribute("autocapitalize", "off")
		inp.setAttribute("spellcheck", false)
		inp.setAttribute("translate", "no")
		out.setAttribute("translate", "no")
		initDone = true
		if (initTut > 0 && initTut <= tut_file.length) {
			showTut(tut_file[initTut - 1])
			history.pushState(tutf, "", location.href)
		}
		else doTutChng()
		out.value = infostr
	}
	tryRunCode()
}

function saveit() {
	removeCnd()
	window.localStorage["xstbtnd"] = stBtn.disabled ? "x" : ""
	window.localStorage["xcode"] = inp.textContent
	window.localStorage["x2col"] = isVisible(expnd)
}

document.addEventListener("visibilitychange", () => {
	if (document.hidden) saveit()
});

window.onbeforeunload = function(e) {
	saveit()
	if (tutf) {
		tutf = null
		history.back()
	}
}

function testReload() {
	var nav = performance.getEntriesByType("navigation")[0]
	if (nav && nav.type == "reload") {
		for (var h = 0; h < tut_file.length; h++) {
			if (tut_file[h] == history.state) {
				initTut = h + 1
				break
			}
		}
		history.replaceState(null, "")
	}
}

async function main() {

	strictMode = true
	if (window.localStorage["xstrict"] == "false") {
		strictMode = false
		strictSet()
	}

	var tabn = 1
	if (window.localStorage["x2col"] == "true") {
		collapseEdit()
		show(expnd)
	}
	resizeAll()

	if (doce) tabn = 3

	var q = location.hash.substring(1)
	if (q != "") {
		var vs = q.split("&")
		for (var i = 0; i < vs.length; i++) {
			var h = 0
			if (vs[i].startsWith("code=")) h = 5
			else if (vs[i].startsWith("cod=")) h = 1
			else if (vs[i].startsWith("rux=")) h = 1
			else if (vs[i].startsWith("run=")) h = 4
			else if (vs[i] == "store") tabn = 2
			else if (vs[i].startsWith("tut=")) initTut = Number(vs[i].substring(4))

			if (h > 1) {
				try {
					codeToRun = decodeURIComponent(vs[i].substring(h))
				}
				catch(e) {
					codeToRun = "# URI error"
				}
				// inp.value = codeToRun
				//if (h == 4) showFull()
			}
			else if (h) {
				try {
					codeToRun = await decompr(vs[i].substring(4))
				}
				catch(e) {
					codeToRun = "# Decompression error"
				}
				// inp.value = codeToRun
				//if (vs[i][0] == "r") showFull()
			}
		}
		history.replaceState(null, "", location.pathname)
	}
	if (history.state) testReload()
	doTutChng()
	onTab(tabn)

	if (codeToRun) inp.textContent = codeToRun
	else {
		var t = window.localStorage["xcode"]
		if (t) stBtn.disabled = window.localStorage["xstbtnd"]
		if (t == null) t = 'print "Hello world"'
		inp.textContent = t
	}
	console.log("loading ...")
	inp.focus()
	easyinit(canv, out, ideMsgFunc)
}

main()


