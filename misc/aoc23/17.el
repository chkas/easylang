# AoC-23 - Day 17: Clumsy Crucible
#
global nc m[] .
proc init .
   s$ = input
   nc = len s$ + 1
   for i to nc : m[] &= 0
   repeat
      for c$ in strchars s$ : m[] &= number c$
      m[] &= 0
      s$ = input
      until s$ = ""
   .
   for i to nc : m[] &= 0
.
init
#
dir[] = [ 1 nc (-1) (-nc) ]
#
global cost[] max .
len todo[][] 100
arrbase todo[][] 0
#
proc add p c d cnt .
   skip = 1
   if cnt = 7
      # part2
      skip = 4
   .
   for i to skip
      p += dir[d]
      c += m[p]
      if m[p] = 0 : return
   .
   it = p * 28 + (cnt - 1) * 4 + (d - 1)
   if c < cost[it]
      cost[it] = c
      max = higher max c
      if max >= len todo[][]
         len todo[][] max + 20
      .
      todo[c][] &= it
      h = p * 28 + (d - 1)
      # optimizing
      for i = 0 to cnt - 2
         if cost[h + i * 4] > c
            cost[h + i * 4] = c
         .
      .
   .
.
#
proc go maxcnt .
   cost[] = [ ]
   for i to len m[] * 28 : cost[] &= 1 / 0
   add (nc + 1) 0 1 maxcnt
   add (nc + 1) 0 2 maxcnt
   #
   while itodo <= max
      for it in todo[itodo][]
         pos = it div 28
         h = it mod 28
         d = h mod 4 + 1
         cnt = h div 4 + 1
         cost = cost[it]
         if cnt > 1
            add pos cost d (cnt - 1)
         .
         if d mod 2 = 1
            add pos cost 2 maxcnt
            add pos cost 4 maxcnt
         else
            add pos cost 1 maxcnt
            add pos cost 3 maxcnt
         .
      .
      itodo += 1
   .
   last = (len m[] - nc - 1) * 28
   min = 1 / 0
   for i = 0 to 27 : min = lower min cost[last + i]
   print min
.
go 3
go 7
#
input_data
2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533