# AoC-22 - Day 8: Treetop Tree House
# 
visual = 1
# 
sys topleft
global m[] nc .
func read . .
   s$ = input
   nc = len s$
   if nc = 0
      nc = 80
      random_seed 0
   .
   for i to nc
      if s$ = ""
         for j to nc
            s$ &= strchar (random 10 + 47)
         .
      .
      for h in number strchars s$
         m[] &= h
      .
      s$ = input
   .
.
call read
# 
sc = 95 / nc
sc2 = sc / 2
func showall . .
   color 000
   rect 100 100
   for p = 1 to len m[]
      y = (p - 1) div nc * sc
      x = (p - 1) mod nc * sc
      move x + sc2 y + sc2
      h = m[p] * 0.1
      color3 h h + 0.2 h
      circle sc2
   .
.
if visual = 1
   call showall
   background -1
.
#  
textsize 3
func showt s$ . .
   move 0 95
   color 000
   rect 50 5
   move 5 96
   color 777
   text s$
.
func show p high . .
   y = (p - 1) div nc * sc
   x = (p - 1) mod nc * sc
   move x y
   h = m[p] * 0.1
   if high = 1
      color 975
      move x - sc / 2 y - sc / 2
      rect 2 * sc 2 * sc
   else
      color3 h + 0.5 h + 0.5 h - 0.2
      rect sc sc
   .
   sleep 0.005
.
len seen[] len m[]
func look p inc . .
   mx = -1
   for i = 1 to nc
      if m[p] > mx
         mx = m[p]
         if visual = 1
            call show p 0
         .
         seen[p] = 1
      .
      p += inc
   .
.
func part1 . .
   for i = 1 to nc
      call look (i - 1) * nc + 1 1
      call look i * nc (-1)
      call look i nc
      call look i + nc * (nc - 1) (-nc)
   .
   for h in seen[]
      cnt += h
   .
   print cnt
   if visual = 1
      call showt cnt
      sleep 1
   .
.
call part1
# 
# 
func cnt p inc . cnt .
   cnt = 0
   high = m[p]
   repeat
      p += inc
      if p < 1 or p > nc * nc
         break 1
      .
      h = p mod nc
      if inc = -1 and h = 0 or inc = 1 and h = 1
         break 1
      .
      cnt += 1
      if visual = 1
         call show p 0
      .
      until m[p] >= high
   .
.
func part2 . .
   for p = 1 to nc * nc
      if visual = 1
         clear
         call showt max & " " & h
      .
      call cnt p 1 c1
      call cnt p (-1) c2
      call cnt p nc c3
      call cnt p (-nc) c4
      if visual = 1
         call show p 1
      .
      h = c1 * c2 * c3 * c4
      if h > max
         max = h
         maxp = p
         if visual = 1
            call showt max
            sleep 1.5
         .
      .
   .
   if visual = 1
      clear
      call show maxp 1
      sleep 1
   .
   print max
.
call part2
# 
input_data



