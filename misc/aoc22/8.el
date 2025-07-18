# AoC-22 - Day 8: Treetop Tree House
#
sysconf topleft
visual = 1
#
global m[] nc .
proc read .
   s$ = input
   nc = len s$ + 2
   if nc = 2
      nc = 42
      random_seed 0
   .
   for i to nc : m[] &= 10
   for i to nc - 2
      m[] &= 10
      if s$ = ""
         for j to nc - 2
            s$ &= strchar (random 10 + 47)
         .
      .
      for h in number strchars s$
         m[] &= h
      .
      m[] &= 10
      s$ = input
   .
   for i to nc : m[] &= 10
.
read
#
sc = 95 / nc
sc2 = sc / 2
proc showall .
   gcolor 000
   grect 0 0 100 100
   for p = 1 to len m[]
      y = (p - 1) div nc * sc
      x = (p - 1) mod nc * sc
      h = m[p] * 0.1
      gcolor3 h h + 0.2 h
      gcircle x + sc2 y + sc2 sc2
   .
.
if visual = 1
   showall
   gbackground -1
.
#
gtextsize 3
proc showtxt s$ w .
   if visual = 0 : return
   gcolor 000
   grect 0 95 50 5
   gcolor 777
   gtext 5 96 s$
   sleep w
.
proc show p high .
   if visual = 0 : return
   y = (p - 1) div nc * sc
   x = (p - 1) mod nc * sc
   h = m[p] * 0.1
   if high = 1
      gcolor 975
      grect x - sc / 2 y - sc / 2 2 * sc 2 * sc
   else
      gcolor3 h + 0.5 h + 0.5 h - 0.2
      grect x y sc sc
   .
   sleep 0.001
.
len seen[] len m[]
proc look p inc .
   mx = -1
   for i = 1 to nc - 2
      if m[p] > mx
         mx = m[p]
         show p 0
         seen[p] = 1
      .
      p += inc
   .
.
proc part1 .
   for i = 1 to nc - 2
      look i * nc + 2 1
      look i * nc + nc - 1 (-1)
      look i + nc + 1 nc
      look i + nc * (nc - 2) + 1 (-nc)
   .
   for h in seen[] : cnt += h
   print cnt
   showtxt cnt 2
.
part1
#
proc count p inc &cnt .
   cnt = 0
   high = m[p]
   repeat
      p += inc
      if m[p] = 10 : break 1
      cnt += 1
      show p 0
      until m[p] >= high
   .
.
proc count4 max p &c .
   gclear
   showtxt max 0
   count p 1 c1
   count p (-1) c2
   count p nc c3
   count p (-nc) c4
   show p 1
   c = c1 * c2 * c3 * c4
.
proc part2 .
   for p = 1 to len m[] : if m[p] < 10
      count4 max p c
      if c > max
         show p 1
         max = c
         maxp = p
         showtxt max 0.2
      .
   .
   print max
   count4 max maxp c
.
part2
#
input_data
