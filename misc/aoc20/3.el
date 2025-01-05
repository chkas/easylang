# AoC-20 - Day 3: Toboggan Trajectory
#
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
proc part1 . .
   i = 1
   for l to len inp$[]
      s$[] = strchars inp$[l]
      if s$[i] = "#" : tree += 1
      i = (i + 2) mod len s$[] + 1
   .
   print tree
.
part1
#
proc part2 . .
   r[] = [ 1 3 5 7 1 ]
   d[] = [ 1 1 1 1 2 ]
   prod = 1
   for k to len r[]
      l = 1
      i = 1
      tree = 0
      while l <= len inp$[]
         s$[] = strchars inp$[l]
         if s$[i] = "#" : tree += 1
         i = (i + r[k] - 1) mod len s$[] + 1
         l += d[k]
      .
      prod *= tree
   .
   print prod
.
part2
#
input_data
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#

