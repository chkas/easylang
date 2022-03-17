# AoC-16 - Day 16: Dragon Checksum
# 
func run sz inp$ . .
  d[] = number strchars inp$
  while len d[] < sz
    d[] &= 0
    for i = len d[] - 2 downto 0
      d[] &= 1 - d[i]
    .
  .
  len d[] sz
  while len d[] mod 2 = 0
    dn[] = [ ]
    for i = 0 step 2 to len d[] - 2
      dn[] &= if d[i] + d[i + 1] <> 1
    .
    swap d[] dn[]
  .
  for v in d[]
    s$ &= v
  .
  print s$
.
s$ = input
call run 272 s$
call run 35651584 s$
# 
input_data
11110010111001001

