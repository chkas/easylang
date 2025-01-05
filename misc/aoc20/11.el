# AoC-20 - Day 11: Seating System
#
global seat[] nc .
proc read . .
   s$ = input
   nc = len s$ + 2
   for i to nc : seat[] &= 2
   while s$ <> ""
      s$[] = strchars s$
      seat[] &= 2
      for i to len s$[] : seat[] &= if s$[i] <> "."
      seat[] &= 2
      s$ = input
   .
   for i to nc : seat[] &= 2
.
read
dirs[] = [ (-nc - 1) (-nc) (-nc + 1) (-1) 1 nc - 1 nc nc + 1 ]
#
proc part1 . .
   len pn[] len seat[]
   len p[] len seat[]
   repeat
      swap pn[] p[]
      stable = 1
      for i to len seat[] : if seat[i] = 1
         s = 0
         for dir in dirs[] : s += p[i + dir]
         if s >= 4
            pn[i] = 0
         elif s = 0
            pn[i] = 1
         else
            pn[i] = p[i]
         .
         if pn[i] <> p[i] : stable = 0
      .
      until stable = 1
   .
   for i to len pn[] : sum += pn[i]
   print sum
.
part1
#
proc part2 . .
   len f[] len seat[]
   len p[] len seat[]
   repeat
      swap f[] p[]
      stable = 1
      for i to len seat[] : if seat[i] = 1
         s = 0
         for dir in dirs[]
            k = i
            repeat
               k += dir
               until seat[k] <> 0
            .
            s += p[k]
         .
         if s >= 5
            f[i] = 0
         elif s = 0
            f[i] = 1
         else
            f[i] = p[i]
         .
         if f[i] <> p[i] : stable = 0
      .
      until stable = 1
   .
   for i to len f[] : sum += f[i]
   print sum
.
part2
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
