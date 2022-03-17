# AoC-17 - Day 10: Knot Hash
# 
inp$ = input
global l[] inp[] .
func init . .
  len l[] 256
  for i range 256
    l[i] = i
  .
.
# 
func run rounds . .
  for _ range rounds
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
.
inp[] = number strsplit inp$ ","
call init
call run 1
print l[0] * l[1]
# 
call init
inp[] = [ ]
for i range len inp$
  inp[] &= strcode substr inp$ i 1
.
inp[] &= 17
inp[] &= 31
inp[] &= 73
inp[] &= 47
inp[] &= 23
# 
call run 64
for i range 16
  h = 0
  for j range 16
    h = bitxor l[16 * i + j] h
  .
  hash[] &= h
.
for i range 16
  for h in [ hash[i] div 16 hash[i] mod 16 ]
    h += 48
    if h > 57
      h += 39
    .
    write strchar h
  .
.
# 
input_data
129,154,49,198,200,133,97,254,41,6,2,1,255,0,191,108


