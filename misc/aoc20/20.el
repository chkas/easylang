# AoC-20 - Day 20: Jurassic Jigsaw
#
sysconf topleft
global id[] n[] ed[][] rev[] .
#
proc build_rev .
   for i range0 1024
      h = i
      v = 0
      for j range0 10
         v *= 2
         v = v + h mod 2
         h = h div 2
      .
      rev[] &= v
   .
   rev[] &= 1024
.
build_rev
#
proc edge_val s$ &n ..
   n = 0
   for i to 10
      n *= 2
      n += if substr s$ i 1 = "#"
   .
.
#
global img[] .
#
proc read .
   repeat
      s$ = input
      until s$ = ""
      id[] &= number substr s$ 6 4
      n[] &= 0
      s$ = input
      edge_val s$ n
      e[] &= n
      s1$ = substr s$ 1 1
      s2$ = substr s$ 10 1
      for ii to 8
         s$ = input
         for i = 2 to 9
            img[] &= if substr s$ i 1 = "#"
         .
         s1$ &= substr s$ 1 1
         s2$ &= substr s$ 10 1
      .
      s$ = input
      s1$ &= substr s$ 1 1
      s2$ &= substr s$ 10 1
      edge_val s2$ n
      e[] &= n
      edge_val s$ n
      e[] &= rev[n + 1]
      edge_val s1$ n
      e[] &= rev[n + 1]
      s$ = input
      ed[][] &= [ ]
      swap ed[len ed[][]][] e[]
   .
.
read
#
n_tiles = len ed[][]
#
proc part1 .
   prod = 1
   for c1 to n_tiles
      n = 0
      m[] = [ 0 0 0 0 ]
      for c2 to n_tiles
         if c1 <> c2
            m = 0
            for e1 to 4
               p1 = ed[c1][e1]
               if p1 <> 1024
                  for e2 to 4
                     p2 = ed[c2][e2]
                     if p1 = p2 or p1 = rev[p2 + 1]
                        m = 1
                        m[e1] = 1
                     .
                  .
               .
            .
            n += m
         .
      .
      n[c1] = n
      if n = 2
         prod *= id[c1]
      .
      if n < 4
         for e to 4
            if m[e] = 0
               ed[c1][e] = 1024
            .
         .
      .
   .
   print prod
.
part1
#
#
rows = sqrt n_tiles
#
proc turn i .
   swap h[] ed[i][]
   h = h[4]
   h[4] = h[3]
   h[3] = h[2]
   h[2] = h[1]
   h[1] = h
   swap h[] ed[i][]
.
#
proc flip i .
   swap h[] ed[i][]
   x = h[1]
   h[1] = rev[h[3] + 1]
   h[3] = rev[x + 1]
   h[2] = rev[h[2] + 1]
   h[4] = rev[h[4] + 1]
   swap h[] ed[i][]
.
#
proc turn_flip mode start r .
   len im[] r * r
   if mode = 1
      offs = 0
      inc = 1
      incr = 0
   elif mode = 2
      offs = r - 1
      inc = r
      incr = -r * r - 1
   elif mode = 3
      offs = r * r - 1
      inc = -1
      incr = 0
   elif mode = 4
      offs = r * r - r
      inc = -r
      incr = r * r + 1
   elif mode = 5
      offs = r * r - r
      inc = 1
      incr = -2 * r
   .
   s = start
   d += offs
   for y to r
      for x to r
         im[d + 1] = img[s + 1]
         d += inc
         s += 1
      .
      d += incr
   .
   for i to len im[]
      img[start + i] = im[i]
   .
.
#
# pr ed[][]
#
global imgids[] .
proc build .
   #
   len done[] n_tiles
   #
   for r range0 rows
      p1 = 1024
      for c range0 rows
         if r = 0
            p2 = 1024
         else
            i = imgids[(r - 1) * rows + c + 1]
            p2 = rev[ed[i][3] + 1]
         .
         for i to n_tiles
            if done[i] = 0
               for fl to 2
                  for tu to 4
                     if p1 = ed[i][4] and p2 = ed[i][1]
                        break 3
                     .
                     turn i
                  .
                  flip i
               .
            .
         .
         done[i] = 1
         p1 = rev[ed[i][2] + 1]
         imgids[] &= i
         start = (i - 1) * 64
         if fl = 2
            turn_flip 5 start 8
         .
         turn_flip tu start 8
      .
   .
.
build
#
proc expand_img .
   len imgn[] len img[]
   for r range0 rows
      for c range0 rows
         tile = imgids[r * rows + c + 1]
         for y range0 8
            for x range0 8
               s = (tile - 1) * 64 + y * 8 + x
               rd = y + r * 8
               cd = x + c * 8
               d = rd * rows * 8 + cd
               imgn[d + 1] = img[s + 1]
            .
         .
      .
   .
   swap imgn[] img[]
.
irows = rows * 8
expand_img
#
proc show_grafic .
   f = 100 / irows
   color 003
   rect 100 100
   for r range0 irows
      for c range0 irows
         i = r * irows + c + 1
         move c * f r * f
         if img[i] = 1
            color 227
            rect 1 * f 1 * f
         elif img[i] = 2
            color 900
            rect 1.1 * f 1.1 * f
         .
      .
   .
.
monster[][] &= [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 ]
monster[][] &= [ 1 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 1 1 1 ]
monster[][] &= [ 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 ]
#
proc search_monster &n_monster ..
   for r range0 irows - 3
      for c range0 irows - 20
         found = 1
         for mr range0 3
            for mc range0 20
               if monster[mr + 1][mc + 1] = 1
                  i = (r + mr) * irows + c + mc + 1
                  if img[i] <> 1
                     found = 0
                     break 2
                  .
               .
            .
         .
         if found = 1
            for mr range0 3
               for mc range0 20
                  if monster[mr + 1][mc + 1] = 1
                     i = (r + mr) * irows + c + mc + 1
                     img[i] = 2
                  .
               .
            .
            n_monster += 1
         .
      .
   .
   if n_monster > 0
      for i to len img[]
         sum += img[i]
      .
      print sum - n_monster * 30
      show_grafic
   .
.
for f range0 2
   for i range0 4
      search_monster found
      if found > 1
         break 2
      .
      turn_flip 2 0 irows
   .
   turn_flip 5 0 irows
.
#
#
input_data
Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...


