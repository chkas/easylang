# AoC-20 - Day 11: Seating System
# 
global seat[] nc .
func read . .
   s$ = input
   nc = len s$ + 2
   for i to nc
      seat[] &= 2
   .
   while s$ <> ""
      s$[] = strchars s$
      seat[] &= 2
      for i to len s$[]
         seat[] &= if s$[i] <> "."
      .
      seat[] &= 2
      s$ = input
   .
   for i to nc
      seat[] &= 2
   .
.
call read
len f[] len seat[]
len p[] len seat[]
# 
global is_part1 .
func look i dir . s .
   if is_part1 = 1
      i += dir
   else
      repeat
         i += dir
         until seat[i] <> 0
      .
   .
   s += p[i]
.
len stable[] len f[]
# 
func run . .
   nrow = len seat[] / nc
   for i to len f[]
      f[i] = 0
      p[i] = 0
      stable[i] = 0
   .
   repeat
      swap f[] p[]
      stable = 1
      for r = 0 to nrow - 2
         h = r * nc + nc + 1
         for i = h + 1 to h + nc - 1
            if seat[i] = 1 and stable[i] <> 1
               s = 0
               for dir in [ (-nc - 1) (-nc) (-nc + 1) (-1) 1 nc - 1 nc nc + 1 ]
                  call look i dir s
               .
               if is_part1 = 1 and s >= 4 or s >= 5
                  f[i] = 0
               elif s = 0
                  f[i] = 1
               else
                  f[i] = p[i]
               .
               if f[i] <> p[i]
                  stable = 0
               else
                  stable[i] = 1
               .
            .
         .
      .
      until stable = 1
   .
   for i to len f[]
      sum += f[i]
   .
   print sum
.
is_part1 = 1
call run
is_part1 = 0
call run
# 
# 
input_data
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL



