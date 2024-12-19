# AoC-23 - Day 15: Lens Library
#
func hash s$[] .
   for c$ in s$[]
      h = (h + strcode c$) * 17 mod 256
   .
   return h
.
len b$[][] 256
len bv[][] 256
for s$ in strsplit input ","
   s$[] = strchars s$
   #
   part1 += hash s$[]
   #
   if s$[len s$[]] = "-"
      v = 0
      len s$[] -1
   else
      v = number s$[len s$[]]
      len s$[] -2
   .
   b = hash s$[] + 1
   id$ = strjoin s$[] ""
   for i to len b$[b][]
      if b$[b][i] = id$ and bv[b][i] > 0
         bv[b][i] = v
         break 1
      .
   .
   if i > len b$[b][]
      b$[b][] &= id$
      bv[b][] &= v
   .
.
for b to 256
   slot = 0
   for i to len bv[b][]
      if bv[b][i] > 0
         slot += 1
         part2 += b * slot * bv[b][i]
      .
   .
.
print part1
print part2
#
input_data
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
