# AoC-24 - Day 8: Resonant Collinearity
#
repeat
   s$ = input
   until s$ = ""
   m$[][] &= strchars s$
.
nc = len m$[1][]
nr = len m$[][]
#
func inside r c .
   return if r <= nr and c <= nc and r > 0 and c > 0
.
proc run part .
   len a[][] nr
   for i to nr : len a[i][] nc
   #
   for r to nr : for c to nc
      c$ = m$[r][c]
      if c$ <> "." : for ra to nr : for ca to nc
         if m$[ra][ca] = c$ and (ra <> r or ca <> c)
            rh = r
            ch = c
            if part = 1
               rh -= ra - r
               ch -= ca - c
               if inside rh ch = 1
                  a[rh][ch] = 1
               .
            else
               while inside rh ch = 1
                  a[rh][ch] = 1
                  rh -= ra - r
                  ch -= ca - c
               .
            .
         .
      .
   .
   for r to nr : for c to nc : cnt += a[r][c]
   print cnt
.
run 1
run 2
#
input_data
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
