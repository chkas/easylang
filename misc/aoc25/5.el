# AoC-25 - Day 5: Cafeteria
#
proc sort &d[] &e[] .
   for i = 1 to len d[] - 1 : for j = i + 1 to len d[]
      if d[j] < d[i]
         swap d[j] d[i]
         swap e[j] e[i]
      .
   .
.
repeat
   s$ = input
   until s$ = ""
   h[] = number strtok s$ "-"
   a[] &= h[1]
   b[] &= h[2]
.
sort a[] b[]
#
i = 1
repeat
   a = a[i]
   b = b[i]
   repeat
      i += 1
      until i > len a[] or a[i] > b
      b = higher b[i] b
   .
   an[] &= a
   bn[] &= b
   until i > len a[]
.
repeat
   s$ = input
   until s$ = ""
   n = number s$
   for i to len an[]
      if n >= an[i] and n <= bn[i]
         cnt += 1
         break 1
      .
   .
.
for i to len an[]
   cnt2 += bn[i] - an[i] + 1
.
print cnt
print cnt2
#
input_data
3-5
10-14
16-20
12-18

1
5
8
11
17
32
