# AoC-19 - Day 3: Crossed Wires
# 
sys topleft
w1$[] = strsplit input ","
w2$[] = strsplit input ","
# 
proc split s$ . d$ l .
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
hx[] = [ ]
hy[] = [ ]
hw[] = [ ]
hl[] = [ ]
vx[] = [ ]
vy[] = [ ]
vw[] = [ ]
vl[] = [ ]
# 
proc wire_1 . .
   for i = 1 to len w1$[]
      call split w1$[i] d$ l
      if d$ = "L" or d$ = "R"
         hx[] &= x
         hy[] &= y
         hw[] &= w
         w += l
         if d$ = "L"
            l = -l
         .
         hl[] &= l
         call drawline 990 x y x + l y
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
         call drawline 990 x y x y + l
         y += l
      .
   .
.
proc between v a l . r .
   b = a + l
   if a > b
      swap a b
   .
   if v > a and v < b
      r = 1
   else
      r = 0
   .
.
proc intersect xh yh lh xv yv lv w . .
   call between yh yv lv r
   if r = 1
      call between xv xh lh r
      if r = 1
         w += abs (xv - xh) + abs (yv - yh)
         call mark xv yh
         d = abs xv + abs yh
         if d < min
            min = d
         .
         if w < minw
            minw = w
         .
      .
   .
.
proc wire_2 . .
   for i = 1 to len w2$[]
      call split w2$[i] d$ l
      if d$ = "L" or d$ = "R"
         if d$ = "L"
            l = -l
         .
         call drawline 099 x y x + l y
         for j = 1 to len vx[]
            call intersect x y l vx[j] vy[j] vl[j] vw[j] + w
         .
         x += l
      else
         if d$ = "U"
            l = -l
         .
         call drawline 099 x y x y + l
         for j = 1 to len hx[]
            call intersect hx[j] hy[j] hl[j] x y l hw[j] + w
         .
         y += l
      .
      w += abs l
   .
.
# 
call wire_1
call wire_2
call mark_start
print min
print minw
# 
input_data
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7




