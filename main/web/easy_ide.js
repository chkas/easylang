/*	easy_ide.js

	Copyright (c) Christof Kaser christof.kaser@gmail.com. 
	All rights reserved.

	This work is licensed under the terms of the GNU General Public 
	License version 3. For a copy, see http://www.gnu.org/licenses/.

    A derivative of this software must contain the built-in function 
    sysfunc "created by" or an equivalent function that returns
    "christof.kaser@gmail.com".
*/

function eid(id) { return document.getElementById(id) }

var runBtn = eid("runBtn")
var stBtn = eid("stBtn")
var tab0 = eid("tab0")
var tab1 = eid("tab1")
var tab2 = eid("tab2")
var sel = eid("sel")
var inp = eid("inp")
var tut = eid("tut")
var incol = eid("incol")
var outcol = eid("outcol")
var dragb = eid("dragb")
var dragb2 = eid("dragb2")
var canv = eid("canv")
var out = eid("out")
var doc = eid("doc")
var docx = eid("docx")
var labinp = eid("labinp")
var input = eid("input")
var container = eid("container")
var storage = eid("storage")
var tutchng = eid("tutchng")
var tutchng2 = eid("tutchng2")
var expnd = eid("expnd")
var moreBtn = eid("moreBtn")
var moreSpn = eid("moreSpn")
var trSpn = eid("trSpn")
var dbg = eid("dbg")
var stepBtn = eid("stepBtn")
var step2Btn = eid("step2Btn")
var step3Btn = eid("step3Btn")
var urlBtn = eid("urlBtn")
var fullBtn = eid("fullBtn")
var themeBtn = eid("themeBtn")
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

themeBtn.onclick = function() {
	chngTheme()
	moreShow(false)
	inp.focus()
}

show(container)

function showFull() {
	hide(container)
	canv.style.width = "96vmin"
	canv.style.height = "96vmin"

	var fr = document.createDocumentFragment()
	var div = create("div")
	div.style.margin = "12px"
	div.style.cssFloat = "left"

	var btn = create("button")
	btn.innerHTML = "Edit code"
	btn.div = div
	btn.onclick = function() {
		incol.insertBefore(runBtn, stBtn)
		outcol.insertBefore(canv, out)
		document.body.removeChild(btn.div)
		canv.style.width = "100%"
		show(container)
		resizeAll()
	}
	div.appendChild(btn)
	append(div, "p")
	incol.removeChild(runBtn)
	div.appendChild(runBtn)
	append(div, "p")
	var p = location.pathname.slice(0, -5)
	var u = location.origin + p + "/run/?code=" + encodeURIComponent(inp.innerText)
	var lnk = create("a")
	lnk.href = u
	lnk.target = "_blank"
	appendTxt(lnk, "Code runner")
	div.appendChild(lnk)
	fr.appendChild(div)
	fr.appendChild(canv)
	document.body.appendChild(fr)
}

fullBtn.onclick = showFull

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
							if (st) sn += "<tt>"
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
			easyrun(s, ca)
		}
		else {
			var pre = create("pre")
			pre.innerHTML = s
			if (runBtn) {
				kaFormat(s, pres.push(pre) - 1)
				var btn = create("button")
				btn.className = "tut"
				btn.innerHTML = "Load"
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
	moreShow(false)
	dbg.innerHTML = ""
	tailSrc = null
	stepBtn.disabled = true
//	canvClear()
	showRun(false)
	kaRun(code, null, 2, caret)
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
		loadBtn.innerHTML = "Load"
		clearTimeout(loadBtn.timeout)
	}
	if (stBtn.disabled || loadBtn == btn) {
		removeCnd()
		stBtn.disabled = true
		loadBtn = null
		var code
		if (istut) code = btn.pre.innerText
		else code = window.localStorage[btn.ref]
		if (!istut && doce) onTab(2)
		if (runBtn.run) runCode(code, 0)
		else {
			codeToRun = code
			doStop()
		}
		return
	}
	loadBtn = btn
	btn.innerHTML = "Overwrite?"
	btn.timeout = setTimeout(function() {
		loadBtn.innerHTML = "Load"
		loadBtn = null
	}, 3000)
}

var delBtn

function delClick(btn) {
	if (delBtn) {
		delBtn.innerHTML = "Delete"
		clearTimeout(delBtn.timeout)
	}
	if (delBtn == btn) {
		window.localStorage.removeItem(btn.ref)
		storeUpd()
		delBtn = null
		return
	}
	delBtn = btn
	btn.innerHTML = "Really?"
	btn.timeout = setTimeout(function() {
		delBtn.innerHTML = "Delete"
		delBtn = null
	}, 3000)
}

function expandClick(btn) {
	if (btn.innerHTML == "Expand") {
		btn.preview = btn.pre.innerText
		btn.pre.innerText = window.localStorage[btn.ref]
		btn.innerHTML = "Collapse"
	}
	else {
		btn.pre.innerText = btn.preview
		btn.innerHTML = "Expand"
	}
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
		appendTxt(pre, st.substr(0, ind))

		var btn
		if (runBtn) {
			btn = create("button")
			btn.className = "tut"
			btn.innerHTML = "Load"
			btn.ref = k

			btn.onclick = function() {
				loadClick(this, false)
			}
			fr.appendChild(btn)
		}
		btn = create("button")
		btn.className = "del"
		btn.innerHTML = "Delete"
		btn.ref = k

		btn.onclick = function() {
			delClick(this)
		}
		fr.appendChild(btn)

		btn = create("button")
		btn.className = "del"
		btn.innerHTML = "Expand"
		btn.ref = k
		btn.pre = pre

		btn.onclick = function() {
			expandClick(this)
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
		removeChilds(tut)
		onTab(0)
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

function lnkClick(lnk) {
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
	removeChilds(tut)
	tut.innerHTML = txt_header
	var lnk
	for (var i = 0; i < tut_descr.length; i++) {
		var p = create("p")
		lnk = create("div")
		lnk.setAttribute("class", "lnk")
		lnk.file = tut_file[i]
		lnk.onclick = function() {
			lnkClick(this)
		}
		appendTxt(lnk, tut_descr[i])
		p.appendChild(lnk)
		tut.appendChild(p)
	}
	txt_locale = txt_locale_id
	txt_tutor = txt_tutor_id
	tutUpd()

	append(tut, "p")
	append(tut, "hr")
	lnk = create("a")

	lnk.href = "https://easylang.online"
	appendTxt(lnk, "More about easylang")
	tut.appendChild(lnk)
	append(tut, "p")
	tutf = null
}

docx.posTut = 0
docx.posSt = 0
docx.tab = 0
docx.tabPr = 0

function docRestoreScroll() {
	if (docx.tab == 0) docx.scrollTop = docx.posTut
	else if (docx.tab == 1) docx.scrollTop = docx.posSt
}

function onTab(on) {
	if (docx.tab == 0) {
		docx.posTut = docx.scrollTop
	}
	else if (docx.tab == 1) {
		docx.posSt = docx.scrollTop
	}
	if (on == 2) {
		tab2.style.zIndex = 10
		tab2.style.disabled = true
		doc.removeChild(docx)
		doc.appendChild(doce)

		tab0.disabled = false
		tab1.disabled = false
		tab2.disabled = true
	}
	else {
		if (docx.tab == 2) {
			tab2.style.zIndex = 0
			tab2.style.disabled = false
			doc.removeChild(doce)
			doc.appendChild(docx)
		}
		tab2.disabled = false
		var off = 1 - on
		eid("tab" + off).disabled = false
		hide(eid("tabl" + off))

		if (on == 0) tutUpd()
		else storeUpd()

		show(eid("tabl" + on))
		eid("tab" + on).disabled = true
		docx.focus()
	}
	docx.tabPr = docx.tab
	docx.tab = on
	docRestoreScroll()
}

var doce = null

function expandEdit() {
	if (docx.tab == 2) onTab(docx.tabPr)
	container.insertBefore(incol, outcol)
	doce = null
	hide(tab2)
	show(dragb)
	show(tut)
	hide(expnd)
	doc.style.width = "200px"
	incol.style.width = "300px"
	outcol.style.width = "200px"
	resize3()
}

function collapseEdit() {
	container.removeChild(incol)
	incol.style.width = "100%"
	doce = create("div")
	doce.style.height = "calc(100% - 36px)"
	doce.style.borderTop = "1px solid grey"
	doce.style.paddingTop = "8px"
	doce.appendChild(incol)
	tab2.style.zIndex = 0
	show(tab2)
	hide(dragb)
	resize2()
}

function resize2() {
	var w = container.offsetWidth
	var dw = Math.round(w / 2)
	var ow = w - dw - 6
	var colH = outcol.offsetHeight

	var h = colH - 56
	if (ow > h) {
		dw += ow - h
		ow = h
	}
	doc.style.width = dw + "px"
	outcol.style.width = ow + "px"
	resizeOut()
}

function resize3() {
	var w = container.offsetWidth
	var iw = incol.offsetWidth
	var ow = outcol.offsetWidth
	var dw = doc.offsetWidth
	var colH = outcol.offsetHeight
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
	dw = Math.floor(dw)
	ow = Math.floor(ow)
	iw = w - dw - ow - 12

	var h = colH - 56
	if (ow > h) {
		iw += ow - h
		ow = h
	}
	incol.style.width = iw + "px"
	doc.style.width = dw + "px"
	outcol.style.width = ow + "px"
	resizeOut()
}

function resizeAll() {
	if (!isVisible(container)) return
	if (container.offsetWidth < 600) {
		if (!doce) {
			collapseEdit()
			return
		}
		hide(expnd)
		resize2()
	}
	else {
		if (!doce) {
			hide(expnd)
			resize3()
		}
		else {
			if (!isVisible(expnd)) expandEdit()
			else resize2()
		}
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
	leftW = doc.offsetWidth
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
		leftW = doc.offsetWidth
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
			onTab(2)
			return
		}
		if (r < 200 && d > 0) return
		doc.style.width = l + "px"
		incol.style.width = r + "px"
	}
	else {
		if (l < 200 && d < 0) return
		if (r < 110 && d > 0) return
		var h = colH - r - 40
		if (h < 16 && d < 0) return

		if (drag == 2) incol.style.width = l + "px"
		else doc.style.width = l + "px"

		outcol.style.width = r + "px"
		if (isVisible(canv)) {
			canv.style.height = r + "px"
			canv.style.width = r + "px"
			out.style.height = h + "px"
		}
	}
}

function resizeOut() {
	var w = outcol.offsetWidth
	var h = outcol.offsetHeight - w
	if (isVisible(canv)) {
		canv.style.height = w + "px"
		canv.style.width = w + "px"
		out.style.height = h - 36 + "px"
	}
	else out.style.height = h + w - 32 + "px"
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
	window.localStorage.setItem("k" + sec, inp.innerText)
	stBtn.disabled = true
	storeUpd()
	inp.focus()
}

inp.onmousedown = function() {
	removeCnd()
}
var enterTime = 0
function enter() {
	if (Date.now() - enterTime < 300) {
		runx()
		return
	}
	enterTime = Date.now()
	var inps = inp.innerText
	var p = getCaret()
	if (p != 0 && inps[p - 1] != "\n") {
		while (p < inps.length && inps[p] != "\n") p++
	}
	var s =inps.substring(0, p)
	tailSrc = inps.substring(p)
	if ((s.length == 0 || s[s.length - 1] == "\n") && tailSrc[0] != "\n") {
		tailSrc = "\n" + tailSrc
	}
	kaFormat(s)
}
var searchS = ""
function search() {
	if (window.getSelection() != "") searchS = window.getSelection().toString()
	var p = getCaret()
	var s = inp.innerText.substr(p + 1)
	var m = s.search(searchS)
	if (m != -1) m = p + m + 1
	else {
		s = inp.innerText.substr(0, p)
		m = s.search(searchS)
	}
	if (m != -1) {
		scrollToPos(m)
		setCaret(m)
	}
}

inp.onkeydown = function(e) {
	var k = e.keyCode
	if (cnd.act) {
		removeCnd()
		if (k == 8) {
			e.preventDefault()
			return
		}
	}
	if (e.ctrlKey) {
		if (k == 86 || k == 88) {
			stBtn.disabled = false
			return
		}
		if (k == 82 || k == 13) {
			e.preventDefault()
			runx()
		}
		else if (k == 83) {
			e.preventDefault()
			if (!stBtn.disabled) store()
		}
		else if (k == 70) {
			e.preventDefault()
			search()
		}
		if (k == 85 || k == 79 || k == 219 || k == 72 
				|| k == 74 || k == 75 || k == 76 || k == 66) {
			e.preventDefault()
		}
		return
	}
	if (k == 13) {
		e.preventDefault()
		if (!runBtn.run) {
			todoEnter = true
			doStop()
			return
		}
		enter()
	}
	else if (k == 9) {
		document.execCommand("insertHTML", false, "  ")
		e.preventDefault()
	}
	if (stBtn.disabled && (k >= 46 || k == 32 || k <= 9)) stBtn.disabled = false
}

inp.addEventListener("paste", function(e) {
// caret pos with firefox esr wrong ??
	e.preventDefault()
	var paste = e.clipboardData.getData("text/plain")
	var el = document.createElement('p')
	el.appendChild(document.createTextNode(paste))
	document.execCommand('insertHTML', false, el.innerHTML)
})

// ------------------

var tailSrc
var cnd = create("span")
cnd.act = false
cnd.err = false
appendTxt(cnd, " ")
cnd.className = "high"

function caret(nd, n) {
	var r = document.createRange()
	r.setStart(nd, n)
	r.setEnd(nd, n)
	var sel = window.getSelection()
	sel.removeAllRanges()
	sel.addRange(r)
}

function removeCnd() {
	if (cnd.act) {
		cnd.act = false
		if (document.contains(cnd)) {

			var n1 = cnd.previousSibling
			var n2 = cnd.nextSibling

			var s = n1.nodeValue + n2.nodeValue
			var p = cnd.parentNode
			p.removeChild(n1)
			p.removeChild(n2)
			var nd = document.createTextNode(s)
			p.insertBefore(nd, cnd)
			caret(nd, n1.nodeValue.length)

			cnd.parentNode.removeChild(cnd)
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
	for (var i = 0; i < inp.childNodes.length; i++) {
		var nd = inp.childNodes[i]
		while (nd.nodeType == Node.ELEMENT_NODE && nd.childNodes.length > 0) nd = nd.childNodes[0]
		if (nd == sel.anchorNode) {
			pos += sel.anchorOffset
			break
		}
		if (nd.length != null) pos += nd.length		// chrome
	}
	return pos
}

function setCaret(pos, showCnd = true) {
	if (pos < 0) return
	var nd, i
	for (i = 0; i < inp.childNodes.length; i++) {
		nd = inp.childNodes[i]
		while (nd.nodeType == Node.ELEMENT_NODE && nd.childNodes.length > 0) nd = nd.childNodes[0]
		if (nd.length > pos) break
		pos -= nd.length
	}
	if (i == inp.childNodes.length) pos = nd.length

	if (showCnd) {
		var p = nd.parentNode
		var n = document.createTextNode(nd.nodeValue.substr(0, pos))
		p.insertBefore(n, nd)
		cnd.act = true
		p.insertBefore(cnd, nd)
		n = document.createTextNode(nd.nodeValue.substr(pos))
		p.insertBefore(n, nd)
		p.removeChild(nd)
		caret(n, 0)
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
	var lines = inp.innerText.split("\n")
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
	cnd.firstChild.nodeValue = " " + err + " "
	cnd.err = true
	scrollToPos(pos)
	inp.focus()
}

function gotSrcNl(src, res, pos, err) {
	inp.innerHTML = src.substr(0, res)
	appendTxt(inp, src.substr(res) + tailSrc)
	setCaret(pos)
	if (err) showError(err, pos)
	else if (tailSrc.length < 10) {
		inp.scrollTop = inp.scrollHeight - inp.clientHeight
	}
}
	
function gotSrcErr(src, res, pos, err) {
	inp.innerHTML = src.substr(0, res)
	appendTxt(inp, src.substr(res))
	showRun()
	setCaret(pos)
	showError(err, pos)
}

// ------------------

function selectLine(l) {
	var sel = window.getSelection()
	sel.removeAllRanges()
	if (l == 0) return
	l--
	var lines = inp.innerText.split("\n")
	var lc = l
	var ln = lines.length
	var a = 0
	for (var x = 0; x < ln; x++) {
		if (x == l) break
		a += lines[x].length + 1
	}
	var b = lines[l].length + a

	var caret0 = -1
	var caret = a
	var nd0, nd, i
	for (i = 0; i < inp.childNodes.length; i++) {
		nd = inp.childNodes[i]
		if (nd.nodeType == Node.ELEMENT_NODE) nd = nd.childNodes[0]
		if (nd.length > caret) {
			if (caret0 != -1) break
			caret0 = caret
			nd0 = nd
			caret += b - a
			i--
			continue
		}
		caret -= nd.length
	}
	if (caret0 != -1) {
		var r = document.createRange()
		r.setStart(nd0, caret0)
		r.setEnd(nd, caret)
		sel.addRange(r)
	}
	scrollToLine(lc, ln)
}
/*
function canvClearDbg() {
	var c = canv.getContext("2d")
	var sz = canv.width
	c.lineWidth = 0.2
	c.clearRect(0, 0, sz, sz)
	c.beginPath()
	var i
	for (i = 1; i < 10; i++) {
		c.moveTo(0, 10 * i)
		c.lineTo(sz, 10 * i)
		c.moveTo(10 * i, 0)
		c.lineTo(10 * i, sz)
	}
	c.strokeStyle = "#444"
	c.stroke()
	canv.className = "run"
}
*/
function showCanv() {
	if (!isVisible(canv)) {
		show(fullBtn)
		show(canv)
		resizeOut()
	}
}

function hideCanv() {
	if (isVisible(canv)) {
		hide(fullBtn)
		hide(canv)
		resizeOut()
	}
}

function gotSrc(src, res, pos) {
	inp.innerHTML = src
	var h = -res
	if ((h & 4) == 4) showCanv()
	else hideCanv()
	setCaret(pos, false)
}

function showRun(on = true) {
	runBtn.run = on
	sel.disabled = !on
	if (on) {
		out.className = ""
		runBtn.innerHTML = "Run"
		stepBtn.innerHTML = "Trace"
		stepBtn.disabled = false
		hide(step2Btn)
		hide(step3Btn)
		show(trSpn)
		inp.contentEditable = true
	}
	else {
		out.value = ""
		canv.className = "run"
		out.className = "run"
		runBtn.innerHTML = "Stop"
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
		console.log("no wasm")
		runBtn = null
		onTab(0)
		inp.contentEditable = false
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
		if (d[0] == 1) moreShow(true)
		if (d[0] == 0) {
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
		selectLine(d[0])
	}
	else if (msg == "input") {
		input.value = ""
		show(labinp)
		input.focus()
	}
}

input.onkeydown = function(e) {
	var k = e.keyCode
	if (k == 13 || k == 68 && e.ctrlKey) {
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
		runCode(inp.innerText, getCaret())
	}
	else doStop()
}

function doStop() {
	runBtn.disabled = true
	hide(labinp)
	kaStop()
}

window.addEventListener("keydown", function(e) {
	if (e.keyCode == 82 && e.ctrlKey || e.keyCode == 116) {
		e.preventDefault()
	}
})

function runDebug() {
	removeCnd()
	dbg.innerHTML = ""
	var h = sel.selectedIndex
	if (h == 0 && !window["sab"]) h = 3
	if (h == 0) {
		stepBtn.innerHTML = "Step"
		show(step2Btn)
		show(step3Btn)
		h = 6
	}
	else stepBtn.disabled = true

	hide(trSpn)
	h <<= 8
	inp.contentEditable = false
	tailSrc = null
//	canvClearDbg()
	showRun(false)
	kaRun(inp.innerText, null, h + 2, 0)
}
function stepNoti(w) {
	var vw = new Int32Array(window["sab"])
	Atomics.store(vw, 2, w)
	Atomics.store(vw, 0, 1)
	if (Atomics.notify) Atomics.notify(vw, 0, 1)
	else Atomics.wake(vw, 0, 1)
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

function moreShow(on) {
	if (on) {
		inp.style.height = "calc(70% - 36px)"
		moreBtn.className = "act"
		show(moreSpn)
	}
	else {
		hide(moreSpn)
		inp.style.height = "calc(100% - 38px)"
		moreBtn.className = ""
	}
}

moreBtn.onmousedown = function() {
	moreShow(!isVisible(moreSpn))
}

urlBtn.onclick = function() {
	var s = "?code="
	if (isVisible(canv)) s = "?run="
	var url = location.origin + "/ide/" + s + encodeURIComponent(inp.innerText)
	out.value = url
	moreShow(false)
}

tutchng.onclick = onTutChng
tutchng2.onclick = onTutChng
expnd.onclick = expandEdit
tab0.onclick = function() { onTab(0) }
tab1.onclick = function() { onTab(1) }
tab2.onclick = function() { onTab(2) }

runBtn.disabled = true
runBtn.onclick = runx
stBtn.onclick = store

var initDone

function ready() {
	canv.className = ""
	showRun()
	inp.focus()
	runBtn.disabled = false
	stepBtn.disabled = false

	if (!initDone) {
		initDone = true
		doTutChng()
	}
	tryRunCode()
}

window.onbeforeunload = function(e) {
	var t = ""
	if (!stBtn.disabled) {
		removeCnd()
		t = inp.innerText
	}
	window.localStorage.setItem("xcode", t)
	window.localStorage.setItem("x2col", isVisible(expnd))

	if (tutf) {
		tutf = null
		history.back()
	}
}

function main() {

	var tabn = 0
	if (window.localStorage.getItem("x2col") == "true") {
		collapseEdit()
		show(expnd)
		tabn = 2
	}
	resizeAll()

	var q = location.search.substring(1)
	if (q != "") {
		var vs = q.split("&")
		for (var i = 0; i < vs.length; i++) {
			var h = 0
			if (vs[i].startsWith("code=")) {
				h = 5
				if (doce) tabn = 2
			}
			else if (vs[i].startsWith("run=")) {
				h = 4
				showCanv()
				showFull()
			}
			else if (vs[i] == "store") tabn = 1
			if (h) {
				try {
					codeToRun = decodeURIComponent(vs[i].substring(h))
					appendTxt(inp, codeToRun)
				}
				catch(e) {
					codeToRun = "# URL error"
					appendTxt(inp, codeToRun)
				}
			}
		}
		history.replaceState(null, "", location.pathname)
	}
	if (performance.navigation.type == 1 && history.state) history.replaceState(null, "")

	doTutChng()
	onTab(tabn)

	if (!codeToRun) {
		var t = window.localStorage.getItem("xcode")
		if (!t || t == "\n") stBtn.disabled = true
		if (t == null) t = 'print "Hello world"'
		appendTxt(inp, t)
	}
	console.log("loading ...")
	easyinit(canv, out, ideMsgFunc)
}

main()


