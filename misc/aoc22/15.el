# AoC-22 - Day 15: Beacon Exclusion Zone
# 
# for test data
max_coord = 20
# 
global sx[] sy[] dist[] bline .
proc init . .
   repeat
      s$ = input
      until s$ = ""
      a[] = number strsplit s$ "=,:"
      sx[] &= a[2]
      sy[] &= a[4]
      d = abs (a[2] - a[6]) + abs (a[4] - a[8])
      if max_coord = 20 and d > 100
         # for real data
         max_coord = 4000000
      .
      if a[8] = max_coord div 2
         for i = 1 to len b[]
            if a[6] = b[i]
               break 1
            .
         .
         if i > len b[]
            b[] &= a[6]
         .
      .
      dist[] &= d
      i = len sx[]
      while i > 1 and sx[i] < sx[i - 1]
         swap sx[i] sx[i - 1]
         swap sy[i] sy[i - 1]
         swap dist[i] dist[i - 1]
         i -= 1
      .
   .
   bline = len b[]
.
init
n = len sx[]
# 
proc get_ranges y . xa[] xb[] .
   xs = 1
   xa[] = [ ]
   xb[] = [ ]
   while xs < n
      xa = 1 / 0
      xb = -1 / 0
      for s = xs to n
         d = dist[s] - abs (y - sy[s])
         if d >= 0
            a = sx[s] - d
            b = sx[s] + d
            if xa = 1 / 0 or a - 1 <= xb
               xa = lower xa a
               xb = higher xb b
               xs = s + 1
            .
         .
      .
      if xa = 1 / 0
         break 1
      .
      xa[] &= xa
      xb[] &= xb
   .
.
get_ranges max_coord div 2 xa[] xb[]
sum = -bline
for i = 1 to len xa[]
   sum += xb[1] - xa[1] + 1
.
print sum
# 
for y = 1 to max_coord
   get_ranges y xa[] xb[]
   if len xa[] = 2 and xb[1] + 2 = xa[2]
      print (xb[1] + 1) * 4000000 + y
      break 1
   .
.
# 
input_data
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3


