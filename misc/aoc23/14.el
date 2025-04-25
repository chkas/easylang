# AoC-23 - Day 14: Parabolic Reflector Dish
# 
repeat
   s$ = input
   until s$ = ""
   m$[][] &= strchars s$
.
nc = len m$[1][]
nr = len m$[][]
# 
proc north .
   for c to nc
      for r to nr - 1
         if m$[r][c] = "."
            r1 = r + 1
            while r1 < nr and m$[r1][c] = "."
               r1 += 1
            .
            if m$[r1][c] = "O"
               m$[r1][c] = "."
               m$[r][c] = "O"
            .
         .
      .
   .
.
proc south .
   for c to nc
      for r = nr downto 2
         if m$[r][c] = "."
            r1 = r - 1
            while r1 > 1 and m$[r1][c] = "."
               r1 -= 1
            .
            if m$[r1][c] = "O"
               m$[r1][c] = "."
               m$[r][c] = "O"
            .
         .
      .
   .
.
proc east .
   for r to nr
      for c to nc - 1
         if m$[r][c] = "."
            c1 = c + 1
            while c1 < nr and m$[r][c1] = "."
               c1 += 1
            .
            if m$[r][c1] = "O"
               m$[r][c1] = "."
               m$[r][c] = "O"
            .
         .
      .
   .
.
proc west .
   for r to nr
      for c = nc downto 2
         if m$[r][c] = "."
            c1 = c - 1
            while c1 > 1 and m$[r][c1] = "."
               c1 -= 1
            .
            if m$[r][c1] = "O"
               m$[r][c1] = "."
               m$[r][c] = "O"
            .
         .
      .
   .
.
func load .
   for c to nc
      for r to nr
         if m$[r][c] = "O"
            sum += nr + 1 - r
         .
      .
   .
   return sum
.
# part 1
north
print load
# 
proc cycle .
   north
   east
   south
   west
.
len hist[] 1000
proc part2 .
   for cy to 50
      cycle
      hist[cy] = load
   .
   for cy = 51 to 1000
      cycle
      hist[cy] = load
      for i = cy - 20 downto 20
         for j to 10
            if hist[cy - 10 + j] <> hist[i + j]
               break 1
            .
         .
         if j = 11
            cyclen = cy - 10 - i
            break 2
         .
      .
   .
   if i > 1000
      print "not found"
   .
   print hist[i + ((1000000000 - i) mod cyclen)]
.
part2
# 
input_data
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
