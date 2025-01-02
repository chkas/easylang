# AoC-23 - Day 13: Point of Incidence
#
global m$[][] nc nr .
func gval nerr .
   for col to nc - 1
      err = 0
      l = lower col (nc - col)
      for c to l : for r to nr
         if m$[r][col - c + 1] <> m$[r][col + c]
            err += 1
         .
      .
      if err = nerr : return col
   .
   for row to nr - 1
      err = 0
      l = lower row (nr - row)
      for r to l : for c to nc
         if m$[row - r + 1][c] <> m$[row + r][c]
            err += 1
         .
      .
      if err = nerr : return 100 * row
   .
   return 0
.
repeat
   s$ = input
   until s$ = ""
   m$[][] = [ ]
   repeat
      m$[][] &= strchars s$
      s$ = input
      until s$ = ""
   .
   nc = len m$[1][]
   nr = len m$[][]
   sum1 += gval 0
   sum2 += gval 1
.
print sum1
print sum2
#
input_data
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
