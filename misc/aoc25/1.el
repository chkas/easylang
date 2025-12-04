# AoC-25 - Day 1: Secret Entrance
#
pos = 50
repeat
   s$ = input
   until s$ = ""
   tck = number substr s$ 2 99
   if substr s$ 1 1 = "L"
      cnt2 += (tck + (100 - pos) mod 100) div 100
      pos = (pos - tck) mod 100
   else
      cnt2 += (tck + pos) div 100
      pos = (pos + tck) mod 100
   .
   cnt1 += if pos = 0
.
print cnt1
print cnt2
#
input_data
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
