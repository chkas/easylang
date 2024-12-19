# AoC-18 - Day 3: No Matter How You Slice It
#
repeat
   s$ = input
   until s$ = ""
   n[] = number strtok s$ " ,x"
   x[] &= n[1]
   y[] &= n[2]
   w[] &= n[3]
   h[] &= n[4]
.
#
len f[] 1000 * 1000
for i to len x[]
   for r = x[i] to x[i] + w[i] - 1
      for c = y[i] to y[i] + h[i] - 1
         f[r * 1000 + c + 1] += 1
      .
   .
.
for i to len f[]
   if f[i] > 1
      s += 1
   .
.
print s
#
for i to len x[]
   for r = x[i] to x[i] + w[i] - 1
      for c = y[i] to y[i] + h[i] - 1
         ind = r * 1000 + c + 1
         if f[ind] <> 1
            ind = 0
            break 2
         .
      .
   .
   if ind <> 0
      print i
      break 1
   .
.
#
#
input_data
#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2


