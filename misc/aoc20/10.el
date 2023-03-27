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
      if d[j] < d[i]
         swap d[i] d[j]
      .
   .
.
# 
func part1 . .
   d = d[2]
   for i = 3 to len d[]
      if d[i] - d = 1
         s1 += 1
      elif d[i] - d = 3
         s3 += 1
      .
      d = d[i]
   .
   s1 += 1
   s3 += 1
   print s1 * s3
.
call part1
# 
len cache[] d[len d[] - 1]
# 
func find_ways ind0 . n0 .
   if ind0 = len d[]
      n0 = 1
      break 1
   .
   if cache[ind0] > 0
      n0 = cache[ind0]
      break 1
   .
   n0 = 0
   ind = ind0 + 1
   while ind <= len d[] and d[ind] - d[ind0] <= 3
      call find_ways ind n
      n0 += n
      ind += 1
   .
   cache[ind0] = n0
.
call find_ways 1 n
print n
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

