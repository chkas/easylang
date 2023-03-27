# AoC-15 - Day 15: Science for Hungry People
# 
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ " "
   in[][] &= [ ]
   i = len in[][]
   in[i][] &= number s$[3]
   in[i][] &= number s$[5]
   in[i][] &= number s$[7]
   in[i][] &= number s$[9]
   in[i][] &= number s$[11]
.
n = len in[][]
nx = 1
for i = 2 to n
   nx *= 101
.
len f[] n
for ni to nx
   h = ni - 1
   f[1] = 100
   for i = 2 to n
      f[i] = h mod 101
      h = h div 101
      f[1] -= f[i]
   .
   p = 1
   cal = 0
   for j to 4
      f = 0
      for i to n
         h = f[i] * in[i][j]
         f += h
      .
      if f < 0
         f = 0
      .
      p *= f
   .
   for i to n
      cal += f[i] * in[i][5]
   .
   max = higher p max
   if cal = 500
      max2 = higher p max2
   .
.
print max
print max2
# 
input_data
Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3

