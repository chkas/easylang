# AoC-16 - Day 16: Dragon Checksum
# 
proc run sz inp$ .
   d[] = number strchars inp$
   while len d[] < sz
      d[] &= 0
      for i = len d[] - 1 downto 1
         d[] &= 1 - d[i]
      .
   .
   len d[] sz
   while len d[] mod 2 = 0
      dn[] = [ ]
      for i = 1 step 2 to len d[] - 1
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
# run 20 s$
run 272 s$
run 35651584 s$
# 
input_data
10000

