# AoC-21 - Day 1: Sonar Sweep
#
# Part 2 is interesting, because with a
# sliding window you don't have to compare
# the sum but only the values of the edges. 
#
repeat
  s$ = input
  until s$ = ""
  v4 = v3 ; v3 = v2 ; v2 = v1
  v1 = number s$
  inc1 += if v2 > 0 and v1 > v2
  inc2 += if v4 > 0 and v1 > v4
.
print inc1
print inc2
# 
input_data
199
200
208
210
200
207
240
269
260
263

