# AoC-24 - Day 6: Guard Gallivant
#
global m0[] pos0 d0 nc .
proc init . .
   s$ = input
   nc = len s$ + 2
   len m0[] nc
   while s$ <> ""
      m0[] &= 0
      for c$ in strchars s$
         if c$ = "."
            m0[] &= 1
         elif c$ = "#"
            m0[] &= 2
         else
            m0[] &= 3
            d0 = strpos ">v<^" c$
            pos0 = len m0[]
         .
      .
      m0[] &= 0
      s$ = input
   .
   len m0[] len m0[] + nc
.
init
#
dir[] = [ 1 nc -1 (-nc) ]
proc part1 . .
   m[] = m0[]
   pos = pos0
   d = d0
   while m[pos] <> 0
      while m[pos + dir[d]] = 2 : d = (d + 1) mod1 4
      m[pos] = 3
      pos += dir[d]
   .
   for v in m[] : cnt += if v = 3
   print cnt
.
part1
#
func test mark .
   m[] = m0[]
   pos = pos0
   d = d0
   m[mark] = 2
   while m[pos] <> 0
      while m[pos + dir[d]] = 2
         h = bitshift 2 d
         if bitand m[pos] h > 0 : return 1
         m[pos] = bitor m[pos] h
         d = (d + 1) mod1 4
      .
      pos += dir[d]
   .
   return 0
.
proc part2 . .
   for i to len m0[]
      if m0[i] = 1 : sum += test i
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
