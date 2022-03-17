# AoC-16 - Day 13: A Maze of Twisty Little Cubicles
# 
visualization = 1
# 
inp = number input
nc = 45
len m[] nc * nc
# 
background 543
clear
func show solve . .
  if visualization = 1
    sc = 100 / nc
    for x range nc
      for y range nc
        if solve = 0 and m[x + nc * y] > 0
          color 000
          move sc * x sc * y
          rect sc sc
        elif m[x + nc * y] = 2
          color 500
          move sc * x + sc / 2 sc * y + sc / 2
          circle sc / 4
        .
      .
    .
    sleep 0.05
  .
.
func mk . .
  for x range nc
    for y range nc
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
call mk
call show 0
p = nc + 1
dest = 31 + 39 * nc
# 
todon[] = [ p ]
m[p] = 2
np = 1
# 
while len todon[] <> 0
  swap todo[] todon[]
  todon[] = [ ]
  for p in todo[]
    if p = dest
      print step
      break 2
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
  call show 1
  if step = 50
    print np
  .
.
# 
input_data
1362




