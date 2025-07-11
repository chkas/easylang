# AoC-20 - Day 24: Lobby Layout
#
sysconf topleft
visual = 1
#
global go[][] nc .
proc read .
   l = 1
   repeat
      s$ = input
      until s$ = ""
      go[][] &= [ ]
      s$[] = strchars s$
      i = 1
      while i <= len s$[]
         c$ = s$[i]
         i += 1
         if c$ = "w"
            go[l][] &= 1
         elif c$ = "e"
            go[l][] &= 4
         else
            c$ &= s$[i]
            i += 1
            if c$ = "nw"
               go[l][] &= 2
            elif c$ = "ne"
               go[l][] &= 3
            elif c$ = "se"
               go[l][] &= 5
            elif c$ = "sw"
               go[l][] &= 6
            .
         .
      .
      l += 1
   .
   nc = 150
.
read
len m[] nc * nc
dirs_even[] = [ -1 (-nc - 1) (-nc) 1 nc (nc - 1) ]
dirs_odd[] = [ -1 (-nc) (-nc + 1) 1 (nc + 1) nc ]
#
proc sum_black &s .
   s = 0
   for i to len m[] : s += m[i]
.
gbackground 000
proc show .
   if visual = 0 : return
   #
   srow = 30
   offs = (nc - srow) div 2
   gclear
   f = 100 / srow
   f2 = f / 2
   f4 = f / 4
   fd = f / 16
   fd2 = fd / 2
   f34 = f2 + f4
   glinewidth f / 30
   for r range0 srow + 1 : for c range0 srow + 1
      x = c * f + fd2
      y = r * f34 - f4 + fd2
      if r mod 2 = 1
         x -= f2
      .
      x2 = x + f2
      xn = x + f - fd2
      #
      y1 = y + f4 + fd2
      y2 = y + f34 - fd2
      yn = y + f - fd2
      ind = (r + offs) * nc + c + offs + 1
      if m[ind] = 1
         gcolor 222
      else
         gcolor 765
      .
      gpolygon [ x y1 x2 y xn y1 xn y2 x2 yn x y2 x y1 ]
   .
   gcolor 111
   grect 0 (srow + 1) * f34 - f4 100 100 - srow * f34
   gcolor 888
   sum_black sum
   gtext 5 85 sum & " black tiles"
   sleep 0.03
.
proc show2 .
   if visual = 0 : return
   f = 100 / nc
   f2 = f / 2
   f34 = f2 + f / 4
   f4 = f / 4
   gcolor 765
   grect 0 0 100 nc * f34
   for r range0 nc : for c range0 nc
      ind = r * nc + c + 1
      if m[ind] = 1
         x = c * f
         y = r * f34 - f4
         if r mod 2 = 1
            x -= f2
         .
         gcolor 222
         grect x y f f
      .
   .
   gcolor 111
   grect 0 nc * f34 - f4 100 100 - nc * f34
   gcolor 888
   sum_black sum
   gtext 5 85 sum & " black tiles"
   sleep 0.1
.
proc part1 .
   start = nc * (nc div 2) + nc div 2
   for l to len go[][]
      pos = start
      for i to len go[l][]
         r = pos div nc
         if r mod 2 = 0
            pos += dirs_even[go[l][i]]
         else
            pos += dirs_odd[go[l][i]]
         .
      .
      m[pos] = 1 - m[pos]
      show
   .
   sum_black sum
   print sum
.
part1
#
len p[] len m[]
proc update .
   swap m[] p[]
   for r to nc - 2 : for c to nc - 2
      pos = r * nc + c
      s = 0
      if r mod 2 = 0
         for j to 6
            d = dirs_even[j]
            s += p[pos + d]
         .
      else
         for j to 6
            d = dirs_odd[j]
            s += p[pos + d]
         .
      .
      if p[pos] = 0 and s = 2
         m[pos] = 1
      elif p[pos] = 1 and (s = 0 or s > 2)
         m[pos] = 0
      else
         m[pos] = p[pos]
      .
   .
.
proc part2 .
   for i to 100
      update
      if i <= 10
         show
         sleep 0.3
      else
         if i mod 5 = 0 : show2
      .
   .
   sum_black sum
   print sum
.
if visual = 1 : sleep 1
part2
#
#
input_data
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
