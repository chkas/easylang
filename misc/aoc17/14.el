# AoC-17 - Day 14: Disk Defragmentation
# 
inp$ = input
# 
func hash s$ . hash[] .
  inp[] = [ ]
  for i range len s$
    inp[] &= strcode substr s$ i 1
  .
  inp[] &= 17
  inp[] &= 31
  inp[] &= 73
  inp[] &= 47
  inp[] &= 23
  for i range 256
    l[] &= i
  .
  for _ range 64
    for l in inp[]
      a = pos
      b = (pos + l - 1) mod 256
      for i range l div 2
        swap l[a] l[b]
        a = (a + 1) mod 256
        b = (b - 1) mod 256
      .
      pos = (pos + l + skip) mod 256
      skip += 1
    .
  .
  hash[] = [ ]
  for i range 16
    h = 0
    for j range 16
      h = bitxor h l[16 * i + j]
    .
    hash[] &= h
  .
.
func outp . hash[] .
  for i range 16
    for h in [ hash[i] div 16 hash[i] mod 16 ]
      h += 48
      if h > 57
        h += 39
      .
      write strchar h
    .
  .
  print ""
.
global m[] .
func bits b[] . .
  for j range 16
    h = 0x80
    while h > 0
      m[] &= if bitand b[j] h > 0
      h = bitshift h -1
    .
  .
.
func make_grid . .
  for i range 128
    call hash inp$ & "-" & i hash[]
    call bits hash[]
  .
  for h in m[]
    sum += h
  .
  print sum
.
call make_grid
# 
func expand ind . .
  m[ind] = 0
  if ind mod 128 <> 0 and m[ind - 1] = 1
    call expand ind - 1
  .
  if ind >= 128 and m[ind - 128] = 1
    call expand ind - 128
  .
  if ind mod 128 <> 127 and m[ind + 1] = 1
    call expand ind + 1
  .
  if ind < 127 * 128 and m[ind + 128] = 1
    call expand ind + 128
  .
.
for i range len m[]
  if m[i] = 1
    nreg += 1
    call expand i
  .
.
print nreg
# 
input_data
ljoxqyyw

