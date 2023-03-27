# AoC-18 - Day 25: Four-Dimensional Adventure
# 
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ ","
   x[] &= number s$[1]
   y[] &= number s$[2]
   z[] &= number s$[3]
   w[] &= number s$[4]
.
n = len x[]
for i to n
   cat[] &= i
.
for i to n
   for j = i + 1 to n
      dist = abs (x[j] - x[i]) + abs (y[j] - y[i]) + abs (z[j] - z[i]) + abs (w[j] - w[i])
      if dist <= 3
         h = cat[j]
         for k to n
            if cat[k] = h
               cat[k] = cat[i]
            .
         .
      .
   .
.
len cnt[] n
for k to n
   cnt[cat[k] + 1] = 1
.
for k to n
   cnt += cnt[k]
.
print cnt
# 
input_data
1,-1,-1,-2
-2,-2,0,1
0,2,1,3
-2,3,-2,1
0,2,3,-2
-1,-1,1,-2
0,-2,-1,0
-2,2,3,-1
1,2,2,0
-1,-2,0,-2


