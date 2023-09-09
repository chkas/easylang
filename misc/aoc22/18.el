# AoC-22 - Day 18: Boiling Boulders
# 
nc = 25
ncc = nc * nc
len m[] ncc * nc
#  
proc init . .
   repeat
      s$ = input
      until s$ = ""
      a[] = number strsplit s$ ","
      h = 1 + a[1] + a[2] * nc + a[3] * ncc
      m[h] = 1
   .
.
init
proc cntfaces id . res .
   for i = 1 to len m[]
      if m[i] = id
         s += 6
         for d in [ -1 1 (-nc) nc (-ncc) ncc ]
            if m[i + d] = id
               s -= 1
            .
         .
      .
   .
   res = s
.
cntfaces 1 nfaces
print nfaces
# 
proc flood . .
   todo[] &= 1
   m[1] = 2
   while len todo[] > 0
      todon[] = [ ]
      for ind in todo[]
         h = ind - 1
         x = h mod nc
         h = h div nc
         y = h mod nc
         z = h div nc
         for d in [ -1 1 (-nc) nc (-ncc) ncc ]
            if x = 0 and d = -1
               #
            elif x = nc - 1 and d = 1
               #
            elif y = 0 and d = -nc
               #
            elif y = nc - 1 and d = nc
               #
            elif z = 0 and d = -ncc
               #
            elif z = nc - 1 and d = ncc
               #
            elif m[ind + d] = 0
               m[ind + d] = 2
               todon[] &= ind + d
            .
         .
      .
      swap todon[] todo[]
   .
.
flood
cntfaces 0 h
print nfaces - h
# 
input_data
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5

