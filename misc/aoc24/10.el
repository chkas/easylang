# AoC-24 - Day 10: Hoof It
#
global nc m[] seen[] .
proc init . .
   s$ = input
   nc = len s$ + 1
   len m[] nc
   while s$ <> ""
      for c$ in strchars s$ : m[] &= number c$ + 1
      m[] &= 0
      s$ = input
   .
   len m[] len m[] + nc
.
init
part = 1
#
dir[] = [ 1 nc -1 (-nc) ]
func find i .
   if part = 1 and seen[i] = 1 : return 0
   seen[i] = 1
   if m[i] = 10 : return 1
   for d in dir[] : if m[i] + 1 = m[i + d]
      s += find (i + d)
   .
   return s
.
#
len seen0[] len m[]
#
proc run . .
   for i to len m[] : if m[i] = 1
      seen[] = seen0[]
      sum += find i
   .
   print sum
.
run
part = 2
run
#
input_data
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
