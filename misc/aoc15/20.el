# AoC-15 - Day 20: Infinite Elves and Infinite Houses
# 
n = number input
# 
len f[] n div 30
for part = 1 to 2
  for i range len f[]
    f[i] = 0
  .
  for i = 1 to len f[] - 1
    j = i
    cnt = 0
    while j < len f[]
      f[j] += 10 * i
      if part = 2
        f[j] += i
        if cnt = 50
          break 1
        .
      .
      cnt += 1
      j += i
    .
  .
  i = 0
  repeat
    until f[i] >= n
    i += 1
  .
  print i
.
# 
input_data
34000000

