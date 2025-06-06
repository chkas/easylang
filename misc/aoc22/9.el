# AoC-22 - Day 9: Rope Bridge
#
sysconf topleft
visual = 1
#
n = 600
len m[] n * n
global xc yc rx[] ry[] cnt s$[] .
gtextsize 2.5
#
proc show .
   gclear
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
   for y = 0 to 100 : for x = 0 to 100
      x1 = xc - 50 + x
      y1 = yc - 50 + y
      if m[y1 * n + x1] = 1
         gcircle x + 0.5 y + 0.5 0.3
      .
      for i = 1 to len rx[]
         if x1 = rx[i] and y1 = ry[i]
            gcircle x + 0.5 y + 0.5 0.7
         .
      .
   .
   gtext 90 97 cnt
   sleep 0.005
.
proc read .
   repeat
      s$ = input
      until s$ = ""
      s$[] &= s$
   .
.
read
#
proc go rl .
   rx[] = [ ]
   ry[] = [ ]
   for h to rl
      rx[] &= n / 2
      ry[] &= n / 2
   .
   for i to len m[] : m[i] = 0
   cnt = 0
   xc = n / 2
   yc = n / 2
   #
   for s$ in s$[]
      d$ = substr s$ 1 1
      for c to number substr s$ 3 9
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
         if visual = 1 : show
      .
   .
   print cnt
.
go 2
go 10
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
