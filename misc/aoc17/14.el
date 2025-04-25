# AoC-17 - Day 14: Disk Defragmentation
#
inp$ = input
#
proc hash s$ &hash[] ..
   inp[] = [ ]
   for i to len s$
      inp[] &= strcode substr s$ i 1
   .
   inp[] &= 17
   inp[] &= 31
   inp[] &= 73
   inp[] &= 47
   inp[] &= 23
   arrbase l[] 0
   len l[] 256
   for i range0 256
      l[i] = i
   .
   for _ range0 64
      for l in inp[]
         a = pos
         b = (pos + l - 1) mod 256
         for i range0 l div 2
            swap l[a] l[b]
            a = (a + 1) mod 256
            b = (b - 1) mod 256
         .
         pos = (pos + l + skip) mod 256
         skip += 1
      .
   .
   hash[] = [ ]
   for i range0 16
      h = 0
      for j range0 16
         h = bitxor h l[16 * i + j]
      .
      hash[] &= h
   .
.
proc outp &hash[] ..
   for i range0 len hash[]
      h = hash[i]
      for h in [ h div 16 h mod 16 ]
         h += 48
         if h > 57
            h += 39
         .
         write strchar h
      .
   .
   print ""
.
m[] = []
#
proc bits b[] .
   for b in b[]
      h = 0x80
      while h > 0
         m[] &= if bitand b h > 0
         h = bitshift h -1
      .
   .
.
proc make_grid .
   for i range0 128
      hash inp$ & "-" & i hash[]
      bits hash[]
   .
   for h in m[]
      sum += h
   .
   print sum
.
make_grid
#
proc expand ind .
   m[ind] = 0
   if ind mod 128 <> 1 and m[ind - 1] = 1
      expand ind - 1
   .
   if ind > 128 and m[ind - 128] = 1
      expand ind - 128
   .
   if ind mod 128 <> 0 and m[ind + 1] = 1
      expand ind + 1
   .
   if ind <= 127 * 128 and m[ind + 128] = 1
      expand ind + 128
   .
.
for i to len m[]
   if m[i] = 1
      nreg += 1
      expand i
   .
.

print nreg
#
input_data
flqrgnkx


