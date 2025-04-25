# AoC-21 - Day 7: The Treachery of Whales
#
# Straightforward. For part 2: 
# 1 + 2 .. + n = n * (n + 1) / 2
#
inp[] = number strsplit input ","
proc run part .
  min = 1 / 0
  for i = 0 to 1999
    fuel = 0
    for v in inp[]
      d = abs (i - v)
      if part = 2
        d = d * (d + 1) / 2
      .
      fuel += d
    .
    min = lower min fuel
  .
  print min
.
run 1
run 2
# 
input_data
16,1,2,0,4,2,7,1,2,14





