# AoC-23 - Day 23: A Long Walk
# 
visualisation = 1
global m[] nc .
proc read . .
   s$ = input
   nc = len s$
   repeat
      s$[] = strchars s$
      for c$ in s$[]
         if c$ = "#"
            m[] &= -1
         elif c$ = "."
            m[] &= 0
         elif c$ = ">"
            m[] &= 1
         elif c$ = "v"
            m[] &= 2
         elif c$ = "<"
            m[] &= 3
         else
            m[] &= 4
         .
      .
      s$ = input
      until s$ = ""
   .
   for i to nc
      m[] &= 0
   .
.
# 
read
len seen[] len m[]
max = 0
# 
sysconf topleft
background 000
textsize 5
sc = 100 / nc
colind = 1
col[] = [ 955 595 559 995 959 599 ]
proc show m . .
   if visualisation = 0
      return
   .
   if m = -1
      sleep 3
      return
   .
   if m = 2
      col = col[colind]
      colind = colind mod len col[] + 1
   elif m = 1
      col = 393
   else
      col = 955
   .
   clear
   for r range0 nc
      for c range0 nc
         ind = r * nc + c + 1
         if m[ind] >= 0
            if seen[ind] = 1
               color col
            else
               color 666
            .
            move c * sc r * sc
            rect sc sc
         .
      .
   .
   move 2 90
   color 000
   rect 14 6
   color 666
   move 3 91
   text max
   # 
   if m = 2 or m = 1
      sleep 0.2
   elif m = 0
      sleep 0.1
   .
.
m[2] = -1
start = nc + 2
stop = nc * nc - 1 + nc
seen[start] = 1
# 
d[] = [ 1 nc -1 (-nc) ]
# 
func is_border h .
   if h <= 2 * nc or h mod nc = (nc - 1)
      return 1
   .
   if h > nc * nc - 2 * nc or h mod nc = 2
      return 1
   .
.
#  
part = 1
#  
proc solv p cnt d0 turn . .
   seen_old[] = seen[]
   while p <> stop
      h0 = 0
      d00 = d0
      for t = -1 to 1
         d = (d00 + t) mod1 4
         h = p + d[d]
         hx = p + 2 * d[d]
         if m[h] >= 0 and seen[hx] = 0
            ok = 1
            if part = 1 and m[h] > 0 and m[h] <> d
               ok = 0
            .
            if is_border hx = 1
               if is_border p = 1 and (d = 3 or d = 4)
                  ok = 0
                  if h = nc * nc - 1
                     ok = 1
                  .
               .
            else
               if turn < -2
                  dx = (d + 1) mod1 4
                  if seen[hx + 2 * d[dx]] = 1
                     ok = 0
                  .
               elif turn > 3
                  dx = (d - 1) mod1 4
                  if seen[hx + 2 * d[dx]] = 1
                     ok = 0
                  .
               .
            .
            if ok = 1
               if h0 = 0
                  d0 = d
                  h0 = h
                  hx0 = hx
                  t0 = t
               else
                  seen[h] = 1
                  seen[hx] = 1
                  solv hx cnt + 2 d turn + t
                  seen[hx] = 0
                  seen[h] = 0
               .
            .
         .
      .
      if h0 = 0
         cnt = 0
         break 1
      .
      turn += t0
      seen[hx0] = 1
      seen[h0] = 1
      p = hx0
      cnt += 2
   .
   ##
   if cnt = 0
      show 0
   else
      show 1
   .
   # #
   if cnt > max
      max = cnt
      # print max
      show 2
   .
   seen[] = seen_old[]
.
solv start 0 1 0
print max
show -1
part = 2
solv start 0 1 0
print max
# 
# 
input_data
#.#####################
#.......#########...###
#######.#########.#.###
###.....#.>.>.###.#.###
###v#####.#v#.###.#.###
###.>...#.#.#.....#...#
###v###.#.#.#########.#
###...#.#.#.......#...#
#####.#.#.#######.#.###
#.....#.#.#.......#...#
#.#####.#.#.#########v#
#.#...#...#...###...>.#
#.#.#v#######v###.###v#
#...#.>.#...>.>.#.###.#
#####v#.#.###v#.#.###.#
#.....#...#...#.#.#...#
#.#########.###.#.#.###
#...###...#...#...#.###
###.###.#.###v#####v###
#...#...#.#.>.>.#.>.###
#.###.###.#.###.#.#v###
#.....###...###...#...#
#####################.#