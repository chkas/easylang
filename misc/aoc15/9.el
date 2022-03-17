# AoC-15 - Day 9: All in a Single Night
# 
global name$[] perm[] .
func id n$ . id .
  for id range len name$[]
    if name$[id] = n$
      break 2
    .
  .
  name$[] &= n$
  perm[] &= id
.
repeat
  s$ = input
  until s$ = ""
  inp$[] &= s$
.
n = floor sqrt (2 * len inp$[]) + 1
# 
len dist[] n * n
# 
for s$ in inp$[]
  s$[] = strsplit s$ " "
  call id s$[0] a
  call id s$[2] b
  d = number s$[4]
  dist[a * n + b] = d
  dist[b * n + a] = d
.
global permlist[][] .
func mk_permlist k . .
  for i = k to len perm[] - 1
    swap perm[i] perm[k]
    call mk_permlist k + 1
    swap perm[k] perm[i]
  .
  if k = len perm[] - 1
    permlist[][] &= perm[]
  .
.
call mk_permlist 0
#
min = 1 / 0
for p range len permlist[][]
  swap perm[] permlist[p][]
  dist = 0
  for i range n - 1
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
Tristram to AlphaCentauri = 34
Tristram to Snowdin = 100
Tristram to Tambi = 63
Tristram to Faerun = 108
Tristram to Norrath = 111
Tristram to Straylight = 89
Tristram to Arbre = 132
AlphaCentauri to Snowdin = 4
AlphaCentauri to Tambi = 79
AlphaCentauri to Faerun = 44
AlphaCentauri to Norrath = 147
AlphaCentauri to Straylight = 133
AlphaCentauri to Arbre = 74
Snowdin to Tambi = 105
Snowdin to Faerun = 95
Snowdin to Norrath = 48
Snowdin to Straylight = 88
Snowdin to Arbre = 7
Tambi to Faerun = 68
Tambi to Norrath = 134
Tambi to Straylight = 107
Tambi to Arbre = 40
Faerun to Norrath = 11
Faerun to Straylight = 66
Faerun to Arbre = 144
Norrath to Straylight = 115
Norrath to Arbre = 135
Straylight to Arbre = 127

