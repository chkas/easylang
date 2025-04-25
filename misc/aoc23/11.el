# AoC-23 - Day 11: Cosmic Expansion
# 
repeat
   s$ = input
   until s$ = ""
   row += 1
   s$[] = strchars s$
   for col to len s$[]
      c$ = s$[col]
      if c$ = "#"
         row0[] &= row
         col0[] &= col
      .
   .
.
len hasrow[] row
len hascol[] len s$[]
n = len col0[]
for i to n
   hasrow[row0[i]] = 1
   hascol[col0[i]] = 1
.
proc calc row[] col[] expans .
   for i to len hasrow[]
      addr += if hasrow[i] = 0
      addrow[] &= addr * expans
   .
   for i to len hascol[]
      addc += if hascol[i] = 0
      addcol[] &= addc * expans
   .
   for i to n
      row[i] += addrow[row[i]]
      col[i] += addcol[col[i]]
   .
   for i = 1 to n - 1
      for j = i + 1 to n
         d = abs (col[i] - col[j])
         d += abs (row[i] - row[j])
         sum += d
      .
   .
   print sum
.
calc row0[] col0[] 1
calc row0[] col0[] 999999
#
input_data
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....

