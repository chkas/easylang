var aspr = 1

function isVertical() {
	return left.style.width == "100%"
}
function isEdit() {
	return isVisible(editor) || isVisible(editor2)
}
var codewst
window.onresize = function() {
	var vh = window.innerHeight
	var vw = window.innerWidth

	var lw
	var w
	if (vw - 240 < vh) {
		vh -= 80
		lw = "100%"
		w = vw - 2
	}
	else {
		//vw -= 220
		lw = "220px"
		w = vw - 222
	}
	var h = Math.floor(w * aspr)
	if (!lw) lw = ""

	if (h > vh) {
		h = vh - 6
		w = Math.floor(h / aspr)
	}

	canvvp.style.width = w + "px"
	canvvp.style.height = h + "px"
	canvhp.style.width = w + "px"
	canvhp.style.height = h + "px"
	codewst = vw - w - 18 + "px"
	if (isEdit()) {
		if (isVisible(editor2)) {
			if  (lw == "100%") {
				hide(editor2)
				editor.appendChild(codew)
				canvvp.appendChild(canv)
				codew.style.width = "calc(100vw - 4px)"
				show(editor)
			}
			else codew.style.width = codewst
		}
		else if (isVisible(editor) &&  lw != "100%") {
			hide(editor)
			codew.style.width = codewst
			codehp.appendChild(codew)
			canvhp.appendChild(canv)
			show(editor2)
		}
	}

	if (lw == "100%") {
		left.style.float = ""
		hambtn.style.margin = "2px 8px"
		if (vh - 40 > h) canvvp.style.marginTop = "36px"
	}
	else {
		left.style.float = "left"
		hambtn.style.margin = "20px"
	}
	left.style.width = lw
}

window.onresize()

function runr(s) {
	easystop()
	canv.width = 800 / aspr
	canv.height = 800
	window.onresize()
	var c = canv.getContext("2d")
	c.clearRect(0, 0, canv.width, canv.height)
	easyrun(s, canv)
}

easyinit(canv, null, msgf)

window.name = "easylang_run"
var appn = null
var code = null

function updCodeInfo() {
	aspr = 1
	var an = Math.floor(Date.now() / 1000) - 1577833200
	if (code[0] == "#") {
		var i = code.indexOf("\n")
		if (i != -1) {
			an = code.substr(2, i - 2)
			i = an.indexOf(":w")
			if (i != -1) {
				aspr = 100 / Number(an.substr(i + 2))
				an = an.substr(0, i)
			}
		}
	}
	appn = an
}

function newCode() {
	window.localStorage.removeItem("xruncode")
	updCodeInfo()
	hide(sel)
	hide(hambtn)
	namef.textContent = appn
	show(keepd)
}

async function ready() {

	fillsel(null)

	var q = location.hash.substring(1)
	if (q == "") q = location.search.substring(1)

	if (q.startsWith("code=")) {
		code = decodeURIComponent(q.substring(5))
		history.replaceState(null, "", location.protocol + "//" + location.host + location.pathname)
	}
	else if (q.startsWith("cod=")) {
		code = await decode(q.substring(4))
		history.replaceState(null, "", location.protocol + "//" + location.host + location.pathname)
	}
	else code = window.localStorage.getItem("xruncode")

	if (code) {
		codew.innerText = code
		newCode()
		runr(code)
	}
	else {
		sel.selectedIndex = window.localStorage.getItem("xrunsel")
		if (!window.navigator.onLine) hide(inst)
		updsel()
	}
}

ready()

function change() {
	var ind = sel.selectedIndex >= 0 ? sel.selectedIndex : 0
	var seln = sel.options[ind].value
	code = window.localStorage.getItem("a" + seln)
	updCodeInfo()
	appn = seln
	codew.innerText = null
	window.localStorage.setItem("xrunsel", ind)
	runr(code)
}

sel.onchange = change

function fillsel(nm) {
	while (sel.options.length) sel.options.remove(0)
	var ar = Object.keys(window.localStorage || {})
	ar.sort()
	sel.selectedIndex = 0
	for (var i = 0; i < ar.length; i++) {
		var k = ar[i]
		if (k[0] != "a") break
		var option = document.createElement("option")
		option.text = k.substr(1)
		option.value = k.substr(1)
		sel.add(option)
		if (option.value == nm) {
			sel.selectedIndex = sel.options.length - 1
		}
	}
}
function updsel() {
	hide(keepd)
	if (!sel.options.length) {
		show(info)
		hide(hambtn)
		hide(sel)
		aspr = 1
		runr(code0)
	}
	else {
		hide(info)
		show(hambtn)
		show(sel)
		change()
	}
}
inst.onclick = function() {
//	window.open("./list.html", "_self")
	window.open("../games/index.html?$date", "_self")
}
save.onclick = function() {
	code = codew.innerText
	updCodeInfo()
	window.localStorage.setItem("a" + appn, code)
	fillsel(appn)
	updsel()
}

var rmt
function rmreset() {
	remove.textContent = "Delete"
	rmt = null
}
remove.onclick = function() {
    if (!rmt) {
		remove.textContent = "Really?"
		rmt = setTimeout(rmreset, 3000)
	}
	else {
		hide(menud)
		clearTimeout(rmt)
		rmreset();
		window.localStorage.removeItem("a" + appn)
		//window.localStorage.removeItem("i" + appn)
		fillsel(null)
		updsel()
	}
}
window.onbeforeunload = function(e) {
	if (!keepd.style.display) {
		window.localStorage.removeItem("xrunsel")
		window.localStorage.setItem("xruncode", code)
	}
	else window.localStorage.setItem("xrunsel", sel.selectedIndex)
}

window.addEventListener("online", () => { if (!sel.style.display) show(inst)} );
window.addEventListener("offline", () => hide(inst));

function showedit() {
	if (!codew.innerText) {
		codew.innerText = code
		kaFormat(code)
	}
	hide(runner)

	if (isVertical()) {
		hide(canvvp)
		editor.appendChild(codew)
		codew.style.width = "calc(100vw - 4px)"
		show(editor)
	}
	else {
		codew.style.width = codewst
		codehp.appendChild(codew)
		canvhp.appendChild(canv)
		show(editor2)
	}
}

codebtn.onclick = function() {
	easystop()
	showedit()
}
codebtn2.onclick = codebtn.onclick

idelnk.onclick = async function() {
	var h = await encode(codew.innerText)
	window.open("../ide/#cod=" + h)
	//window.open("../ide/#code=" + encodeURIComponent(codew.innerText))
}

runlnk.onclick = function() {
	codeRun(codew, canv)
}
codeInit(codew, runlnk.onclick)

dellnk.onclick = function() {
	codew.innerText = null
	hide(editor)
	show(canvvp)
	show(runner)
	updsel()
}

savelnk.onclick = function() {
	code = codew.innerText
	hide(editor2)
	updCodeInfo()
	window.localStorage.setItem("a" + appn, code)
	fillsel(appn)
	canvvp.appendChild(canv)
	show(canvvp)
	show(runner)
	updsel()
}

run2lnk.onclick = function() {
	codeRun(codew, canv)
}
del2lnk.onclick = function() {
	codew.innerText = null
	hide(editor2)
	canvvp.appendChild(canv)
	show(canvvp)
	show(runner)
	updsel()
}
ide2lnk.onclick = idelnk.onclick

selline = 0

function msgf(m, d) {
	if (isEdit()) {
		codeMsgF(m, d)
		if (m == "src") {
			code = codew.innerText
			if (isVisible(editor)) {
				hide(editor)
				show(canvvp)
				show(runner)
				show(namef)
				newCode()
			}
		}
	}
	else if (m == "error" || m == "selline") {
		if (isEdit()) {
			showedit()
			codeMsgF(m, d)
		}
		else {
			easyrun(errapp, canv)
		}
	}
}

async function encode(txt) {
	var enc = new TextEncoder()
	var buffer = await new Response(new Response(enc.encode(txt)).body.pipeThrough(new CompressionStream('deflate-raw'))).arrayBuffer()
	var s = ""
	var bytes = new Uint8Array(buffer)
	for (var i = 0; i < bytes.byteLength; i++) {
		s += String.fromCharCode(bytes[i])
	}
	return btoa(s)
}
async function decode(txt) {
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

</script>
