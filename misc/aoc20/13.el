# AoC-20 - Day 13: Shuttle Search
# 
tm = number input
s$[] = strsplit input ","
# 
# Part1 
# 
min = 1 / 0
for i range len s$[]
  if s$[i] <> "x"
    t = number s$[i]
    h = t - tm mod t
    if h < min
      min = h
      minbus = t
    .
  .
.
print min * minbus
# 
# Part2
# 
inc = 1
for i range len s$[]
  if s$[i] <> "x"
    t = number s$[i]
    while (min + i) mod t <> 0
      min += inc
    .
    inc *= t
  .
.
print min
# 
input_data
1002561
17,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,409,x,29,x,x,x,x,x,x,x,x,x,x,13,x,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,373,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,19


