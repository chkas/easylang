# AoC-24 - Day 6: Guard Gallivant
#
global m0$[] pos0 d0 nc .
proc init .
   s$ = input
   nc = len s$ + 1
   len m0$[] nc
   while s$ <> ""
      for c$ in strchars s$
         m0$[] &= c$
         d = strpos ">v<^" c$
         if d > 0
            pos0 = len m0$[]
            d0 = d
         .
      .
      m0$[] &= ""
      s$ = input
   .
   len m0$[] len m0$[] + nc
.
init
#
dir[] = [ 1 nc -1 (-nc) ]
proc part1 pos d .
   while m0$[pos] <> ""
      while m0$[pos + dir[d]] = "#"
         d = (d + 1) mod1 4
      .
      m0$[pos] = "x"
      pos += dir[d]
   .
   for c$ in m0$[] : cnt += if c$ = "x"
   print cnt
.
part1 pos0 d0
#
func test mark pos d .
   m$[] = m0$[]
   m$[mark] = "#"
   while m$[pos] <> ""
      while m$[pos + dir[d]] = "#"
         if strpos m$[pos] d <> 0 : return 1
         m$[pos] &= d
         d = (d + 1) mod1 4
      .
      pos += dir[d]
   .
   return 0
.
proc part2 .
   for i to len m0$[]
      if m0$[i] = "x" and i <> pos0
         sum += test i pos0 d0
      .
   .
   print sum
.
part2
#
input_data
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
