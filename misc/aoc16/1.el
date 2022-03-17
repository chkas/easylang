# AoC-16 - Day 1: No Time for a Taxicab
# 
nc = 2000
nc2 = nc div 2
s$[] = strsplit input " "
d[] = [ -nc 1 nc -1 ]
len seen[] nc * nc
p = nc2 + nc * nc2
for v$ in s$[]
  s = number substr v$ 1 99
  if substr v$ 0 1 = "R"
    d = (d + 1) mod 4
  else
    d = (d - 1) mod 4
  .
  for i range s
    p += d[d]
    if seen[p] = 1 and done2 = 0
      done2 = 1
      print abs (p mod nc - nc2) + abs (p div nc - nc2)
    .
    seen[p] = 1
  .
.
print abs (p mod nc - nc2) + abs (p div nc - nc2)
# 
input_data
R3, L2, L2, R4, L1, R2, R3, R4, L2, R4, L2, L5, L1, R5, R2, R2, L1, R4, R1, L5, L3, R4, R3, R1, L1, L5, L4, L2, R5, L3, L4, R3, R1, L3, R1, L3, R3, L4, R2, R5, L190, R2, L3, R47, R4, L3, R78, L1, R3, R190, R4, L3, R4, R2, R5, R3, R4, R3, L1, L4, R3, L4, R1, L4, L5, R3, L3, L4, R1, R2, L4, L3, R3, R3, L2, L5, R1, L4, L1, R5, L5, R1, R5, L4, R2, L2, R1, L5, L4, R4, R4, R3, R2, R3, L1, R4, R5, L2, L5, L4, L1, R4, L4, R4, L4, R1, R5, L1, R1, L5, R5, R1, R1, L3, L1, R4, L1, L4, L4, L3, R1, R4, R1, R1, R2, L5, L2, R4, L1, R3, L5, L2, R5, L4, R5, L5, R3, R4, L3, L3, L2, R2, L5, L5, R3, R4, R3, R4, R3, R1


