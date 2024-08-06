# AoC-22 - Day 9: Rope Bridge
#
sysconf topleft
visual = 1
#
# for part 1: rl = 2
rl = 10
#
n = 600
len m[] n * n
for _ = 1 to rl
   rx[] &= n / 2
   ry[] &= n / 2
.
cnt = 0
#
textsize 2.5
xc = n / 2
yc = n / 2
proc show . .
   clear
   if rx[1] >= xc + 50
      xc += 1
   elif rx[1] <= xc - 50
      xc -= 1
   .
   if ry[1] >= yc + 50
      yc += 1
   elif ry[1] <= yc - 50
      yc -= 1
   .
   for y = 0 to 100
      for x = 0 to 100
         x1 = xc - 50 + x
         y1 = yc - 50 + y
         move x + 0.5 y + 0.5
         if m[y1 * n + x1] = 1
            circle 0.3
         .
         for i = 1 to rl
            if x1 = rx[i] and y1 = ry[i]
               circle 0.7
            .
         .
      .
   .
   move 90 97
   text cnt
   sleep 0.02
.
repeat
   s$ = input
   until s$ = ""
   d$ = substr s$ 1 1
   h = number substr s$ 3 9
   for _ = 1 to h
      if d$ = "U"
         ry[1] -= 1
      elif d$ = "D"
         ry[1] += 1
      elif d$ = "R"
         rx[1] += 1
      elif d$ = "L"
         rx[1] -= 1
      .
      for i = 2 to rl
         dx = rx[i - 1] - rx[i]
         dy = ry[i - 1] - ry[i]
         if abs dx > 1 or abs dy > 1
            rx[i] += sign dx
            ry[i] += sign dy
         .
      .
      if m[ry[rl] * n + rx[rl]] = 0
         m[ry[rl] * n + rx[rl]] = 1
         cnt += 1
      .
      if visual = 1
         show
      .
   .
.
print cnt
#
input_data
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20


