# AoC-17 - Day 14: Disk Defragmentation
# 
inp$ = input
# 
func hash s$ . hash[] .
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
   for i range0 256
      l[] &= i
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
func outp . hash[] .
   for h in hash[]
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
arrbase m[] 0
# 
func bits b[] . .
   for b in b[]
      h = 0x80
      while h > 0
         m[] &= if bitand b h > 0
         h = bitshift h -1
      .
   .
.
func make_grid . .
   for i range0 128
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
for i range0 len m[]
   if m[i] = 1
      nreg += 1
      call expand i
   .
.
print nreg
# 
input_data
flqrgnkx


