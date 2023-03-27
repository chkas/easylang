# AoC-21 - Day 6: Lanternfish
# 
# The position is irrelevant. Only the
# number of fishes with age 1, 2 .. matters. 
# 
len n[] 9
inp[] = number strsplit input ","
for v in inp[]
   n[v + 1] += 1
.
for day = 1 to 256
   h = n[1]
   for i = 1 to 8
      n[i] = n[i + 1]
   .
   n[9] = h
   n[7] += h
   if day = 80 or day = 256
      sum = 0
      for n in n[]
         sum += n
      .
      print sum
   .
.
input_data
3,4,3,1,2



