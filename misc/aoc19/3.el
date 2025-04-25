# AoC-19 - Day 3: Crossed Wires
#
sysconf topleft
w1$[] = strsplit input ","
w2$[] = strsplit input ","
#
proc split s$ &d$ &l ..
   d$ = substr s$ 1 1
   l = number substr s$ 2 99
.
#
background 000
clear
linewidth 0.3
color 666
startx = 20
starty = 80
sc = 30
if len w2$[] < 100
   sc = 3
.
#
proc mark x y . .
   move x / sc + startx y / sc + starty
   color 900
   circle 0.7
.
proc mark_start . .
   move startx starty
   color 090
   circle 1
.
#
proc drawline col x1 y1 x2 y2 . .
   color col
   move x1 / sc + startx y1 / sc + starty
   line x2 / sc + startx y2 / sc + starty
.
min = 99999
minw = 99999
#
global hx[] hy[] hw[] hl[] vx[] vy[] vw[] vl[] .
#
proc wire_1 . .
   for i = 1 to len w1$[]
      split w1$[i] d$ l
      if d$ = "L" or d$ = "R"
         hx[] &= x
         hy[] &= y
         hw[] &= w
         w += l
         if d$ = "L"
            l = -l
         .
         hl[] &= l
         drawline 990 x y x + l y
         x += l
      else
         vx[] &= x
         vy[] &= y
         vw[] &= w
         w += l
         if d$ = "U"
            l = -l
         .
         vl[] &= l
         drawline 990 x y x y + l
         y += l
      .
   .
.
func between v a l .
   b = a + l
   if a > b : swap a b
   if v > a and v < b : return 1
   return 0
.
proc intersect xh yh lh xv yv lv w . .
   if between yh yv lv = 1
      if between xv xh lh = 1
         w += abs (xv - xh) + abs (yv - yh)
         mark xv yh
         d = abs xv + abs yh
         if d < min : min = d
         if w < minw : minw = w
      .
   .
.
proc wire_2 . .
   for i = 1 to len w2$[]
      split w2$[i] d$ l
      if d$ = "L" or d$ = "R"
         if d$ = "L" : l = -l
         drawline 099 x y x + l y
         for j = 1 to len vx[]
            intersect x y l vx[j] vy[j] vl[j] vw[j] + w
         .
         x += l
      else
         if d$ = "U" : l = -l
         drawline 099 x y x y + l
         for j = 1 to len hx[]
            intersect hx[j] hy[j] hl[j] x y l hw[j] + w
         .
         y += l
      .
      w += abs l
   .
.
#
wire_1
wire_2
mark_start
print min
print minw
#
input_data
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7



