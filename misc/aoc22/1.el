# AoC-22 - Day 1: Calorie Counting
# 
repeat
   s$ = input
   until s$ = ""
   sum = 0
   while s$ <> ""
      sum += number s$
      s$ = input
   .
   a[] &= sum
.
for k = 1 to 3
   for i = k + 1 to len a[]
      if a[i] > a[k]
         swap a[k] a[i]
      .
   .
.
print a[1]
print a[1] + a[2] + a[3]
# 
input_data
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

