# AoC-24 - Day 1: Historian Hysteria
#
proc sort . d[] .
   for i = 1 to len d[] - 1
      for j = i + 1 to len d[]
         if d[j] < d[i] : swap d[j] d[i]
      .
   .
.
repeat
   s$ = input
   until s$ = ""
   in[] = number strsplit s$ " "
   a[] &= in[1]
   b[] &= in[2]
.
sort a[]
sort b[]
for i to len a[]
   s1 += abs (a[i] - b[i])
   for v in b[]
      if a[i] = v : s2 += a[i]
   .
.
print s1
print s2
#
input_data
3   4
4   3
2   5
1   3
3   9
3   3
