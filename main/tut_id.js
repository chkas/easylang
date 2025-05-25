const VERS = ""

var lang = navigator.language.substring(0, 2)

if (lang == "de") {
	txt_header = "<p>Programmieren leicht gemacht</p><h3>Tutorials</h3>"
	tut_descr = [
		"Programmieren lernen",
		"Kleine Spiele programmieren",
		"Dokumentation - Code-Beispiele",
		"Funktionen and Rekursion",
	]
} else {
	txt_header = "<p>Programming made easy</p><h3>Tutorials</h3>"
	tut_descr = [
		"Learn programming",
		"Programming small games",
		"Documentation - Code snippets",
		"Functions and recursion",
	]
}

tut_file = [
	"tut_learn" + VERS + ".js",
	"tut_game" + VERS + ".js",
	"tut_docu" + VERS + ".js",
	"tut_func" + VERS + ".js",
]

txt_locale_id = "de"
txt_tutor_id = `
-

* Demos

*de Demos

for i = 1 to 10
   print i * i
end

rad = 12
x = 50
y = 75
vx = 1.5
color 700
#
on animate
   clear
   move x y
   circle rad
   x += vx
   y += vy
   if x > 100 - rad or x < rad
      vx = -vx
   end
   if y < rad
      vy = -vy
   else
      vy -= 0.08
   end
end

-`

tutinf.innerHTML = "<a href=../apps/ target=_blank>More about Easylang</a><p><small>Version: " + VERS + "<small>"
