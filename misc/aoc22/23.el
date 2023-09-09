# AoC-22 - Day 23: Unstable Diffusion 
# 
nc = 200
len m[] nc * nc
global elf[] .
proc read . .
   s$ = input
   offs = nc div 2 - len s$ div 2
   r = offs
   while s$ <> ""
      c = offs
      for c$ in strchars s$
         ind = r * nc + c
         if c$ = "#"
            elf[] &= ind
         .
         c += 1
      .
      r += 1
      s$ = input
   .
.
read
#  
dirs[] = [ (-nc - 1) (-nc) (-nc + 1) 1 (nc + 1) nc (nc - 1) -1 ]
dir[][] &= [ -nc (-nc - 1) (-nc + 1) ]
dir[][] &= [ nc (nc - 1) nc + 1 ]
dir[][] &= [ -1 (-1 - nc) (-1 + nc) ]
dir[][] &= [ 1 (1 - nc) (1 + nc) ]
dir0 = 1
# 
nelf = len elf[]
len elfn[] nelf
# 
proc do . moved .
   for i to nelf
      m[elf[i]] = -1
   .
   for ie to nelf
      e = elf[ie]
      for i to 8
         d = dirs[i]
         if m[e + d] = -1
            break 1
         .
      .
      if i <= 8
         dir = dir0
         repeat
            h = e + dir[dir][1]
            if m[h] >= 0 and m[e + dir[dir][2]] >= 0 and m[e + dir[dir][3]] >= 0
               elfn[ie] = h
               m[h] += 1
               break 1
            .
            dir = (dir + 1) mod1 4
            until dir = dir0
         .
      .
   .
   dir0 = (dir0 + 1) mod1 4
   moved = 0
   for ie to nelf
      en = elfn[ie]
      if en > 0
         moved = 1
         elfn[ie] = 0
         if m[en] = 1
            m[elf[ie]] = 0
            elf[ie] = en
            m[en] = -1
         else
            m[en] = 0
         .
      .
   .
.
repeat
   round += 1
   do moved
   until moved = 0
   if round = 10
      minx = 1 / 0
      miny = minx
      for e in elf[]
         x = e mod nc
         y = e div nc
         minx = lower minx x
         maxx = higher maxx x
         miny = lower miny y
         maxy = higher maxy y
      .
      print (maxx - minx + 1) * (maxy - miny + 1) - nelf
   .
.
print round
# 
# 
input_data
....#..
..###.#
#...#.#
.#...##
#.###..
##.#.##
.#..#..


