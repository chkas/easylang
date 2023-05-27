# AoC-17 - Day 10: Knot Hash
# 
inp$ = input
global inp[] l[] .
arrbase l[] 0
proc init . .
   len l[] 256
   for i range0 256
      l[i] = i
   .
.
# 
proc run rounds . .
   for _ range0 rounds
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
.
inp[] = number strsplit inp$ ","
call init
call run 1

#call run 1
print l[0] * l[1]
# 
call init
inp[] = [ ]
for i to len inp$
   inp[] &= strcode substr inp$ i 1
.
inp[] &= 17
inp[] &= 31
inp[] &= 73
inp[] &= 47
inp[] &= 23
# 
call run 64
for i range0 16
   h = 0
   for j range0 16
      h = bitxor l[16 * i + j] h
   .
   hash[] &= h
.
for i to 16
   for h in [ hash[i] div 16 hash[i] mod 16 ]
      h += 48
      if h > 57
         h += 39
      .
      write strchar h
   .
.
print ""
# 
input_data
72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100



