# AoC-21 - Day 13: Transparent Origami
# 
# First of all, the size of the sheet is
# determined. And then all points above
# the fold line (no matter if x or y fold) 
# are placed relative from the double fold 
# downwards. 
# 
visualization = 1
# 
sys topleft
nc = 1500
len m[] nc * nc
len mn[] len m[]
len dim[] 2
# 
proc draw . .
   if visualization = 0
      break 1
   .
   m = 100
   clear
   color 543
   move 4 4
   rect dim[1] / m * 90 + 1 dim[2] / m * 90 + 1
   color -2
   for x range0 m
      for y range0 m
         if m[x + y * nc + 1] = 1
            move 5 + x / m * 90 5 + y / m * 90
            circle 50 / m
         .
      .
   .
   sleep 0.4
.
# 
repeat
   s$ = input
   until s$ = ""
   a[] = number strsplit s$ ","
   m[a[1] + a[2] * nc + 1] = 1
   for i = 1 to 2
      dim[i] = higher (a[i] + 1) dim[i]
   .
.
call draw
repeat
   s$ = input
   until s$ = ""
   a$[] = strsplit s$ " "
   a$[] = strsplit a$[3] "="
   fold = number a$[2]
   d = 1 + if a$[1] = "y"
   for x = 0 to dim[1]
      for y = 0 to dim[2]
         if m[x + y * nc + 1] = 1
            v[] = [ x y ]
            if v[d] > fold
               v[d] = 2 * fold - v[d]
            .
            mn[v[1] + v[2] * nc + 1] = 1
            m[x + y * nc + 1] = 0
         .
      .
   .
   dim[d] = fold
   swap m[] mn[]
   call draw
   if cnt = 0
      for i = 1 to len m[]
         cnt += m[i]
      .
      print cnt
   .
.
# 
input_data
4,28
20,4
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=15
fold along x=11
fold along y=7
fold along x=5



