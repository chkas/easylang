# AoC-17 - Day 6: Memory Reallocation
#
hasz = 199999
len haind$[] hasz
len haval[] hasz
#
proc hash ind[] val . ret .
   for i to len ind[]
      ind$ &= strchar (ind[i] + 65)
   .
   for c$ in strchars ind$
      hi = (hi * 26 + strcode c$ - 26) mod hasz + 1
   .
   while haind$[hi] <> "" and haind$[hi] <> ind$
      hi = hi mod hasz + 1
   .
   if haind$[hi] = ""
      haind$[hi] = ind$
      haval[hi] = val
      ret = 0
   else
      ret = haval[hi]
   .
.
#
in$ = input
m[] = number strsplit in$ "\t "
n = len m[]
repeat
   cnt += 1
   max = 0
   for i to n
      if m[i] > max
         max = m[i]
         mi = i
      .
   .
   m[mi] = 0
   i = mi
   repeat
      i = i mod n + 1
      until max = 0
      m[i] += 1
      max -= 1
   .
   hash m[] cnt ret
   until ret > 0
.
print cnt
print cnt - ret
#
input_data
0 2 7 0



