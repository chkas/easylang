# AoC-17 - Day 16: Permutation Promenade
#
m$[] = strsplit input ","
np = 16
len prog[] np
len ind[] np
arrbase prog[] 0
arrbase ind[] 0
#
subr tostr
   prog$ = ""
   for i range0 np
      h = prog[(i + offs) mod np]
      prog$ &= strchar (h + 97)
   .
.
for i range0 np
   prog[i] = i
   ind[i] = i
.
tostr
prog$[] &= prog$
#
repeat
   for m$ in m$[]
      c$ = substr m$ 1 1
      if c$ = "s"
         offs = (offs - number substr m$ 2 2) mod np
      elif c$ = "p"
         p1 = (strcode substr m$ 2 1) - 97
         p2 = (strcode substr m$ 4 1) - 97
         i1 = ind[p1]
         i2 = ind[p2]
         swap prog[i1] prog[i2]
         swap ind[p1] ind[p2]
      else
         h[] = number strsplit substr m$ 2 5 "/"
         i1 = (h[1] + offs) mod np
         i2 = (h[2] + offs) mod np
         p1 = prog[i1]
         p2 = prog[i2]
         swap prog[i1] prog[i2]
         swap ind[p1] ind[p2]
      .
   .
   iter += 1
   tostr
   until prog$ = prog$[1]
   prog$[] &= prog$
.
print prog$[2]
print prog$[1000000000 mod iter + 1]
#
input_data
s1,x3/4,pe/b



