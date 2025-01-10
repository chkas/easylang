var code0 = `
rad = 25
x = 50
y = 75
vx = 0.5
linewidth 2
on animate
   clear
   color 422
   move 0 72
   line 0 0
   line 100 0
   line 100 72
   move x y
   color 422
   circle rad
   color 888
   move x - 12 y + 5
   text "Code"
   move x - 13 y - 5
   text "Runner"
   if x > 100 - rad or x < rad
      vx = -vx
   .
   x += vx
   if y < rad
      vy = -vy
   else
      vy -= 0.03125
   .
   y += vy
.`

err = `
clear
textsize 5
move 5 60
text "This app is not compatible :-("
move 5 50
text "You should reinstall it."
`
var aspr = 1

window.onresize = function() {
	var vh = window.innerHeight
	var vw = window.innerWidth

	var lw
	if (vw - 240 < vh) {
		vh -= 80
		lw = "100%"
	}
	else {
		vw -= 220
		lw = "220px"
	}
	var w = vw - 2
	var h = Math.floor(w * aspr)

	if (h > vh) {
		h = vh - 6
		w = Math.floor(h / aspr)
	}
	canv.style.width = w + "px"
	canv.style.height = h + "px"
	canv.style.marginTop = "1px"
	if (lw == "100%") {
		left.style.float = ""
		hambtn.style.margin = "2px 8px"
		if (vh - 40 > h) canv.style.marginTop = "36px"
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

function getCodeInfo() {
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
	if (appn == null) appn = an
}

function newCode() {
	window.localStorage.removeItem("xruncode")
	appn = null
	getCodeInfo()
	hide(sel)
	hide(hambtn)
	namef.textContent = appn
	show(keepd)
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

async function ready() {

	fillsel(null)

	var q = location.hash.substring(1)
	if (q == "") q = location.search.substring(1)

	if (q.startsWith("code=")) {
		code = decodeURIComponent(q.substring(5))
		history.replaceState(null, "", location.protocol + "//" + location.host + location.pathname)
	}
	else if (q.startsWith("cod=")) {
		code = await decompr(q.substring(4))
		history.replaceState(null, "", location.protocol + "//" + location.host + location.pathname)
	}
	else code = window.localStorage.getItem("xruncode")

	if (code) {
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
	appn = sel.options[ind].value
	code = window.localStorage.getItem("a" + appn)
	window.localStorage.setItem("xrunsel", ind)
	getCodeInfo()
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
keep.onclick = function() {
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
		window.localStorage.removeItem("i" + appn)
		fillsel(null)
		updsel()
	}
}
//disc.onclick = function() {
//	updsel()
//}
window.onbeforeunload = function(e) {
	if (!keepd.style.display) {
		window.localStorage.removeItem("xrunsel")
		window.localStorage.setItem("xruncode", code)
	}
	else window.localStorage.setItem("xrunsel", sel.selectedIndex)
}

window.addEventListener("online", () => { if (!sel.style.display) show(inst)} );
window.addEventListener("offline", () => hide(inst));

edit.onclick = function() {
	easystop()
	hide(canv)
	hide(runner)
	show(editor)
	codew.innerText = code
	kaFormat(code)
}
edit2.onclick = edit.onclick

idelnk.onclick = function() {
	window.open("../ide/#code=" + encodeURIComponent(codew.innerText))
}
savelnk.onclick = function() {
	codeRun(codew, canv)
}
codeInit(codew, savelnk.onclick)

canclnk.onclick = function() {
	codew.innerText = null
	hide(editor)
	show(canv)
	show(runner)
	updsel()
}

function msgf(m, a) {
	if (isVisible(editor)) {
		codeMsgF(m, a)
		if (m == "src") {
			code = codew.innerText
			codew.innerText = null
			hide(editor)
			show(canv)
			show(runner)
			show(namef)
			newCode()
		}
	}
	else if (m == "error" || m == "selline") easyrun(err, canv)
}

</script>
