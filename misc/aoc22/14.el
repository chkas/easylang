# AoC-22 - Day 14: Regolith Reservoir
#
sysconf topleft
visual = 1
#
nc = 400
len m[] nc * nc / 2
global maxy .
#
proc show p . .
   ra = maxy + 5
   sc = 100 / ra / 2
   sx = nc / 2 - ra
   x = (p - 1) mod nc
   y = (p - 1) div nc
   if m[p] = 2
      color 862
      move (x - sx) * sc + sc / 2 y * sc + sc / 2 + 25
      circle sc / 2
      sleep 0.01
   elif m[p] = 1
      color 555
      move (x - sx) * sc y * sc + 25
      rect sc sc
   else
      color -2
      move (x - sx) * sc y * sc + 25
      rect sc sc
   .
.
proc init . .
   repeat
      s$ = input
      until s$ = ""
      a[] = number strtok s$ " ,"
      for i = 1 step 2 to len a[] - 3
         #      for i = 4 step 3 to len a[]
         xp = a[i] - (500 - nc / 2)
         yp = a[i + 1]
         x = a[i + 2] - (500 - nc / 2)
         y = a[i + 3]
         maxy = higher maxy y
         dx = sign (xp - x)
         dy = sign (yp - y)
         repeat
            m[y * nc + x + 1] = 1
            until x = xp and y = yp
            x += dx
            y += dy
         .
      .
   .
   for x = 0 to nc - 1
      m[(maxy + 2) * nc + x + 1] = 1
   .
   if visual = 1
      for p = 1 to len m[]
         if m[p] = 1 : show p
      .
      sleep 1
   .
.
init
#
proc run . .
   s = nc / 2 + 1
   while 1 = 1
      if part2 = 0 and s >= maxy * nc
         part2 = 1
         print cnt
         if visual = 1 : sleep 1
      .
      m[s] = 0
      show s
      if m[s + nc] = 0
         s += nc
      elif m[s + nc - 1] = 0
         s += nc - 1
      elif m[s + nc + 1] = 0
         s += nc + 1
      else
         m[s] = 2
         cnt += 1
         if visual = 1 : show s
         if s = nc / 2 + 1 : break 1
         s = nc / 2 + 1
      .
      m[s] = 2
      show s
   .
   print cnt
.
run
#
input_data
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
487,14 -> 495,14
516,15 -> 502,15
492,18 -> 503,18
482,22 -> 492,22
494,25 -> 507,25 -> 507,20
