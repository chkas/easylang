# AoC-24 - Day 22: Monkey Market
#
proc next &secr .
   secr = (bitxor (secr * 64) secr) mod 16777216
   secr = bitxor (secr div 32) secr
   secr = (bitxor (secr * 2048) secr) mod 16777216
.
len bananas[] 104976
#
sum1 = 0
proc do2000 n .
   len seen[] 104976
   dig = n mod 10
   for i to 3
      next n
      digpr = dig
      dig = n mod 10
      cod = cod * 18 + (dig - digpr + 9)
   .
   for i to 1997
      next n
      digpr = dig
      dig = n mod 10
      cod = (cod * 18 + (dig - digpr + 9)) mod 104976
      if seen[cod] = 0
         seen[cod] = 1
         bananas[cod] += dig
      .
   .
   sum1 += n
.
proc run .
   repeat
      s$ = input
      until s$ = ""
      do2000 number s$
   .
   print sum1
   for b in bananas[] : max = higher b max
   print max
.
run
#
input_data
1
2
3
2024
