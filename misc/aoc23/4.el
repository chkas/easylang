# AoC-23 - Day 4: Scratchcards
# 
ncard[] = [ 1 1 1 1 1 1 1 1 1 1 ]
repeat
   s$ = input
   until s$ = ""
   ncard[] &= 1
   card += 1
   s$[] = strsplit s$ ":|"
   w[] = number strsplit s$[2] " "
   n[] = number strsplit s$[3] " "
   m = 0
   for w in w[]
      for n in n[]
         m += if w = n
      .
   .
   sum1 += bitshift 1 (m - 1)
   for i = 1 to m
      ncard[card + i] += ncard[card]
   .
   sum2 += ncard[card]
.
print sum1
print sum2
# 
input_data
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11