# AoC-25 - 9: Movie Theater
#
sysconf topleft
repeat
   s$ = input
   until s$ = ""
   p[][] &= number strsplit s$ ","
.
func area a[] b[] .
   return (abs (a[1] - b[1]) + 1) * (abs (a[2] - b[2]) + 1)
.
n = len p[][]
if n = 0
   print "need input"
   return
.
sc = 0.001
# sc = 5
proc show .
   glinewidth 0.2
   for i = 1 to len p[][]
      glineto p[i][1] * sc p[i][2] * sc
   .
   glineto p[1][1] * sc p[1][2] * sc
.
proc rect a[] b[] col .
   glinewidth 0.2
   gcolor col
   gpenup
   glineto a[1] * sc a[2] * sc
   glineto b[1] * sc a[2] * sc
   glineto b[1] * sc b[2] * sc
   glineto a[1] * sc b[2] * sc
   glineto a[1] * sc a[2] * sc
.
show
proc part1 .
   for i = 1 to n - 1 : for j = i + 1 to n
      a = area p[i][] p[j][]
      if a > max
         max = a
         mi = i
         mj = j
      .
   .
   rect p[mi][] p[mj][] 800
   print max
.
part1
#
func check xl xh yl yh .
   for i = 1 to len p[][]
      x = p[i][1]
      y = p[i][2]
      if x > xl and x < xh and y > yl and y < yh
         return 0
      .
   .
   return 1
.
proc upd_points .
   # Inserting control points for long distances
   for i = 2 step 2 to n - 1
      d = abs (p[i][1] - p[i + 1][1])
      stps = 10000
      # stps = 2
      if d > stps
         a = p[i][1]
         b = p[i + 1][1]
         if a > b : swap a b
         repeat
            a += stps
            until a > b
            n[][] &= [ a p[i][2] ]
         .
      .
   .
   for i to len n[][]
      p[][] &= n[i][]
   .
.
proc part2 .
   upd_points
   for i = 1 to n - 1 : for j = i + 1 to n
      a = area p[i][] p[j][]
      if a > max
         xl = p[i][1]
         xh = p[j][1]
         if xl > xh : swap xl xh
         yl = p[i][2]
         yh = p[j][2]
         if yl > yh : swap yl yh
         if check xl xh yl yh = 1
            max = a
            mi = i
            mj = j
         .
      .
   .
   rect p[mi][] p[mj][] 050
   print max
.
part2
#
input_data
