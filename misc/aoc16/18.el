# AoC-16 - Day 18: Like a Rogue
# 
s$ = input
nc = len s$
for x$ in strchars s$
  safe += if x$ = "."
  sn[] &= if x$ = "."
.
sn[] &= 1
len s[] nc
nrows = 400000
for ln range nrows - 1
  swap sn[] s[]
  l = 1
  for i range nc
    r = s[i + 1]
    x = if l + r <> 1
    sn[i] = x
    safe += x
    l = s[i]
  .
  if ln = 38
    print safe
  .
  sn[] &= 1
.
print safe
# 
# 
input_data
.^^^.^.^^^.^.......^^.^^^^.^^^^..^^^^^.^.^^^..^^.^.^^..^.^..^^...^.^^.^^^...^^.^.^^^..^^^^.....^....

