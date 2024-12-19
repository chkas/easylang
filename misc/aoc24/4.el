# AoC-24 - Day 4: Ceres Search
#
s$ = input
nc = len s$ + 3
#
len m$[] 3 * nc + 3
while s$ <> ""
   for c$ in strchars s$ : m$[] &= c$
   for i to 3 : m$[] &= ""
   s$ = input
.
len m$[] len m$[] + 3 * nc
for i to len m$[]
   if m$[i] = "X"
      for d in [ 1 (nc + 1) nc (nc - 1) -1 (-nc - 1) (-nc) (-nc + 1) ]
         if m$[i + d] & m$[i + 2 * d] & m$[i + 3 * d] = "MAS"
            cnt += 1
         .
      .
   .
.
print cnt
#
for i to len m$[]
   a = i + (nc + 1)
   b = i + (-nc - 1)
   c = i + (nc - 1)
   d = i + (-nc + 1)
   if m$[i] = "A"
      if m$[a] = "S" and m$[b] = "M" or m$[a] = "M" and m$[b] = "S"
         if m$[c] = "S" and m$[d] = "M" or m$[c] = "M" and m$[d] = "S"
            cnt2 += 1
         .
      .
   .
.
print cnt2
#
input_data
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX