sysconf topleft
#
# qlmanage -t -s 256 -o . icon.svg ; mv icon.svg.png icon.png
#
global x0 y0 width col$ .
func$ hdig d .
   d += 48
   if d >= 58
      d += 39
   .
   return strchar d
.
func$ hcol c .
   for i to 3
      d = c mod 10
      h = floor (d / 9 * 255)
      r$ = hdig (h mod 16) & r$
      r$ = hdig (h div 16) & r$
      c = c div 10
   .
   if r$ = "000000"
      r$ = "000"
   .
   return "#" & r$
.
proc xbackgr c . .
   background c
   clear
   pr "<rect x=\"0\" y=\"0\" width=\"100%\" height=\"100%\" fill=\"" & hcol c & "\"/>"
.
proc xlinewidth w . .
   width = w
   linewidth w
.
proc xmove x y . .
   x0 = x
   y0 = y
   move x y
.
proc xline x y . .
   line x y
   if col$ <> "#000"
      h$ = " fill=\"" & col$ & "\""
   .
   pr "<circle cx=\"" & x0 & "\" cy=\"" & y0 & "\" r=\"" & width / 2 & "\"" & h$ & "/>"
   pr "<circle cx=\"" & x & "\" cy=\"" & y & "\" r=\"" & width / 2 & "\"" & h$ & "/>"
   h$ = "<line x1=\"" & x0 & "\" y1=\"" & y0 & "\" x2=\"" & x & "\" y2=\"" & y & "\" "
   stroke$ = "stroke=\"" & col$ & "\" "
   pr h$ & stroke$ & "stroke-width=\"" & width & "\"/>"
   x0 = x
   y0 = y
.
proc xcolor c . .
   color c
   col$ = hcol c
.
proc xcircle r . .
   circle r
   pr "<circle cx=\"" & x0 & "\" cy=\"" & y0 & "\" r=\"" & r & "\" fill=\"" & col$ & "\"/>"
.
proc draw . .
   c = 797
   xbackgr c
   xcolor 000
   xlinewidth 6
   xmove 24 24
   xline 76 24
   xline 76 76
   xline 24 76
   xline 24 24
   #
   xlinewidth 2
   y = 42.5
   xmove 32 y
   xline 68 y
   y += 15
   xmove 32 y
   xline 68 y
   x = 42.5
   xmove x 32
   xline x 68
   x += 15
   xmove x 32
   xline x 68
   #
   xmove 39 54
   xline 31 46
   xmove 39 46
   xline 31 54
   #
   xmove 50 50
   xcircle 5.5
   xcolor c
   xcircle 3.5
   xmove 75 75
   xcircle 2
.
pr "<svg xmlns=\"http://www.w3.org/2000/svg\""
pr "width=\"512\" height=\"512\" viewBox=\"0 0 100 100\">"
draw
pr "</svg>"
