window["codeMsgF"] = codeMsgF
window["codeInit"] = codeInit
window["codeRun"] = codeRun

function appendTxt(cnt, s) { cnt.appendChild(document.createTextNode(s)) }
function create(s) { return document.createElement(s) }

function pasteFunc(e) {
	e.preventDefault()
	var paste = e.clipboardData.getData("text/plain")
	var el = document.createElement('p')
	el.appendChild(document.createTextNode(paste))
	document.execCommand('insertHTML', false, el.innerHTML)
}

var inp

var tailSrc = null
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
	if (!cnd.act) return
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
function codeCaret() {
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
		if (nd.length != null) pos += nd.length  // chrome
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
	if (tailSrc == null) inp.innerHTML = src
	else {
		inp.innerHTML = src.substr(0, res)
		appendTxt(inp, src.substr(res) + tailSrc)
		setCaret(pos)
		if (err) showError(err, pos)
		else if (tailSrc.length < 10) {
			inp.scrollTop = inp.scrollHeight - inp.clientHeight
		}
		tailSrc = null
	}
}
	
function gotSrcErr(src, res, pos, err) {
	inp.innerHTML = src.substr(0, res)
	appendTxt(inp, src.substr(res))
	stopped()
	setCaret(pos)
	showError(err, pos)
}

// ------------------
function doEnter() {
	var p = codeCaret()
	var inps = inp.innerText
	if (p != 0 && inps[p - 1] != "\n") {
		while (p < inps.length && inps[p] != "\n") p++
	}
	var s =inps.substring(0, p)
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

function preKey(pre, e) {
	inp = pre
	var k = e.keyCode
	if (cnd.act) {
		removeCnd()
		if (k == 8) {
			e.preventDefault()
			return
		}
	}
	if (e.ctrlKey) {
		if (k == 82 || k == 13) {
			runx()
			e.preventDefault()
		}
	}
	else if (k == 9) {
		document.execCommand("insertHTML", false, "  ")
		e.preventDefault()
	}
	else if (k === 13) {
		e.preventDefault()
		if (e.shiftKey) runx()
		else if (kaRunning()) {
			kaStop()
			stopped()
		}
		else doEnter()
	}
}

function codeRun(pre, canv, out = null) {
	inp = pre
	removeCnd()
	easystop()
	easyrun(pre.innerText, canv, out, codeCaret())
}

function selectLine(sel) {
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
				var s1 = s.substr(0, i)
				var s2 = s.substr(i + 1)
				if (!uNd) {
					if (ln != 1) {
						n = document.createTextNode(s1 + "\n")
						inp.insertBefore(n, nd)
					}
					uNd = create("U")
					var h = s2.indexOf("\n")
					if (h >= 0) {
						appendTxt(uNd, s2.substr(0, h))
						inp.insertBefore(uNd, nd)
						n = document.createTextNode(s2.substr(h))
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
}

function codeMsgF(msg, d) {
	if (msg == "src_nl") {
		gotSrcNl(d[0], d[1], d[2], d[3])
	}
	else if (msg == "src") {
		inp.innerHTML = d[0]
		setCaret(d[2], false)
		easyrunxr()
	}
	else if (msg == "srcx") {
		inp.innerHTML = d[0]
		setCaret(d[2], false)
	}
	else if (msg == "src_err") {
		gotSrcErr(d[0], d[1], d[2], d[3])
	}
	else if (msg == "selline") {
		removeCnd()
		selectLine(d[0])
	}
}

var runCB
var stoppedCB

function runx() {
	if (runCB) runCB(inp)
}

function stopped() {
	if (stoppedCB) stoppedCB()
}

function codeInit(pre, f1, f2 = null) {
	runCB = f1
	stoppedCB = f2
	pre.className = "code"
	pre.contentEditable = true
	pre.autocorrect = "off"
	pre.autocomplete = "off"
	pre.autocapitalize = "off"
	pre.spellcheck = false
	pre.onkeydown = function(e) {
		preKey(this, e)
	}
	pre.onmousedown = removeCnd
	pre.addEventListener("paste", pasteFunc)
	inp = pre
}

