# AoC-17 - Day 13: Packet Scanners
#
len fw[] 100
#
repeat
   s$ = input
   until s$ = ""
   h[] = number strsplit s$ " "
   fw[h[1]] = h[2] * 2 - 2
.
for i range0 100
   if fw[i] > 0 and (i + d) mod fw[i] = 0
      sum += i * (fw[i] + 2) div 2
   .
.
print sum
for d range0 10000000
   for i range0 100
      if fw[i] > 0 and (i + d) mod fw[i] = 0 : break 1
   .
   if i = 100
      print d
      break 1
   .
.
#
input_data
0: 3
1: 2
4: 4
6: 4


