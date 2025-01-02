# AoC-21 - Day 6: Lanternfish
#
# The position is irrelevant. Only the
# number of fishes with age 0, 1, 2 .. matters.
#
len n[] 9
arrbase n[] 0
#
for v in number strtok input ","
   n[v] += 1
.
for day = 1 to 256
   h = n[0]
   for i = 0 to 7
      n[i] = n[i + 1]
   .
   n[8] = h
   n[6] += h
   if day = 80 or day = 256
      sum = 0
      for n in n[] : sum += n
      print sum
   .
.
input_data
3,4,3,1,2


