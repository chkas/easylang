# AoC-19 - Day 10: Monitoring Station
#
sys topleft
visual = 1
#
global w monitor_stat .
arrbase m[] 0
#
proc init . .
   s$ = input
   w = len s$
   while s$ <> ""
      for c$ in strchars s$
         m[] &= if c$ = "#"
      .
      s$ = input
   .
.
init
#
sc = 100 / w
background 000
proc show . .
   if visual = 0
      break 1
   .
   clear
   color 777
   for i range0 len m[]
      if m[i] = 1
         x = i mod w
         y = i div w
         move x * sc + sc / 2 y * sc + sc / 2
         circle 0.6
      .
   .
.
proc mark i . .
   if visual = 0
      break 1
   .
   color 900
   x = i mod w
   y = i div w
   move x * sc + sc / 2 y * sc + sc / 2
   circle 1
   sleep 0.04
.
proc show_ray x y . .
   if visual = 0
      break 1
   .
   color 944
   x0 = monitor_stat mod w
   y0 = monitor_stat div w
   move x0 * sc + sc / 2 y0 * sc + sc / 2
   line x * sc + sc / 2 y * sc + sc / 2
   sleep 0.02
.
proc gcd a b . res .
   a = abs a
   b = abs b
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   res = a
.
global dx dx[] dy[] .
proc get_rays stat . .
   dx[] = [ ]
   dy[] = [ ]
   arrbase dx[] 0
   arrbase dy[] 0
   x = stat mod w
   y = stat div w
   for i range0 len m[]
      if m[i] = 1 and i <> stat
         xi = i mod w
         yi = i div w
         dx = xi - x
         dy = yi - y
         gcd dx dy r
         dx = dx div r
         dy = dy div r
         for k range0 len dx[]
            if dx = dx[k] and dy = dy[k]
               break 1
            .
         .
         if k = len dx[]
            dx[] &= dx
            dy[] &= dy
         .
      .
   .
.
proc part1 . .
   for i range0 len m[]
      if m[i] = 1
         get_rays i
         if len dx[] > max
            monitor_stat = i
            max = len dx[]
            show
            mark monitor_stat
            sleep 0.02
         .
      .
   .
   print max
.
#
linewidth 0.5
#
proc find_next . dx dy ind .
   start_ang = atan2 dy dx
   ang = 1 / 0
   for i range0 len dx[]
      h = atan2 dy[i] dx[i]
      if h <= start_ang
         h += 360
      .
      if h < ang
         ang = h
         ind = i
      .
   .
.
n_shot = 0
proc fire ind . .
   x = monitor_stat mod w
   y = monitor_stat div w
   dx = dx[ind]
   dy = dy[ind]
   repeat
      x += dx
      y += dy
      if x < 0 or y < 0 or x >= w or y >= w
         dx[ind] = dx[len dx[] - 1]
         dy[ind] = dy[len dy[] - 1]
         len dx[] len dx[] - 1
         len dy[] len dy[] - 1
         break 2
      .
      until m[x + y * w] = 1
   .
   show_ray x y
   n_shot += 1
   if n_shot = 200
      print x * 100 + y
   .
   m[x + y * w] = 0
   show
   mark monitor_stat
.
proc part2 . .
   get_rays monitor_stat
   dy = -99999
   dx = -1
   repeat
      find_next dx dy ind
      dx = dx[ind]
      dy = dy[ind]
      fire ind
      until len dx[] = 0
   .
.
show
part1
mark monitor_stat
part2
#
input_data
.#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##



