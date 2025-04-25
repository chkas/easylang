# AoC-21 - Day 15: Chiton
#
# Dijkstra. To avoid the minimum search,
# there are simply 10 lists, for cost +1,
# +2 etc .. And these are processed one
# after the other. To display the optimal
# path, we also need a predecessor list.
#
sysconf topleft
visual = 1
#
global m[] nc cost todo[][] endpos prev[] .
background 000
clear
textsize 4
proc show .
   if visual = 0 : return
   sc = 94 / nc
   if cost = 0
      clear
      for y range0 nc - 1 : for x range0 nc - 1
         pos = nc + y * nc + x + 1
         color 111 * (m[pos] - 1)
         move sc * x sc * y
         rect sc sc
      .
   else
      color 321
      for pos in todo[cost mod 10 + 1][]
         x = (pos - 1) mod nc
         y = (pos - 1) div nc - 1
         color 111 * m[pos]
         move sc * x sc * y
         rect sc sc
      .
   .
   color 000
   move 2 95
   rect 50 8
   color 666
   text "Total risk: " & cost
   sleep 0.01
.
proc show_route .
   if visual = 0 : return
   sc = 94 / nc
   color 900
   pos = endpos
   repeat
      x = (pos - 1) mod nc
      y = (pos - 1) div nc - 1
      move sc * x + sc / 2 sc * y + sc / 2
      circle sc / 2
      pos = prev[pos]
      until pos = -1
   .
.
#
global sz inp$[] .
proc read .
   inp$ = input
   sz = len inp$
   if sz = 0
      sz = 80
      random_seed 0
   .
   for ii to sz
      if inp$ = ""
         for i to sz : inp$ &= strchar (random 10 + 47)
      .
      inp$[] &= inp$
      inp$ = input
   .
.
read
proc init expnd .
   m[] = [ ]
   nc = sz + expnd * sz + 1
   for i to nc : m[] &= 0
   for inp$ in inp$[]
      for i to sz : m[] &= number substr inp$ i 1
      for i to expnd * sz : m[] &= m[len m[] - sz + 1] mod 9 + 1
      m[] &= 0
   .
   for i to expnd * sz
      for j to sz * (expnd + 1)
         m[] &= m[len m[] - sz * nc + 1] mod 9 + 1
      .
      m[] &= 0
   .
   for i to nc : m[] &= 0
.
#
proc run .
   prev[] = [ ]
   len prev[] len m[]
   endpos = len m[] - nc - 1
   pos = nc + 1
   prev[pos] = -1
   todo[][] = [ ]
   len todo[][] 10
   todo[1][] &= pos
   for cost = 0 to 99999
      show
      for pos in todo[cost mod 10 + 1][]
         if pos = endpos : break 2
         for posn in [ pos - nc pos + 1 pos + nc pos - 1 ]
            if prev[posn] = 0 and m[posn] > 0
               todo[(cost + m[posn]) mod 10 + 1][] &= posn
               prev[posn] = pos
            .
         .
      .
      todo[cost mod 10 + 1][] = [ ]
   .
   print cost
   show_route
.
init 0
run
if visual = 1 : sleep 1
init 4
run
#
input_data
