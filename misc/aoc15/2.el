# AoC-15 - Day 2: I Was Told There Would Be No Math
# 
repeat
   s$ = input
   until s$ = ""
   d[] = number strsplit s$ "x"
   if d[1] > d[2]
      swap d[1] d[2]
   .
   if d[2] > d[3]
      swap d[2] d[3]
      if d[1] > d[2]
         swap d[1] d[2]
      .
   .
   for i to 3
      for j = i + 1 to 3
         sum += d[i] * d[j] * 2
      .
   .
   sum += d[1] * d[2]
   rib += 2 * d[1] + 2 * d[2] + d[1] * d[2] * d[3]
.
print sum
print rib
# 
input_data
2x3x4
1x1x10

