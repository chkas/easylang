# AoC-21 - Day 9: Smoke Basin
#
# Place a guard border with height 9 around
# it. The determination of the low point is
# straightforward. You can find the basins by
# finding basins of the neighboring points,
# starting from the low points.
#
sysconf topleft
visual = 1
# don't look good with test data
#
global m[] nc nr lowpt[] .
proc show upd .
   if visual = 0 : return
   sc = 100 / nc
   for y range0 nr : for x range0 nc
      pos = y * nc + x + 1
      if upd = 1
         if m[pos] >= 10
            gcolor 432
            grect sc * x sc * y sc sc
         .
      else
         h = m[pos]
         gcolor3 h / 12 + 0.2 h / 12 + 0.1 h / 12
         grect sc * x sc * y sc sc
      .
   .
   if upd = 0 : sleep 1
   sleep 0.01
.
proc part1 .
   inp$ = input
   nc = len inp$ + 2
   for i to nc : m[] &= 9
   repeat
      m[] &= 9
      for i to nc - 2 : m[] &= number substr inp$ i 1
      m[] &= 9
      inp$ = input
      until inp$ = ""
   .
   for i to nc : m[] &= 9
   nr = len m[] div nc
   for i to len m[]
      m = m[i]
      if m < 9 and m[i - 1] > m and m[i + 1] > m and m[i - nc] > m and m[i + nc] > m
         sum += m + 1
         lowpt[] &= i
      .
   .
   print sum
.
part1
show 0
#
proc sort &d[] .
   for i to len d[] - 1
      for j = i + 1 to len d[]
         if d[j] > d[i] : swap d[j] d[i]
      .
   .
.
proc expand pos &sz .
   m[pos] += 10
   sz += 1
   for i in [ pos - 1 pos + 1 pos - nc pos + nc ]
      if m[i] < 9 : expand i sz
   .
.
proc part2 .
   for i to len lowpt[]
      sz = 0
      expand lowpt[i] sz
      lowpt[i] = sz
      show 1
   .
   sort lowpt[]
   print lowpt[1] * lowpt[2] * lowpt[3]
.
part2
#
input_data
2199943210
3987894921
9856789892
8767896789
9899965678
