function create(s) { return document.createElement(s) }

var style = create("style")
style.innerHTML = `

body{
	background:#000;
	color:#ccc;
	font:normal normal normal 16px/1.5 Arial,sans-serif;
	margin-left:10px;margin-right:10px;
}
a{color:#ccc}
a:visited{color:#ccc}
a:hover{background-color:#333}

pre{
	padding:5px;
	font:normal normal normal 14px/1.3 monospace;
	width:calc(100vw - 48px);
	overflow-y:auto;
}
pre.code {
	width:50vw;
	max-width:680px;
	max-height:50vh;
	min-height:80px;
	outline:none;
	user-select:text;
	-webkit-user-select:text;
}
textarea {
	background:#000;
	color:#ccc;
	margin-left:12px;
	border:none;
	padding:5px;
	font:normal normal normal 14px/1.3 monospace;
	width:calc(50vw - 72px);
	resize:none;
}
canvas {
	color:#fff;
	margin-left:12px;
	width:calc(50vw - 63px);
	height:calc(50vw - 63px);
}
@media only screen and (max-width: 600px) {
	textarea {
		margin-left:0px;
		width:calc(100vw - 34px);
	}
	pre.code {
		width:calc(100vw - 32px);
		max-width:600px
	}
	canvas {
		margin-left:0px;
		width:calc(100vw - 24px);
		height:calc(100vw - 24px);
	}
	body{
		margin-left:8px;margin-right:8px
	}
}

h3{background:#444;padding:4px;padding-left:12px;margin-bottom:12px}
h3:not(:first-child) { margin-top:24px}

tt {padding:1px;background:#333;color:#fff;}

button {
	color:#fff;
	cursor:pointer;
	margin:0px 0px 4px 12px;
	padding:4px;
	border:none;
	border-radius:5px;
}
button:hover:enabled{background:#666}
button:enabled{background:#444}
button:disabled{background:#444;color:#666;cursor:default}
button.stop { display:none; }

hr {
	margin-top:30px;
	margin-bottom:30px;
	height:1px;
	border: none;
	background: #444;
}

span.high {background-color:#666}

*{scrollbar-width:auto}
::-webkit-scrollbar{width:10px;height:10px}
::-webkit-scrollbar-track{background:#222}
::-webkit-scrollbar-thumb{background:#666}
::-webkit-scrollbar-corner{background:rgba(0,0,0,0)}

pre i{font-weight:400;color:#9d9}
pre b{font-weight:500;color:#fc9}
pre s{text-decoration:none;font-weight:500;color:#9cf}
pre u{font-weight:bold;text-decoration:none;color:#fff;background:#666}

.flex {
  display: inline-flex;
  flex-wrap: wrap;
}
.vflex {
  display: flex;
  flex-direction: column;
}
`
document.body.appendChild(style)

var phone = window.matchMedia("(max-width: 600px)").matches

var txt_locale = window["txt_locale"]
if (txt_locale == null) txt_locale = ""

var txt_tutor = window["txt_tutor"]
var tut = document.getElementById("tut")

var isInit
var pres
var actBtn
var prevBtn

var isActive

function stopped() {
	if (!isActive) return
	if (input) {
		input.remove()
		input = null
	}
	var btn = prevBtn
	if (!btn) btn = actBtn

	if (btn) {
		if (btn.out) btn.out.className = ""
		if (btn.canv) btn.canv.className = ""
		btn.stop.style.display = "none"
		btn.disabled = false
	}
	if (prevBtn) prevBtn = null
	else if (actBtn) actBtn = null

}

function tutMsgFunc(msg, d) {
	//console.log("msg: " + msg)
	if (msg == "stopped") {
		stopped()
	}
	else if (msg == "src_err") {
		actBtn.disabled = false
		actBtn = prevBtn
	}
	else if (msg == "ready") {
		if (!isInit) {
			tutUpd()
			isInit = true
		}
		else {
			stopped()
		}
	}
	else if (msg == "input") {
		input = create("input")
		input.setAttribute("type", "text")
		input.setAttribute("enterkeyhint", "done")
		input.style.marginLeft = "12px"
		actBtn.parentElement.appendChild(input)
		input.focus()
		input.onkeydown = function(e) {
			var k = e.keyCode
			if (k == 13 || k == 68 && e.ctrlKey) {
				if (k == 13) easyinp(input.value)
				else easyinp(null)
				input.remove()
				input = null
				e.preventDefault()
			}
		}
	}
	else if (msg == "src2") {
		pres[d[1]].innerHTML = d[0]
		pres[d[1]].style.height = pres[d[1]].offsetHeight + 8 + "px"
		//pres[d[1]].height = pres[d[1]].style.height
	}
	else if (msg == "src") {
		msg = "src_tut"
		actBtn.pre.offsetHeight
		actBtn.pre.style.height = ""
	}
    codeMsgF(msg, d)


	if (msg == "src_tut") {
		isActive = true
		var h = -d[1]

		actBtn.canv.offsetHeight
		actBtn.out.offsetHeight

		if (!phone) {
			if ((h & 6) == 2) actBtn.pre.style.height = actBtn.pre.offsetHeight + 8 + "px"
		}
		var delay = 0
		if (h & 4) {
			if (!actBtn.canv.parentNode) {
				delay = 100
				if (actBtn.out.parentNode) actBtn.pre.div.insertBefore(actBtn.canv, actBtn.out)
				else actBtn.pre.div.appendChild(actBtn.canv)

				actBtn.canv.style.height = "0px"
				actBtn.canv.offsetHeight
				actBtn.canv.style.height = actBtn.canv.style.width
			}
		}
		else {
			actBtn.canv.remove()
			canv0 = actBtn.canv
			canv0.height = 800
			actBtn.canv = null
		}

		if (h & 2) {
			if (!actBtn.out.parentNode) {
				delay += 60
				actBtn.pre.div.appendChild(actBtn.out)
				actBtn.out.style.height = "0px"
				actBtn.out.offsetHeight
				if (phone) actBtn.out.style.height = "128px"
				else if (actBtn.canv) actBtn.out.style.height = "64px"
			}
			else if (actBtn.canv) actBtn.out.style.height = "64px"
		}
		else {
			actBtn.out.remove()
			out0 = actBtn.out
			actBtn.out = null
		}
		if (!phone) {
			if ((h & 6) == 6) actBtn.pre.style.height = (actBtn.canv.offsetWidth + 80) + "px"
			else if (h & 4) actBtn.pre.style.height = (actBtn.canv.offsetWidth + 4) + "px"
			else if (h & 2) actBtn.out.style.height = (actBtn.pre.offsetHeight - 36) + "px"
			actBtn.pre.style.maxHeight = actBtn.pre.style.height
		}

		setTimeout(function() {
			if (actBtn != null) {
				actBtn.stop.style.display = "inline"
			}
		}, 2000);
		if (actBtn.canv) actBtn.canv.className = "run"

		if (delay) setTimeout(function() {
				easyrunxr()
			}, delay)
		else easyrunxr()

		if (actBtn.run == "btn") actBtn.pre.blur()
	}
}

var out0
var canv0

function makeCanv() {
	var canv = canv0
	canv0 = null
	if (!canv) {
		canv = create("canvas")
		canv.width = 800
		canv.height = 800
	}
	return canv
}
function makeOut() {
	var out = out0
	out0 = null
	if (!out) {
		out = create("textarea")
		out.readOnly = true
	}
	return out
}

function tutUpd() {
	while (tut.firstChild) tut.removeChild(tut.firstChild)
	var lang = navigator.language.substring(0, 2)
	if (txt_locale.indexOf(lang) == -1) lang = ""
	lang += " "
	pres = []
	var splitStr = "\n\n"
	if (window.txt_split) splitStr = txt_split
	var smpls = txt_tutor.split(splitStr)
	if (smpls[0].charAt(0) === "\n") smpls[0] = smpls[0].slice(1)
	var k = lang.length + 1
	for (var i = 0; i < smpls.length; i++) {
		var s = smpls[i]
		if (s.startsWith("*")) {
			if (s.startsWith("*" + lang)) {
				var b = create("h3")
				b.appendChild(document.createTextNode(s.substring(k)))
				tut.appendChild(b)
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
				tut.appendChild(b)
			}
		}
		else if (s == "-") tut.appendChild(create("hr"))
		else if (s.startsWith("@")) {
			if (s.startsWith("@" + lang)) {
				var ar  = s.substring(k).split("@")
				var p = create("p")
				var link = create("a")
				link.href = ar[0]
				link.target = "_blank"
				link.appendChild(document.createTextNode(ar[1]))
				p.appendChild(link)
				tut.appendChild(p)
			}
		}
		else if (s.startsWith("##")) {
			tut.appendChild(create("p"))
			var ca = create("canvas")
			ca.tabindex = 0
			ca.style.marginBottom = "0px"
			ca.style.border = "0px"

			ca.style.width = "320px"
			ca.style.height = "320px"
			ca.style.maxWidth = "100vw"
			ca.style.maxHeight = "100vw"
			if (s[2] != "\n") {
				var h = Number(s.substring(2, 4))
				ca.width = 800
				ca.height = 8 * h
				ca.style.height = Math.floor(h * 3.2)  + "px"
				ca.style.maxHeight = Math.floor(h)  + "vw"

				if (s[4] == " ") {
					var m = Number(s.substring(5, 8))
					ca.style.width = m  + "vw"
					ca.style.height = Math.floor(m * h / 100)  + "vw"
					ca.style.maxWidth = "600px"
					ca.style.maxHeight = Math.floor(h * 6)  + "px"
				}
			}
			var c = ca.getContext("2d")
			c.clearRect(0, 0, 800, 800)
			tut.appendChild(ca)
			easyrun(s.substring(s.indexOf("\n") + 1), ca)
		}
		else if (s.startsWith("~")) {
			var b = create("pre")
			b.appendChild(document.createTextNode(s.substring(k)))
			tut.appendChild(b)
		}
		else {
			var pre = create("pre")
			codeInit(pre, runCB, stopped)
			pre.textContent = s
			kaFormat(s, pres.push(pre) - 1)

			var btn = create("button")
			btn.innerHTML = "Run"
			btn.onclick = function() {
				this.run = "btn"
				runClick(this)
			}
			var btn2 = create("button")
			btn2.innerHTML = "Stop"
			btn2.className = "stop"
			btn2.onclick = function() {
				stop()
			}
			var flex = create("div")
			flex.className = "flex"

			var div
			div = create("div")
			div.appendChild(pre)
			flex.appendChild(div)

			div = create("div")

			var d = create("div")
			d.className = "vflex"

			var d2 = create("div")
			d2.appendChild(btn)
			d2.appendChild(btn2)
			d.appendChild(d2)
			pre.div = d

			div.append(d)
			flex.appendChild(div)

			tut.appendChild(flex)

			btn.stop = btn2
			btn.pre = pre
			pre.btn = btn
		}
	}
	if (window.hook) hook()
}

var input

function stop() {
	if (input) {
		input.remove()
		input = null
	}
	kaStop()
}

function runClick(btn) {
	if (btn.disabled) return
	btn.disabled = true
	tailSrc = null
	prevBtn = actBtn
	actBtn = btn
	if (!btn.canv) btn.canv = makeCanv()
	if (!btn.out) btn.out = makeOut()
	codeRun(btn.pre, btn.canv, btn.out)
}

function runCB(inp) {
	inp.btn.run = "key"
	runClick(inp.btn)
}

window.addEventListener("keydown", function(e) {
	if (e.keyCode == 82 && e.ctrlKey || e.keyCode == 116) {
		e.preventDefault()
	}
})

easyinit(null, null, tutMsgFunc)

