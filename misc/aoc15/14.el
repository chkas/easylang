# AoC-15 - Day 14: Reindeer Olympics
# 
repeat
  s$ = input
  until s$ = ""
  s$[] = strsplit s$ " "
  s[] &= number s$[3]
  d[] &= number s$[6]
  r[] &= number s$[13]
.
n = len s[]
len km[] n
len pts[] n
# 
for sec = 1 to 2503
  max = 0
  for i range n
    km = (sec div (d[i] + r[i])) * s[i] * d[i]
    r = sec mod (d[i] + r[i])
    km += (lower r d[i]) * s[i]
    km[i] = km
    max = higher max km
  .
  for i range n
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
Dancer can fly 27 km/s for 5 seconds, but then must rest for 132 seconds.
Cupid can fly 22 km/s for 2 seconds, but then must rest for 41 seconds.
Rudolph can fly 11 km/s for 5 seconds, but then must rest for 48 seconds.
Donner can fly 28 km/s for 5 seconds, but then must rest for 134 seconds.
Dasher can fly 4 km/s for 16 seconds, but then must rest for 55 seconds.
Blitzen can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
Prancer can fly 3 km/s for 21 seconds, but then must rest for 40 seconds.
Comet can fly 18 km/s for 6 seconds, but then must rest for 103 seconds.
Vixen can fly 18 km/s for 5 seconds, but then must rest for 84 seconds.


