# AoC-20 - Day 10: Adapter Array
#
d[] &= 0
repeat
   s$ = input
   until s$ = ""
   d[] &= number s$
.
# sort
for i to len d[] - 1
   for j = i to len d[]
      if d[j] < d[i] : swap d[i] d[j]
   .
.
#
proc part1 .
   for i = 2 to len d[]
      if d[i] - d[i - 1] = 1
         s1 += 1
      elif d[i] - d[i - 1] = 3
         s3 += 1
      .
   .
   print s1 * (s3 + 1)
.
part1
#
len cache[] d[$]
#
func find_ways ind0 .
   if ind0 = len d[] : return 1
   if cache[ind0] > 0 : return cache[ind0]
   ind = ind0 + 1
   while ind <= len d[] and d[ind] - d[ind0] <= 3
      n += find_ways ind
      ind += 1
   .
   cache[ind0] = n
   return n
.
print find_ways 1
#
input_data
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
