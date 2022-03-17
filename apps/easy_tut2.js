var style = create("style")
style.innerHTML = `

body{
	background-color:#f8f8f8;
	font:normal normal normal 16px/1.5 Arial,sans-serif;
	margin-left:10px;margin-right:10px;max-width:730px;
}

pre{
	background-color:#fff;
	border:1px solid gray;
	border-radius:5px;
	padding:5px;
	font:normal normal normal 14px/1.3 monospace;
	width:calc(100vw - 48px);
	max-width:700px;
	overflow-y:auto;
}

pre.code {
	width:calc(100vw - 400px);
	max-width:380px;
	max-height:80vh;
	min-height:128px;
}
textarea {
	background-color:#fff;
	margin-left:12px;
	border:1px solid gray;
	padding:5px;
	font:normal normal normal 14px/1.3 monospace;
	width:310px;
	resize:none;
}
canvas.run { outline-style:solid;outline-color:#a00;outline-width:1px }
textarea.run { background-color:#eee }

canvas {
	margin-left:12px;
	border:1px solid gray;
	width:320px;
	height:320px;
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

h3{background-color:#beb;padding:4px;padding-left:12px;margin-bottom:12px}
h3:not(:first-child) { margin-top:24px}

tt {padding:1px;background-color:#dfd;}

button {
  background-color: #dfd;
  cursor: pointer;
  margin: 0px 0px 4px 12px;
  padding: 4px;
  font-size: 110%;
  border:1px solid gray;
  border-radius:5px;
}
button:enabled:hover {background-color:#cec}
button:enabled:active {background-color:#484} 

button.stop { display:none; }

pre i {color: #080}
pre b {color: #821}
pre u {font-weight:bold;text-decoration:none;color:#000; background:#faa}

hr {margin-top:30px;margin-bottom:30px;}

span.high {background-color:#faa}

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
var inp

function showRun() {
	var btn = prevBtn
	if (btn == null) btn = actBtn
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
	if (msg == "stopped") {
		showRun()
	}
	else if (msg == "ready") {
		if (!isInit) {
			tutUpd()
			isInit = true
		}
		else {
			showRun()
		}
	}
	else if (msg == "src2") {
		pres[d[1]].innerHTML = d[0]
	}
	else if (msg == "input") {
		input = create("input")
		input.setAttribute("type", "text");
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
    msgfCode(msg, d)
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
			var ca = create("canvas")
			ca.tabindex = 0
			ca.style.marginBottom = "12px"
			ca.style.border = "0px"
			if (s[2] != "\n") {
				var h = Number(s.substring(2, 4))
				ca.width = 800
				ca.height = 8 * h
				ca.style.height = h * 3.2 + "px"
			}
			var c = ca.getContext("2d")
			c.clearRect(0, 0, 800, 800)
			tut.appendChild(ca)
			easyrun(s, ca)
		}
		else if (s.startsWith("~")) {
			var b = create("pre")
			b.appendChild(document.createTextNode(s.substring(k)))
			tut.appendChild(b)
		}
		else {
			var pre = create("pre")
			initPre(pre)
			pre.innerHTML = s
			kaFormat(s, pres.push(pre) - 1)

			var out = null
			var canv = null
			if (s.search("print ") != -1) {
				out = create("textarea")
				out.readOnly = true
			}
			if (out == null || s.search("color ") != -1) {
				if (!phone) pre.style.minHeight = "332px"
				canv = create("canvas")
				canv.style.background = "#fff"
				canv.width = 800
				canv.height = 800
			}

			var btn = create("button")
			btn.innerHTML = "Run"
			btn.onclick = function() {
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

			d = create("div")
			d.className = "vflex"

			d2 = create("div")
			d2.appendChild(btn)
			d2.appendChild(btn2)
			d.appendChild(d2)

			if (canv) d.appendChild(canv)
			if (out) d.appendChild(out)

			div.append(d)
			flex.appendChild(div)

			tut.appendChild(flex)

			btn.stop = btn2
			btn.pre = pre
			pre.btn = btn
			btn.out = out
			btn.canv = canv
			if (out) {
				if (phone || canv) {
					if (!phone) pre.style.minHeight = "448px"
					out.rows = 5
				}
				else {
					out.style.height = (pre.offsetHeight - btn.offsetHeight - 4) + "px"
				}
			}
		}
	}

	if (window.hook) {
		hook()
	}
}


function runClick(btn) {
	if (btn.disabled) return
	prevBtn = actBtn
	actBtn = btn
	if (kaRunning()) stop()
	inp = btn.pre
	removeCnd()
	setTimeout(function() { 
			if (actBtn != null) {
				actBtn.stop.style.display = "inline"
			}
		}, 1000);
	btn.disabled = true

	tailSrc = null
	if (btn.canv) btn.canv.className = "run"
	if (btn.out) btn.out.className = "run"
	easyrun(inp.innerText, btn.canv, btn.out, null, getCaret())
}

function runCB() {
	runClick(inp.btn)
}

window.addEventListener("keydown", function(e) {
	if (e.keyCode == 82 && e.ctrlKey || e.keyCode == 116) {
		e.preventDefault()
	}
})

easyinit(null, null, tutMsgFunc)

