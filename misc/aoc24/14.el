# AoC-24 - Day 14: Restroom Redoubt
#
repeat
   s$ = input
   until s$ = ""
   a[] = number strtok s$ "=,"
   px[] &= a[1]
   py[] &= a[2]
   vx[] &= a[3]
   vy[] &= a[4]
   n = len px[]
.
nx = 101
ny = 103
#
proc part1 . .
   len q[] 4
   for i to n
      ex = (px[i] + vx[i] * 100) mod nx
      ey = (py[i] + vy[i] * 100) mod ny
      if ex <> nx div 2 and ey <> ny div 2
         q1 = ex div (nx div 2)
         if q1 = 2 : q1 = 1
         q2 = ey div (ny div 2)
         if q2 = 2 : q2 = 1
         q[q1 + 2 * q2 + 1] += 1
      .
   .
   r = 1
   for v in q[] : r *= v
   print r
.
part1
#
proc show nsec . .
   clear
   for i to n
      ex = (px[i] + vx[i] * nsec) mod nx
      ey = (py[i] + vy[i] * nsec) mod ny
      move ex 100 - ey
      circle 0.5
   .
   sleep 0.001
.
proc part2 . .
   repeat
      nsec += 1
      m[] = [ ]
      len m[] nx * ny
      for i to n
         ex = (px[i] + vx[i] * nsec) mod nx
         ey = (py[i] + vy[i] * nsec) mod ny
         m[ey * nx + ex + 1] = 1
      .
      cnt = 0
      for m in m[]
         if m = 1 and mp = 1 : cnt += 1
         mp = m
      .
      until cnt > n / 5
      # show nsec
   .
   print nsec
   show nsec
.
part2
#
input_data
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
