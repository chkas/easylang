# AoC-20 - Day 1: Report Repair
# 
repeat
   s$ = input
   until s$ = ""
   f[] &= number s$
.
n = len f[]
for i to n - 1
   for j = i + 1 to n
      if f[i] + f[j] = 2020
         print f[i] * f[j]
         break 2
      .
   .
.
for i to n - 2
   for j = i + 1 to n - 1
      for k = j + 1 to n
         if f[i] + f[j] + f[k] = 2020
            print f[i] * f[j] * f[k]
            break 3
         .
      .
   .
.
# 
input_data
1721
979
366
299
675
1456

