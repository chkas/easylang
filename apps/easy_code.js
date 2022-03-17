function append(cnt, e) { cnt.appendChild(document.createElement(e)) }
function appendTxt(cnt, s) { cnt.appendChild(document.createTextNode(s)) }
function create(s) { return document.createElement(s) }
function log(s) { console.log(s) }

function pasteFunc(e) {
	e.preventDefault()
	var paste = e.clipboardData.getData("text/plain")
	var el = document.createElement('p')
	el.appendChild(document.createTextNode(paste))
	document.execCommand('insertHTML', false, el.innerHTML)
}

function initPre(pre) {
	pre.className = "code"
	pre.contentEditable = true
	pre.autocorrect = false
	pre.autocomplete = false
	pre.autocapitalize = false
	pre.spellcheck = false
	pre.onkeydown = function(e) {
		preKey(this, e)
	}
	pre.onmousedown = removeCnd
	pre.addEventListener("paste", pasteFunc)
	inp = pre
}

var input

function stop() {
	if (input) {
		input.remove()
		input = null
	}
	kaStop()
}

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

function selectLine(l) {
	var sel = window.getSelection()
	sel.removeAllRanges()
	if (l == 0) return;
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
			runCB()
			e.preventDefault()
		}
	}
	else if (k == 9) {
		document.execCommand("insertHTML", false, "  ")
		e.preventDefault()
	}
	else if (k === 13) {
		if (kaRunning()) {
			e.preventDefault()
			stop()
			return
		}
		var p = getCaret()
		var inps = inp.innerText
		if (p != 0 && inps[p - 1] != "\n") {
			while (p < inps.length && inps[p] != "\n") p++
		}
		var s =inps.substring(0, p)
		tailSrc = inps.substring(p)
		if ((s.length == 0 || s[s.length - 1] == "\n") && tailSrc[0] != "\n") {
			tailSrc = "\n" + tailSrc
		}
		kaFormat(s)
		e.preventDefault()
	}
}

function msgfCode(msg, d) {
	if (msg == "src_nl") {
		gotSrcNl(d[0], d[1], d[2], d[3])
	}
	else if (msg == "src") {
		inp.innerHTML = d[0]
		setCaret(d[2], false)
	}
	else if (msg == "src_err") {
		gotSrcErr(d[0], d[1], d[2], d[3])
	}
	else if (msg == "selline") {
		selectLine(d[0])
	}
}

function run(txt, canv, out = null) {
	removeCnd()
	tailSrc = null
	easystop()
	easyrun(txt, canv, out, null, getCaret())
}

