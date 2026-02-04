# AoC-15 - Day 3: Perfectly Spherical Houses in a Vacuum
#
s$ = input
nc = 1000
#
proc go part .
   len m[] nc * nc
   p = nc * nc / 2 + nc / 2
   p1 = p
   p2 = p
   m[p] = 1
   for i to len s$
      c$ = substr s$ i 1
      if part = 2 and i mod 2 = 1
         p = p2
      else
         p = p1
      .
      if c$ = ">"
         p += 1
      elif c$ = "v"
         p += nc
      elif c$ = "<"
         p -= 1
      elif c$ = "^"
         p -= nc
      .
      m[p] = 1
      if part = 2 and i mod 2 = 1
         p2 = p
      else
         p1 = p
      .
   .
   for v in m[] : sum += v
   print sum
.
go 1
go 2
#
input_data
^>v<




