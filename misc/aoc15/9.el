# AoC-15 - Day 9: All in a Single Night
#
global name$[] perm[] .
proc getid n$ &id .
   for id = 1 to len name$[]
      if name$[id] = n$
         return
      .
   .
   name$[] &= n$
   perm[] &= id
.
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
   s$[] = strsplit s$ " "
   getid s$[1] a
   getid s$[3] b
.
n = len perm[]
#
len dist[] n * (n + 1)
#
for s$ in inp$[]
   s$[] = strsplit s$ " "
   getid s$[1] a
   getid s$[3] b
   d = number s$[5]
   dist[a * n + b] = d
   dist[b * n + a] = d
.
global permlist[][] .
proc mk_permlist k .
   for i = k to len perm[]
      swap perm[i] perm[k]
      mk_permlist k + 1
      swap perm[k] perm[i]
   .
   if k = len perm[]
      permlist[][] &= perm[]
   .
.
mk_permlist 1
#
min = 1 / 0
for p = 1 to len permlist[][]
   swap perm[] permlist[p][]
   dist = 0
   for i = 1 to n - 1
      dist += dist[perm[i] + perm[i + 1] * n]
   .
   min = lower dist min
   max = higher dist max
.
print min
print max
#
#
input_data
London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141

