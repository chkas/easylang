# AoC-17 - Day 19: A Series of Tubes
#
sysconf topleft
visualization = 1
#
repeat
   s$ = input
   until s$ = ""
   nc = len s$
   for i to nc
      c$ = substr s$ i 1
      if c$ = " " or c$ = "."
         m[] &= 0
      elif strcode c$ >= 65 and strcode c$ <= 90
         m[] &= strcode c$
      else
         m[] &= 1
      .
   .
   m[] &= 0
   nr += 1
.
nc += 1
#
len m[] nc * (nr + 1)
#
for pos to nc
   if m[pos] > 0 : break 1
.
#
f = 94 / nc
gbackground 000
vis = 0
vis$ = ""
gtextsize 5
subr show
   if visualization = 0 : return
   if vis = 0
      vis = 1
      gclear
      gcolor 777
      for r range0 nr : for c range0 nc
         ind = r * nc + c + 1
         if m[ind] = 1
            grect c * f r * f f f
         elif m[ind] >= 65
            gcolor 900
            gcircle c * f + f / 2 r * f + f / 2 f
            gcolor 777
         .
      .
   else
      r = (pos - 1) div nc
      c = (pos - 1) mod nc
      gcolor 070
      grect c * f r * f f f
      gcolor 555
      gtext 2 95 vis$
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
      #
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
     |        .
     |  +--+  .
     A  |  C  .
 F---|----E|--+
     |  |  |  D
     +B-+  +--+
