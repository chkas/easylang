# AoC-21 - Day 25: Sea Cucumber
# 
# Updating happens in-place. Therefore you
# have to notice if a cucumber has moved
# in order not to move it again.
# 
visualization = 1
# 
sys topleft
global m[] nc .
background 001
col[] = [ 0 030 060 ]
proc show . .
   if visualization = 0
      break 1
   .
   clear
   sc = 100 / nc
   sc1 = sc * 1.1
   for i to len m[]
      if m[i] >= 1
         color col[m[i]]
         x = (i - 1) mod nc
         y = (i - 1) div nc
         move sc * x sc * y
         rect sc1 sc1
      .
   .
   sleep 0.01
.
proc step . done .
   nr = len m[] / nc
   done = 1
   for i to len m[]
      if i mod nc = 1
         v0 = m[i]
         moved = 0
      .
      if moved = 1
         moved = 0
      elif m[i] = 1
         in = i + 1
         if in mod nc = 1
            in -= nc
            h = v0
         else
            h = m[in]
         .
         if h = 0
            m[in] = 1
            m[i] = 0
            moved = 1
            done = 0
         .
      .
   .
   for c to nc
      i = c
      v0 = m[i]
      moved = 0
      for r to nr
         if moved = 1
            moved = 0
         elif m[i] = 2
            in = i + nc
            if r = nr
               in = c
               h = v0
            else
               h = m[in]
            .
            if h = 0
               m[in] = 2
               m[i] = 0
               moved = 1
               done = 0
            .
         .
         i += nc
      .
   .
.
# 
repeat
   s$ = input
   until s$ = ""
   nc = len s$
   for c$ in strchars s$
      if c$ = ">"
         m[] &= 1
      elif c$ = "v"
         m[] &= 2
      else
         m[] &= 0
      .
   .
.
for st to 9999
   step done
   show
   if done = 1
      print st
      break 1
   .
.
# 
input_data
v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>


