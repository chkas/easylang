const VERS = ""

var lang = navigator.language.substring(0, 2)

if (lang == "de") {
	txt_header = "<p>Easy programming - <a href=..>More about<a></p><h3>Tutorials</h3>"
	tut_descr = [
		"Programmieren lernen",
		"Dokumentation - Code-Beispiele",
		"Funktionen and Rekursion",
		"Ein Spiel programmieren",
	]
} else {
	txt_header = "<p>Easy programming - <a href=..>More about<a></p><h3>Tutorials</h3>"
	tut_descr = [
		"Learn programming",
		"Documentation - Code snippets",
		"Functions and recursion",
		"Making a game",
	]
}

tut_file = [
	"tut_learn" + VERS + ".js",
	"tut_docu" + VERS + ".js",
	"tut_func" + VERS + ".js",
	"tut_game" + VERS + ".js",
]

txt_locale_id = "de"
txt_tutor_id = `
-

* Demos

*de Demos

for i = 1 to 10
  print i * i
end

rad = 12 ; x = 50 ; y = 15 ; vx = 1.5
color 700
# 
on animate
  clear
  move x y
  circle rad
  x += vx ; y += vy
  if x > 100 - rad or x < rad
    vx = -vx
  end
  if y > 100 - rad
    vy = -vy
  else
    vy += 0.1
  end
end
`

