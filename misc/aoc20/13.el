# AoC-20 - Day 13: Shuttle Search
# 
tm = number input
s$[] = strsplit input ","
# 
# Part1 
# 
min = 1 / 0
for i to len s$[]
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
for i to len s$[]
   if s$[i] <> "x"
      t = number s$[i]
      while (min + i - 1) mod t <> 0
         min += inc
      .
      inc *= t
   .
.
print min
# 
input_data
939
7,13,x,x,59,x,31,19


