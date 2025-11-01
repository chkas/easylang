var aspr = 1

function isVertical() {
	return window.innerWidth - 180 < window.innerHeight
}

var codewst
window.onresize = function() {
	var winh = window.innerHeight
	var winw = window.innerWidth
	var isvert = isVertical()

	var caw, cah
	if (isvert) {
		caw = winw - 2
		cah = Math.floor(caw * aspr)
	}
	else {
		cah = winh - 4
		caw = Math.floor(cah / aspr)
	}
	canv.style.width = caw + "px"
	canv.style.height = cah + "px"
	codewst = winw - caw - 18 + "px"
	if (isVisible(editor) || isVisible(editor2)) {
		if (isVisible(editor2)) {
			if  (isvert) {
				hide(editor2)
				editor.appendChild(codew)
				runner.appendChild(canv)
				codew.style.width = "calc(100vw - 8px)"
				show(editor)
			}
			else codew.style.width = codewst
		}
		else if (!isvert) {
			hide(editor)
			codew.style.width = codewst
			editleft.appendChild(codew)
			editor2.appendChild(canv)
			show(editor2)
		}
	}
	if (isvert && left.style.float != "") {
		left.style.float = ""
		left.style.width = "100%"
		hambtn.style.margin = "4px 8px"
	}
	else if (!isvert && left.style.float != "left") {
		left.style.float = "left"
		left.style.width = "140px"
		hambtn.style.margin = "20px"
	}
	if (isvert) {
		var m = winh - cah - 64
		if (m > 76) m = 76
		else if (m < 4) m = 4
		canv.style.marginTop = Math.floor(m * 2 / 3) + "px"
		left.style.marginTop = Math.floor(m / 3) + "px"
		namef.style.display = ""
	}
	else {
		canv.style.marginTop = "0px"
		left.style.marginTop = "20px"
		namef.style.display = "block"
	}
}

window.onresize()

function run() {
	canv.width = 800 / aspr
	canv.height = 800
	window.onresize()
	var c = canv.getContext("2d")
	c.clearRect(0, 0, canv.width, canv.height)
	codeRun(codew, canv)
}

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

function newCode(showget2 = true) {
	updCodeInfo()
	hide(sel)
	hide(hambtn)
	namef.textContent = appn
	hide(editor)
	show(keepd)
	if (showget2) show(get2)
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
		if (!window.navigator.onLine) hide(get)
		updsel()
	}
}

function change() {
	undoPre = null
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
	editing = false
	hide(keepd)
	hide(get2)
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
get.onclick = function() {
	window.open("../games/index.html?$date", "_self")
}
get2.onclick = function() {
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
	remove.textContent = "Remove"
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
		fillsel(null)
		updsel()
	}
}
window.onbeforeunload = function(e) {
	if (isVisible(keepd)) {
		window.localStorage.removeItem("xrunsel")
		window.localStorage.setItem("xruncode", codew.textContent)
	}
	else window.localStorage.setItem("xrunsel", sel.selectedIndex)
}

window.addEventListener("online", () => { if (!sel.style.display) show(get)} );
window.addEventListener("offline", () => hide(get));

function showcode() {
	hide(runner)
	if (isVertical()) {
		editor.appendChild(codew)
		runner.appendChild(canv)
		codew.style.width = "calc(100vw - 4px)"
		show(editor)
	}
	else {
		codew.style.width = codewst
		editleft.appendChild(codew)
		editor2.appendChild(canv)
		show(editor2)
	}
}

var editing

codebtn.onclick = function() {
	editing = true
	if (isVertical()) easystop()
	else codeRun(codew, canv)
	showcode()
}
codebtn2.onclick = codebtn.onclick

idelnk.onclick = async function() {
	var h = await encode(codew.textContent)
	window.open("../ide/#cod=" + h)
}

runlnk.onclick = function() {
	newCode(false)
	codeRun(codew, canv)
}
run2lnk.onclick = function() {
	updCodeInfo()
	codeRun(codew, canv)
}

dellnk.onclick = function() {
	hide(editor)
	show(runner)
	updsel()
}

savelnk.onclick = function() {
	hide(editor2)
	updCodeInfo()
	window.localStorage.setItem("a" + appn, codew.textContent)
	fillsel(appn)
	runner.appendChild(canv)
	show(runner)
	updsel()
}

del2lnk.onclick = function() {
	hide(editor2)
	runner.appendChild(canv)
	show(runner)
	updsel()
}
ide2lnk.onclick = idelnk.onclick

function msgf(m, d) {
	//? codeMsgF(m, d)
	////if (editing) codeMsgF(m, d)
	if (m == "src_err" || m == "error" || m == "selline") {
		if (editing) showcode()
		else easyrun(errapp, canv)
	}
	codeMsgF(m, d)
}

easyinit(canv, null, msgf)
codeInit(codew, run2lnk.onclick)
ready()

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
</html>
