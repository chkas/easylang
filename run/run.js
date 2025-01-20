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

function run() {
	easystop()
	canv.width = 800 / aspr
	canv.height = 800
	window.onresize()
	var c = canv.getContext("2d")
	c.clearRect(0, 0, canv.width, canv.height)
	easyrun(codew.textContent, canv)
}

easyinit(canv, null, msgf)

window.name = "easylang_run"
var appn = null

function updCodeInfo() {
	var cod = codew.textContent
	aspr = 1
	var an = Math.floor(Date.now() / 1000) - 1577833200
	if (cod[0] == "#") {
		var i = cod.indexOf("\n")
		if (i != -1) {
			an = cod.substr(2, i - 2)
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
	updCodeInfo()
	hide(sel)
	hide(hambtn)
	namef.textContent = appn
	hide(editor)
	show(keepd)
	show(canvvp)
	show(runner)
	show(namef)
}

async function ready() {

	fillsel(null)

	var q = location.hash.substring(1)
	if (q == "") q = location.search.substring(1)

	if (q.startsWith("code=")) {
		codew.textContent = decodeURIComponent(q.substring(5))
		history.replaceState(null, "", location.protocol + "//" + location.host + location.pathname)
	}
	else if (q.startsWith("cod=")) {
		codew.textContent = await decode(q.substring(4))
		history.replaceState(null, "", location.protocol + "//" + location.host + location.pathname)
	}
	else codew.textContent = window.localStorage.getItem("xruncode")

	if (codew.textContent) {
		window.localStorage.removeItem("xruncode")
		newCode()
		run()
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
	codew.textContent = window.localStorage.getItem("a" + seln)
	updCodeInfo()
	appn = seln
	window.localStorage.setItem("xrunsel", ind)
	run()
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
		codew.textContent = code0
		run()
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
	updCodeInfo()
	window.localStorage.setItem("a" + appn, codew.textContent)
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
	if (isVisible(keed)) {
		window.localStorage.removeItem("xrunsel")
		window.localStorage.setItem("xruncode", codew.textContent)
	}
	else window.localStorage.setItem("xrunsel", sel.selectedIndex)
}

window.addEventListener("online", () => { if (!sel.style.display) show(inst)} );
window.addEventListener("offline", () => hide(inst));

function showedit() {
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

var editing

codebtn.onclick = function() {
	editing = true
	if (isVertical()) {
		easystop()
		kaFormat(codew.textContent)
	}
	else {
		codeRun(codew, canv)
	}
	showedit()
}
codebtn2.onclick = codebtn.onclick

idelnk.onclick = async function() {
	var h = await encode(codew.textContent)
	window.open("../ide/#cod=" + h)
	//window.open("../ide/#code=" + encodeURIComponent(codew.textContent))
}

runlnk.onclick = function() {
	newCode()
	codeRun(codew, canv)
}
run2lnk.onclick = function() {
	updCodeInfo()
	codeRun(codew, canv)
}

codeInit(codew, runlnk.onclick)

dellnk.onclick = function() {
	editing = false
	//codew.textContent = null
	hide(editor)
	show(canvvp)
	show(runner)
	updsel()
}

savelnk.onclick = function() {
	editing = false
	hide(editor2)
	updCodeInfo()
	window.localStorage.setItem("a" + appn, codew.textContent)
	fillsel(appn)
	canvvp.appendChild(canv)
	show(canvvp)
	show(runner)
	updsel()
}

del2lnk.onclick = function() {
	editing = false
	//codew.textContent = null
	hide(editor2)
	canvvp.appendChild(canv)
	show(canvvp)
	show(runner)
	updsel()
}
ide2lnk.onclick = idelnk.onclick

selline = 0

function msgf(m, d) {
/*
	if (isEdit()) {
		codeMsgF(m, d)
		if (m == "src") {
			if (isVisible(editor)) {
				hide(editor)
				show(canvvp)
				show(runner)
				show(namef)
				newCode()
			}
		}
	}
*/
	if (editing) {
		codeMsgF(m, d)
	}
	if (m == "error" || m == "selline") {
		if (editing) {
			showedit()
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
