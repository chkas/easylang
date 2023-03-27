# AoC-15 - Day 20: Infinite Elves and Infinite Houses
# 
n = number input
# 
for part to 2
   len f[] 0
   len f[] n div 10
   for i = 2 to len f[]
      j = i
      cnt = 0
      while j <= len f[]
         f[j] += 10 * i
         if part = 2
            f[j] += i
            if cnt = 50
               break 1
            .
         .
         cnt += 1
         j += i
      .
   .
   i = 1
   while f[i] < n
      i += 1
   .
   print i
.
# 
input_data
1000

