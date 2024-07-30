# AoC-17 - Day 19: A Series of Tubes
#
sys topleft
visualization = 1
#
arrbase m[] 0
repeat
   s$ = input
   until s$ = ""
   nc = len s$
   for i to nc
      c$ = substr s$ i 1
      if c$ = " "
         m[] &= 0
      elif strcode c$ >= 65 and strcode c$ <= 90
         m[] &= strcode c$
      else
         m[] &= 1
      .
   .
.
#
len m[] nc * nc
#
for pos range0 nc
   if m[pos] > 0
      break 1
   .
.
#
#
f = 94 / nc
background 000
vis = 0
vis$ = ""
textsize 5
subr show
   if visualization = 0
      break 1
   .
   if vis = 0
      vis = 1
      clear
      color 777
      for r range0 nc
         for c range0 nc
            if m[r * nc + c] = 1
               move c * f r * f
               rect f f
            elif m[r * nc + c] >= 65
               color 900
               move c * f + f / 2 r * f + f / 2
               circle f
               color 777
            .
         .
      .
   else
      r = pos div nc
      c = pos mod nc
      color 070
      move c * f r * f
      rect f f
      move 2 95
      color 555
      text vis$
   .
   sleep 0.001
.
show
#
dirs[] = [ -nc 1 nc -1 ]
dir = 3
while 1 = 1
   steps += 1
   if m[pos] >= 65
      vis$ &= strchar m[pos]
   .
   show
   if m[pos + dirs[dir]] > 0
      dir = dir
   elif m[pos + dirs[dir mod 4 + 1]] > 0
      dir = dir mod 4 + 1
   elif m[pos + dirs[(dir - 2) mod 4 + 1]] > 0
      dir = (dir - 2) mod 4 + 1
   else
      break 1
   .
   pos = pos + dirs[dir]
.
print vis$
print steps
#
#
input_data
     |          
     |  +--+    
     A  |  C    
 F---|----E|--+ 
     |  |  |  D 
     +B-+  +--+ 

