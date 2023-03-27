# AoC-15 - Day 14: Reindeer Olympics
# 
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ " "
   s[] &= number s$[4]
   d[] &= number s$[7]
   r[] &= number s$[14]
.
n = len s[]
len km[] n
len pts[] n
# 
for sec to 2503
   max = 0
   for i to n
      km = (sec div (d[i] + r[i])) * s[i] * d[i]
      r = sec mod (d[i] + r[i])
      km += (lower r d[i]) * s[i]
      km[i] = km
      max = higher max km
   .
   for i to n
      if km[i] = max
         pts[i] += 1
      .
   .
.
print max
max = 0
for v in pts[]
   max = higher max v
.
print max
# 
# 
input_data
Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.

