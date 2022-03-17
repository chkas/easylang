# AoC-16 - Day 15: Timing is Everything
# 
repeat
  s$ = input
  until s$ = ""
  s$[] = strsplit s$ " "
  npos[] &= number s$[3]
  pos0[] &= number s$[11]
.
# 
func run . .
  repeat
    m = 0
    for i range len npos[]
      m += (pos0[i] + t + 1 + i) mod npos[i]
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
Disc #1 has 5 positions; at time=0, it is at position 2.
Disc #2 has 13 positions; at time=0, it is at position 7.
Disc #3 has 17 positions; at time=0, it is at position 10.
Disc #4 has 3 positions; at time=0, it is at position 2.
Disc #5 has 19 positions; at time=0, it is at position 9.
Disc #6 has 7 positions; at time=0, it is at position 0.

Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.

