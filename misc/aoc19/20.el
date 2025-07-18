# AoC-19 - Day 20: Donut Maze
#
sysconf topleft
visual = 1
#
global port[] port$[] aa zz m[] nc nc2 .
#
proc mark pos col .
   if visual = 0 : return
   f = 100 / nc2
   x = pos mod nc - 1
   y = pos div nc - 1
   gcolor col
   grect x * f y * f f f
   if col <> 0 : sleep 0.001
.
proc show .
   if visual = 0 : return
   gbackground 555
   gclear
   for i range0 len m[]
      if m[i] = -2 : mark i 000
   .
   mark zz 900
.
#
proc parse .
   a1$[] = strchars input
   nc = len a1$[] - 2
   nc2 = (nc - 2)
   len m[] nc * nc
   arrbase m[] 0
   for i range0 len m[] : m[i] = -3
   a2$[] = strchars input
   a3$[] = strchars input
   a4$[] = strchars input
   a5$[] = strchars input
   for y range0 nc2
      if len a5$[] = 0 : break 1
      for x range0 nc2
         pos = y * nc + x + nc + 1
         if a3$[x + 3] = "#"
            m[pos] = -2
         elif a3$[x + 3] = "."
            m[pos] = -1
            if a2$[x + 3] <> "#" and a2$[x + 3] <> "."
               port[] &= pos
               port$[] &= a1$[x + 3] & a2$[x + 3]
            .
            if a4$[x + 3] <> "#" and a4$[x + 3] <> "."
               port[] &= pos
               port$[] &= a4$[x + 3] & a5$[x + 3]
            .
            if a3$[x + 2] <> "#" and a3$[x + 2] <> "."
               port[] &= pos
               port$[] &= a3$[x + 1] & a3$[x + 2]
            .
            if a3$[x + 4] <> "#" and a3$[x + 4] <> "."
               port[] &= pos
               port$[] &= a3$[x + 4] & a3$[x + 5]
            .
         .
      .
      swap a1$[] a2$[]
      swap a2$[] a3$[]
      swap a3$[] a4$[]
      swap a4$[] a5$[]
      a5$[] = strchars input
   .
.
parse
proc connect .
   for i = 1 to len port$[]
      s$ = port$[i]
      if s$ = "AA"
         aa = port[i]
      elif s$ = "ZZ"
         zz = port[i]
      else
         for j = 1 to len port$[]
            if port$[j] = s$ and i <> j
               m[port[i]] = j
               m[port[j]] = i
            .
         .
      .
   .
.
connect
#
offs[] = [ -nc 1 nc -1 ]
#
proc part1 .
   show
   len seen[] len port[]
   cur[] &= aa
   cur_d[] &= -1
   while len cur[] > 0
      for i = 1 to len cur[]
         pos = cur[i]
         dir0 = cur_d[i]
         if pos = zz
            print n_steps
            return
         .
         if m[pos] >= 0 and dir0 <> -1
            p = m[pos]
            if seen[p] = 0
               seen[p] = 1
               nxt[] &= port[p]
               nxt_d[] &= -1
            .
         else
            for dir = 1 to 4
               posn = pos + offs[dir]
               if dir0 <> dir and m[posn] >= -1
                  nxt[] &= posn
                  nxt_d[] &= (dir + 1) mod 4 + 1
               .
            .
         .
         mark pos 990
      .
      n_steps += 1
      swap cur[] nxt[]
      swap cur_d[] nxt_d[]
      len nxt[] 0
      len nxt_d[] 0
   .
.
part1
#
proc is_inner pos &r .
   x = pos mod nc
   y = pos div nc
   r = 1
   if x = 1 or y = 1 or x = nc2 or y = nc2
      r = 0
   .
.
proc mark2 pos col lev .
   if visual = 0 or lev >= 6 : return
   f = 100 / nc2
   l = 1
   offs = 0
   for i range0 lev
      offs += 25 / l
      l *= 2
      # offs += 15 / l
      # l *= 1.6
   .
   x = pos mod nc - 1
   y = pos div nc - 1
   gcolor col
   grect x * f / l + offs y * f / l + offs f / l f / l
   if lev < 3 and col <> 0 : sleep 0.001
.
proc show2 .
   if visual = 0 : return
   gclear
   for i range0 len m[]
      if m[i] = -2
         for l range0 6 : mark2 i 000 l
      .
   .
   mark2 zz 900 0
.
proc part2 .
   show2
   max_level = 30
   len seen[] len port[] * (max_level + 1)
   cur[] &= aa
   cur_d[] &= -1
   cur_l[] &= 0
   while len cur[] > 0
      for i = 1 to len cur[]
         pos = cur[i]
         dir0 = cur_d[i]
         lev = cur_l[i]
         if pos = zz and lev = 0
            print n_steps
            break 2
         .
         if m[pos] >= 0 and dir0 <> -1
            is_inner pos res
            if res = 0 and lev = 0 or res = 1 and lev = max_level
               # ok
            else
               p = m[pos]
               if seen[p + len port[] * lev] = 0
                  seen[p + len port[] * lev] = 1
                  nxt[] &= port[p]
                  nxt_d[] &= -1
                  if res = 1
                     nxt_l[] &= lev + 1
                  else
                     nxt_l[] &= lev - 1
                  .
               .
            .
         else
            for dir = 1 to 4
               posn = pos + offs[dir]
               if dir0 <> dir and m[posn] >= -1
                  nxt[] &= posn
                  nxt_d[] &= (dir + 1) mod 4 + 1
                  nxt_l[] &= lev
               .
            .
         .
         mark2 pos 990 lev
      .
      n_steps += 1
      swap cur[] nxt[]
      len nxt[] 0
      swap cur_d[] nxt_d[]
      len nxt_d[] 0
      swap cur_l[] nxt_l[]
      len nxt_l[] 0
   .
.
part2
#
input_data
             Z L X W       C                .
             Z P Q B       K
  ###########.#.#.#.#######.###############
  #...#.......#.#.......#.#.......#.#.#...#
  ###.#.#.#.#.#.#.#.###.#.#.#######.#.#.###
  #.#...#.#.#...#.#.#...#...#...#.#.......#
  #.###.#######.###.###.#.###.###.#.#######
  #...#.......#.#...#...#.............#...#
  #.#########.#######.#.#######.#######.###
  #...#.#    F       R I       Z    #.#.#.#
  #.###.#    D       E C       H    #.#.#.#
  #.#...#                           #...#.#
  #.###.#                           #.###.#
  #.#....OA                       WB..#.#..ZH
  #.###.#                           #.#.#.#
CJ......#                           #.....#
  #######                           #######
  #.#####                           #.#####
  #.#####                           #.#####
  #######                           #######
  #.#####                           #.#####
  #.#####                           #.#####
  #######                           #######
  #######                           #######
  #######                           #######
  #.#....CK                         #......IC
  #.###.#                           #.###.#
  #.....#                           #...#.#
  ###.###                           #.#.#.#
XF....#.#                         RF..#.#.#
  #####.#                           #######
  #......CJ                       NM..#...#
  ###.#.#                           #.###.#
RE....#.#                           #......RF
  ###.###        X   X       L      #.#.#.#
  #.....#        F   Q       P      #.#.#.#
  ###.###########.###.#######.#########.###
  #.....#...#.....#.......#...#.....#.#...#
  #####.#.###.#######.#######.###.###.#.#.#
  #.......#.......#.#.#.#.#...#...#...#.#.#
  #####.###.#####.#.#.#.#.###.###.#.###.###
  #.......#.....#.#...#...............#...#
  #############.#.#.###.###################
               A O F   N
               A A D   M
