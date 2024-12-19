# AoC-24 - Day 16: Reindeer Maze
#
global nc m$[] seen[] start ende n .
proc init . .
   s$ = input
   nc = len s$
   while s$ <> ""
      for c$ in strchars s$
         if c$ = "S"
            m$[] &= "."
            start = len m$[]
         elif c$ = "E"
            m$[] &= "."
            ende = len m$[]
         else
            m$[] &= c$
         .
      .
      s$ = input
   .
   n = len m$[]
   for i to n * 5 : seen[] &= 1 / 0
.
init
proc show . .
   for i to len m$[]
      s$ &= m$[i]
      if i mod nc = 0
         print s$
         s$ = ""
      .
   .
.
offs[] = [ 1 nc -1 (-nc) ]
len prev[][] len seen[]
todo[] = [ start + n ]
#
proc check pind np d cost . .
   inds = d * n + np
   if m$[np] = "#" or cost > seen[inds] : return
   if cost < seen[inds] : prev[inds][] = [ ]
   for i in prev[inds][] : if i = pind : return
   prev[inds][] &= pind
   seen[inds] = cost
   todo[] &= inds
.
proc findmin . .
   mincost = 1 / 0
   seen[start + n] = 0
   while len todo[] > 0
      for i to len todo[] - 1
         if seen[todo[i]] < seen[todo[$]] : swap todo[i] todo[$]
      .
      sind = todo[$]
      len todo[] -1
      cost = seen[sind]
      d = sind div n
      p = sind mod n
      if cost > mincost : break 1
      if p = ende : mincost = cost
      check sind (p + offs[d]) d (cost + 1)
      check sind (p + offs[(d - 1) mod1 4]) ((d - 1) mod1 4) (cost + 1001)
      check sind (p + offs[(d + 1) mod1 4]) ((d + 1) mod1 4) (cost + 1001)
   .
   print mincost
.
findmin
#
proc markpath sind . .
   if sind = 0 : return
   m$[sind mod n] = "O"
   for ind in prev[sind][] : markpath ind
.
proc countany . .
   for d to 4 : markpath ende + d * n
   for c$ in m$[] : sum += if c$ = "O"
   print sum
.
countany
#
input_data
#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################
