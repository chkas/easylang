# AoC-18 - Day 8: Memory Maneuver
# 
f[] = number strsplit input " "
# 
func parse a . b sum .
   b = a + 2
   for i to f[a]
      call parse b b sum
   .
   for i range0 f[a + 1]
      sum += f[b + i]
   .
   b += i
.
call parse 1 _ sum
print sum
# 
func parse2 a . b sum .
   b = a + 2
   for i to f[a]
      call parse2 b b v
      v[] &= v
   .
   sum = 0
   if f[a] = 0
      for i range0 f[a + 1]
         sum += f[b + i]
      .
   else
      for i range0 f[a + 1]
         ind = f[b + i]
         if ind >= 1 and ind <= len v[]
            sum += v[ind]
         .
      .
   .
   b += i
.
call parse2 1 _ sum
print sum
# 
input_data
2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2

