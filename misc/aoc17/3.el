# AoC-17 - Day 3: Spiral Memory
# 
n = number input
sq = floor sqrt n
if sq mod 2 = 0
  sq -= 1
.
b = ((sq + 2) * (sq + 2) - sq * sq) / 4
d = (n - sq * sq) mod b
out = (sq + 1) div 2
side = abs (d - b / 2)
print out + side
# 
f[] = [ 1 1 2 4 5 10 11 23 25 ]
i = 1
qle = 2
while 1 = 1
  for side range 4
    for q range qle
      f[] &= f[len f[] - 1]
      f[len f[] - 1] += f[i]
      if q > 0 or side > 0
        f[len f[] - 1] += f[i - 1]
      .
      if q > 1 or side > 0 and q > 0
        f[len f[] - 1] += f[i - 2]
      .
      if q = 0 and side > 0 or q = 1 and side = 0
        f[len f[] - 1] += f[len f[] - 3]
      .
      i += 1
      if f[i] > n
        print f[i]
        break 3
      .
    .
    # 
    f[] &= f[len f[] - 1]
    f[len f[] - 1] += f[i - 2]
    f[len f[] - 1] += f[i - 1]
    if side = 3
      f[len f[] - 1] += f[i]
    .
    f[] &= f[len f[] - 1]
    f[len f[] - 1] += f[i - 1]
    if side = 3
      f[len f[] - 1] += f[i]
    .
  .
  qle += 2
.
# 
input_data
347991

