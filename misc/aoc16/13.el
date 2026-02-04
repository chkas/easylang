# AoC-16 - Day 13: A Maze of Twisty Little Cubicles
#
sysconf topleft
visualization = 1
#
inp = number input
nc = 45
len m[] nc * nc
#
gbackground 543
gclear
proc show solve .
   if visualization = 1
      sc = 100 / nc
      for x range0 nc : for y range0 nc
         if solve = 0 and m[x + nc * y] > 0
            gcolor 000
            grect sc * x sc * y sc sc
         elif m[x + nc * y] = 2
            gcolor 500
            gcircle sc * x + sc / 2 sc * y + sc / 2 sc / 4
         .
      .
      sleep 0.05
   .
.
proc mk .
   for x range0 nc
      for y range0 nc
         b = x * x + 3 * x + 2 * x * y + y + y * y + inp
         c = 0
         while b > 0
            c += b mod 2
            b = b div 2
         .
         m[x + y * nc] = c mod 2
      .
   .
.
mk
show 0
p = nc + 1
dest = 31 + 39 * nc
#
todon[] = [ p ]
m[p] = 2
np = 1
#
while len todon[] <> 0 and (part1 = 0 or part2 = 0)
   swap todo[] todon[]
   todon[] = [ ]
   for p in todo[]
      if p = dest and part1 = 0
         part1 = step
      .
      for pn in [ p - nc p + 1 p + nc p - 1 ]
         if pn >= 0 and pn mod nc <> nc - 1 and m[pn] = 0
            todon[] &= pn
            m[pn] = 2
            np += 1
         .
      .
   .
   step += 1
   show 1
   if step = 50 : part2 = np
.
print part1
print part2
#
input_data
10