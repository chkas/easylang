# AoC-17 - Day 17: Spinlock
# 
skip = number input
# 
len f[] 2018
for i = 1 to 2017
  for j range skip
    pos = f[pos]
  .
  h = f[pos]
  f[pos] = i
  f[i] = h
  pos = i
.
print f[2017]
# 
pos = 0
for i = 1 to 50000000
  pos = (pos + skip) mod i
  if pos = 0
    r = i
  .
  pos += 1
.
print r
# 
input_data
370


