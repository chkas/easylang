# AoC-15 - Day 15: Science for Hungry People
# 
repeat
  s$ = input
  until s$ = ""
  s$[] = strsplit s$ " "
  i = len in[][]
  in[][] &= [ ]
  in[i][] &= number s$[2]
  in[i][] &= number s$[4]
  in[i][] &= number s$[6]
  in[i][] &= number s$[8]
  in[i][] &= number s$[10]
.
n = len in[][]
nx = 1
for i = 2 to n
  nx *= 101
.
len f[] n
for ni range nx
  h = ni
  f[0] = 100
  for i = 1 to n - 1
    f[i] = h mod 101
    h = h div 101
    f[0] -= f[i]
  .
  p = 1
  cal = 0
  for i range 4
    f = 0
    for j range 4
      h = f[j] * in[j][i]
      f += h
    .
    if f < 0
      f = 0
    .
    p *= f
    cal += f[i] * in[i][4]
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
Sugar: capacity 3, durability 0, flavor 0, texture -3, calories 2
Sprinkles: capacity -3, durability 3, flavor 0, texture 0, calories 9
Candy: capacity -1, durability 0, flavor 4, texture 0, calories 1
Chocolate: capacity 0, durability 0, flavor -2, texture 2, calories 8

