# AoC-22 - Day 4: Camp Cleanup
#
repeat
   s$ = input
   until s$ = ""
   a[] = number strtok s$ "-,"
   if a[1] <= a[3] and a[2] >= a[4] or a[1] >= a[3] and a[2] <= a[4]
      sum += 1
   .
   if a[3] <= a[2] and a[1] <= a[4]
      sum2 += 1
   .
.
print sum
print sum2
#
input_data
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8

