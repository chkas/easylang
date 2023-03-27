# AoC-16 - Day 1: No Time for a Taxicab
# 
nc = 2000
nc2 = nc div 2
s$[] = strsplit input " "
d[] = [ -nc 1 nc -1 ]
len seen[] nc * nc
# 
p = nc2 + nc * nc2
for v$ in s$[]
   s = number substr v$ 2 99
   if substr v$ 1 1 = "R"
      d = d mod 4 + 1
   else
      d = (d - 2) mod 4 + 1
   .
   for i range0 s
      p += d[d]
      if seen[p] = 1 and part2 = 0
         part2 = abs (p mod nc - nc2) + abs (p div nc - nc2)
      .
      seen[p] = 1
   .
.
print abs (p mod nc - nc2) + abs (p div nc - nc2)
print part2
# 
input_data
R8, R4, R4, R8


