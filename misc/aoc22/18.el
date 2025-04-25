# AoC-22 - Day 18: Boiling Boulders
#
nc = 25
ncc = nc * nc
len m[] ncc * nc
arrbase m[] 0
#
proc init .
   repeat
      s$ = input
      until s$ = ""
      a[] = number strsplit s$ ","
      h = 1 + a[1] + (a[2] + 1) * nc + (a[3] + 1) * ncc
      m[h] = 1
   .
   for z range0 25
      for y range0 25
         for x range0 25
            if z = 0 or z = 24 or y = 0 or y = 24 or x = 0 or x = 24
               h = x + y * nc + z * nc * nc
               m[h] = 2
            .
         .
      .
   .
.
init
proc cntfaces id &res .
   for i range0 len m[]
      if m[i] = id
         s += 6
         for d in [ -1 1 (-nc) nc (-ncc) ncc ]
            if m[i + d] = id : s -= 1
         .
      .
   .
   res = s
.
cntfaces 1 nfaces
print nfaces
#
proc flood .
   h = 1 + nc + nc * nc
   todo[] &= h
   m[h] = 2
   while len todo[] > 0
      todon[] = [ ]
      for ind in todo[]
         for d in [ -1 1 (-nc) nc (-ncc) ncc ]
            if m[ind + d] = 0
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
