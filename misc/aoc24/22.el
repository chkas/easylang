# AoC-24 - Day 22: Monkey Market
#
proc next . secr .
   h = secr * 64
   secr = (bitxor h secr) mod 16777216
   h = secr div 32
   secr = bitxor h secr
   h = secr * 2048
   secr = (bitxor h secr) mod 16777216
.
len sq[] 104976
arrbase sq[] 0
sum1 = 0
#
proc do2000 n . .
   len seen[] 104976
   arrbase seen[] 0
   d = n mod 10
   for i to 3
      next n
      dpr = d
      d = n mod 10
      sq = sq * 18 + (d - dpr + 9)
   .
   for i to 1997
      next n
      dpr = d
      d = n mod 10
      sq = (sq * 18 + (d - dpr + 9)) mod 104976
      if seen[sq] = 0
         seen[sq] = 1
         sq[sq] += d
      .
   .
   sum1 += n
.
proc run . .
   repeat
      s$ = input
      until s$ = ""
      do2000 number s$
   .
   print sum1
   for s in sq[] : max = higher s max
   print max
.
run
#
input_data
1
2
3
2024
