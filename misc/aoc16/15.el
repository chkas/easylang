# AoC-16 - Day 15: Timing is Everything
# 
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ " "
   npos[] &= number s$[4]
   pos0[] &= number s$[12]
.
# 
func run . .
   repeat
      m = 0
      for i to len npos[]
         m += (pos0[i] + t + i) mod npos[i]
      .
      until m = 0
      t += 1
   .
   print t
.
call run
npos[] &= 11
pos0[] &= 0
call run
# 
input_data
Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.

