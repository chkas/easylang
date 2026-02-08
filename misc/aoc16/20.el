# AoC-16 - Day 20: Firewall Rules
#
repeat
   a[] = number strsplit input "-"
   until len a[] < 2
   a = a[1]
   b = a[2]
   ln[] = [ ]
   n = len l[]
   i = 1
   while i <= n and l[i] < a
      ln[] &= l[i]
      i += 1
   .
   if i mod 2 = 1
      ln[] &= a
   .
   while i <= n and l[i] < b
      i += 1
   .
   if i mod 2 = 1
      ln[] &= b
   .
   while i <= n
      ln[] &= l[i]
      i += 1
   .
   swap l[] ln[]
   ln[] = [ ]
.
for i = 2 step 2 to len l[] - 2
   d = l[i + 1] - l[i] - 1
   if d <> 0
      if done = 0
         print l[i] + 1
         done = 1
      .
      sum += d
   .
.
print sum
#
input_data
5-8
0-2
4-7
10-15

