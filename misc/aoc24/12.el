# AoC-24 - Day 12: Garden Groups
#
global nc m[] .
proc init .
   s$ = input
   nc = len s$ + 2
   len m[] nc
   while s$ <> ""
      m[] &= 0
      for c$ in strchars s$ : m[] &= strcode c$ - 64
      m[] &= 0
      s$ = input
   .
   len m[] len m[] + nc
.
init
#
subr initseen
   seen[] = [ ]
   len seen[] len m[]
.
dir[] = [ 1 nc -1 (-nc) ]
dirdg[] = [ (nc + 1) (nc - 1) (-nc - 1) (-nc + 1) ]
#
part = 1
proc find i &cnt &peri .
   if seen[i] = 1 : return
   seen[i] = 1
   cnt += 1
   for di to 4
      d = dir[di]
      if m[i + d] = m[i]
         find (i + d) cnt peri
      else
         if part = 1
            peri += 1
         else
            dn = dir[(di + 1) mod1 4]
            ddg = dirdg[di]
            if m[i + dn] <> m[i]
               peri += 1
            elif m[i + dn] = m[i] and m[i + ddg] = m[i]
               peri += 1
            .
         .
      .
   .
.
proc run .
   initseen
   for ind to len m[]
      if m[ind] <> 0 and seen[ind] = 0
         cnt = 0
         peri = 0
         find ind cnt peri
         sum += cnt * peri
      .
   .
   print sum
.
run
part = 2
run
#
input_data
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
