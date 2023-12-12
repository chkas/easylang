# AoC-23 - Day 10: Pipe Maze
# 
global nc start m1[] m2[] .
# 
proc read . .
   s$ = input
   nc = len s$ + 1
   for i to nc
      m1[] &= 0 ; m2[] &= 0
   .
   repeat
      m1[] &= 0 ; m2[] &= 0
      for c$ in strchars s$
         if c$ = "|"
            m1[] &= 1 ; m2[] &= 3
         elif c$ = "-"
            m1[] &= 2 ; m2[] &= 4
         elif c$ = "L"
            m1[] &= 1 ; m2[] &= 2
         elif c$ = "J"
            m1[] &= 1 ; m2[] &= 4
         elif c$ = "7"
            m1[] &= 3 ; m2[] &= 4
         elif c$ = "F"
            m1[] &= 2 ; m2[] &= 3
         elif c$ = "S"
            m1[] &= -1 ; m2[] &= -1
            start = len m1[]
         else
            # "."
            m1[] &= 0 ; m2[] &= 0
         .
      .
      s$ = input
      until s$ = ""
   .
   for i to nc
      m1[] &= 0 ; m2[] &= 0
   .
.
call read
# 
offs[] = [ -nc 1 nc (-1) ]
proc step . pos dir .
   pos = pos + offs[dir]
   if m1[pos] = (dir + 2) mod1 4
      dir = m2[pos]
   elif m2[pos] = (dir + 2) mod1 4
      dir = m1[pos]
   else
      dir = 0
   .
.
proc try dir . cnt .
   pos = start
   cnt = 0
   repeat
      cnt += 1
      step pos dir
      until pos = start
      if dir = 0
         cnt = 0
         return
      .
   .
.
repeat
   startdir += 1
   try startdir cnt
   until cnt > 0
.
print cnt div 2
# 
len seen[] len m1[]
proc flood pos . .
   for i to 4
      p = pos + offs[i]
      if seen[p] = 0
         seen[p] = 2
         flood p
      .
   .
.
proc part2 . .
   pos = start
   dir = startdir
   repeat
      dirp = dir
      step pos dir
      seen[pos] = 1
      until pos = start
      if (dirp + 1) mod1 4 = dir
         turn -= 1
      elif (dirp - 1) mod1 4 = dir
         turn += 1
      .
   .
   dir = startdir
   turn = sign turn
   repeat
      dirp = dir
      step pos dir
      until pos = start
      j = (dirp + 2) mod1 4
      repeat
         j = (j + turn) mod1 4
         p = pos + offs[j]
         if seen[p] = 0
            seen[p] = 2
            flood p
         .
         until j = dir
      .
   .
   for s in seen[]
      sum += if s = 2
   .
   print sum
.
part2
# 
input_data
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L

