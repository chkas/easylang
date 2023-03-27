# AoC-16 - Day 22: Grid Computing
#  
s$ = input
s$ = input
repeat
   s$ = input
   until s$ = ""
   if substr s$ 1 20 = "/dev/grid/node-x1-y0"
      nc = len sz[]
   .
   sz[] &= number substr s$ 25 3
   us[] &= number substr s$ 31 3
.
arrbase m[] 0
for i range0 nc + 1
   m[] &= 1
.
for i to len sz[]
   for j to len sz[]
      if i <> j and us[i] <> 0
         if us[i] <= sz[j] - us[j]
            sum += 1
         .
      .
   .
   if sz[i] > 2 * sz[1]
      m[] &= 1
   else
      m[] &= 0
   .
   if i mod nc = 0
      m[] &= 1
   .
   if us[i] = 0
      free = len m[] - 1
   .
.
for i range0 nc + 1
   m[] &= 1
.
print sum
# 
# 
n = len m[]
len seen[] n * n
arrbase seen[] 0
nc += 1
targ = n - 2 * nc
todo[] = [ free * n + targ ]
while len todo[] <> 0
   for cod in todo[]
      targ = cod mod n
      free = cod div n
      # 
      if targ = nc
         print steps
         break 2
      .
      for freen in [ free - nc free + 1 free + nc free - 1 ]
         if m[freen] = 0
            targn = targ
            if freen = targ
               targn = free
            .
            codn = freen * n + targn
            if seen[codn] = 0
               todon[] &= codn
               seen[codn] = 1
            .
         .
      .
   .
   swap todo[] todon[]
   todon[] = [ ]
   steps += 1
.
# 
# ??
input_data
---
Filesystem            Size  Used  Avail  Use%
/dev/grid/node-x0-y0   10T    8T     2T   80%
/dev/grid/node-x0-y1   11T    6T     5T   54%
/dev/grid/node-x0-y2   32T   28T     4T   87%
/dev/grid/node-x1-y0    9T    7T     2T   77%
/dev/grid/node-x1-y1    8T    0T     8T    0%
/dev/grid/node-x1-y2   11T    7T     4T   63%
/dev/grid/node-x2-y0   10T    6T     4T   60%
/dev/grid/node-x2-y1    9T    8T     1T   88%
/dev/grid/node-x2-y2    9T    6T     3T   66%


