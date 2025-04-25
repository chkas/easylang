# AoC-24 - Day 15: : Warehouse Woes
#
global nc m$[] pos0 pos dir steps[] .
proc init .
   s$ = input
   nc = len s$
   while s$ <> ""
      for c$ in strchars s$
         if c$ = "@"
            m$[] &= "."
            pos0 = len m$[]
         else
            m$[] &= c$
         .
      .
      s$ = input
   .
   repeat
      s$ = input
      until s$ = ""
      for c$ in strchars s$
         steps[] &= strpos ">v<^" c$
      .
   .
   pos = pos0
.
init
global m2$[] .
proc prep2 .
   for c$ in m$[]
      if c$ = "O"
         m2$[] &= "["
         m2$[] &= "]"
      else
         m2$[] &= c$
         m2$[] &= c$
      .
   .
.
prep2
#
offs[] = [ 1 nc -1 (-nc) ]
#
#
proc calc .
   for i to len m$[]
      if m$[i] = "O" or m$[i] = "["
         r = (i - 1) div nc
         c = (i - 1) mod nc
         sum += r * 100 + c
      .
   .
   print sum
.
proc show .
   for i to len m$[]
      if i = pos
         s$ &= "@"
      else
         s$ &= m$[i]
      .
      if i mod nc = 0
         print s$
         s$ = ""
      .
   .
.
proc step1 .
   npos = pos + offs[dir]
   if m$[npos] = "#" : return
   if m$[npos] = "."
      pos = npos
      return
   .
   h = npos
   repeat
      h += offs[dir]
      if m$[h] = "#" : return
      until m$[h] = "."
   .
   repeat
      m$[h] = "O"
      h -= offs[dir]
      until h = npos
   .
   m$[npos] = "."
   pos = npos
.
proc part1 .
   for dir in steps[] : step1
   calc
.
part1
#
func isok p .
   np = p + offs[dir]
   if m$[np] = "." : return 1
   if m$[np] = "#" : return 0
   if isok np = 1
      if m$[np] = "["
         return isok (np + 1)
      else
         return isok (np - 1)
      .
   .
   return 0
.
proc shift p .
   np = p + offs[dir]
   if m$[np] = "]" : shift (np - 1)
   if m$[np] = "[" : shift np
   if m$[np + 1] = "[" : shift (np + 1)
   m$[np] = m$[p]
   m$[np + 1] = m$[p + 1]
   m$[p] = "."
   m$[p + 1] = "."
.
proc step2 .
   npos = pos + offs[dir]
   if m$[npos] = "#" : return
   if m$[npos] = "."
      pos = npos
      return
   .
   if dir = 1 or dir = 3
      h = npos
      repeat
         h += offs[dir]
         if m$[h] = "#" : return
         until m$[h] = "."
      .
      repeat
         m$[h] = m$[h - offs[dir]]
         h -= offs[dir]
         until h = npos
      .
      m$[npos] = "."
      pos = npos
      return
   .
   if isok pos = 1
      if m$[npos] = "["
         shift npos
      else
         shift (npos - 1)
      .
      pos = npos
   .
.
proc part2 .
   swap m$[] m2$[]
   pos = (pos0 - 1) * 2 + 1
   nc *= 2
   offs[] = [ 1 nc -1 (-nc) ]
   for dir in steps[] : step2
   calc
.
part2
#
input_data
##########
#..O..O.O#
#......O.#
#.OO..O.O#
#..O@..O.#
#O#..O...#
#O..O..O.#
#.OO.O.OO#
#....O...#
##########

<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
