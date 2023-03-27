# AoC-21 - Day 20: Trench Map 
# 
# The infinite grid changes between light
# and dark at each update, because 0 points
# to 1 and 511 to 0. This grid is mapped
# by a 2 elements wide frame.  
# 
global alg[] i0 l0 nc mn[] m[] .
func read . .
   s$[] = strchars input
   for c$ in s$[]
      alg[] &= if c$ = "#"
   .
   s$ = input
   s$ = input
   l0 = len s$
   nc = l0 + 4 + 2 * 50
   len m[] nc * nc
   len mn[] nc * nc
   l2 = l0 div 2
   i0 = nc * (nc div 2) + nc div 2 - l2 - l2 * nc + 1
   i = i0
   for _ to l0
      s$[] = strchars s$
      for x to l0
         m[i] = if s$[x] = "#"
         i += 1
      .
      i += nc - l0
      s$ = input
   .
.
call read
func update . .
   i0 = i0 - nc - 1
   i = i0
   l0 += 2
   for _ to l0
      for _ to l0
         j = i - nc - 1
         v = 0
         for _ to 3
            for _ to 3
               v = v * 2 + m[j]
               j += 1
            .
            j += nc - 3
         .
         mn[i] = alg[v + 1]
         i += 1
      .
      i += nc - l0
   .
   i = i0
   l = l0
   v = alg[1] - m[i - 1]
   # 
   # create border
   for _ to 2
      i = i - nc - 1
      l += 2
      for h = 0 to l - 2
         mn[i + h] = v
         mn[i + (h + 1) * nc] = v
         mn[i + l - 1 + h * nc] = v
         mn[i + (l - 1) * nc + h + 1] = v
      .
   .
   swap mn[] m[]
.
for r to 50
   call update
   if r = 2 or r = 50
      sum = 0
      for m in m[]
         sum += m
      .
      print sum
   .
.
# 
input_data
..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

#..#.
#....
##..#
..#..
..###


