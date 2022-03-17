# AoC-18 - Day 14: Chocolate Charts
# 
f[] = [ 3 7 ]
i1 = 0
i2 = 1
inp = number input
repeat
  new = f[i1] + f[i2]
  if new >= 10
    f[] &= 1
    n = (n * 10 + 1) mod 1000000
    if n = inp
      part2 = len f[] - 6
    .
    new -= 10
  .
  f[] &= new
  n = (n * 10 + new) mod 1000000
  if n = inp
    part2 = len f[] - 6
  .
  until part2 > 0 and len f[] >= inp + 10
  i1 = (i1 + f[i1] + 1) mod len f[]
  i2 = (i2 + f[i2] + 1) mod len f[]
.
for i = inp to inp + 9
  write f[i]
.
print ""
print part2
# 
input_data
409551

