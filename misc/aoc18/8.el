# AoC-18 - Day 8: Memory Maneuver
#
f[] = number strsplit input " "
#
proc parse a &b &sum ..
   b = a + 2
   for i to f[a]
      parse b b sum
   .
   for i range0 f[a + 1]
      sum += f[b + i]
   .
   b += i
.
parse 1 h sum
print sum
#
proc parse2 a &b &sum ..
   b = a + 2
   for i to f[a]
      parse2 b b v
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
parse2 1 h sum
print sum
#
input_data
2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2
