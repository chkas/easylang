# AoC-23 - Day 16: The Floor Will Be Lava
# 
global nc nr m$[] .
proc init . .
   s$ = input
   nc = len s$ + 1
   for i to nc ; m$[] &= " " ; .
   repeat
      for c$ in strchars s$
         m$[] &= c$
      .
      m$[] &= " "
      nr += 1
      s$ = input
      until s$ = ""
   .
   for i to nc ; m$[] &= " " ; .
.
init
# 
dir[] = [ 1 nc (-1) (-nc) ]
proc beam p d . seen[] .
   repeat
      m$ = m$[p]
      until m$ = " " or bitand seen[p] bitshift 1 d > 0
      seen[p] = bitor seen[p] bitshift 1 d
      if m$ = "|"
         if d mod 2 = 1
            beam p + dir[4] 4 seen[]
            d = 2
         .
      elif m$ = "-"
         if d mod 2 = 0
            beam p + dir[3] 3 seen[]
            d = 1
         .
      elif m$ = "/"
         d = 5 - d
      elif m$ = "\\"
         if d <= 2
            d = 3 - d
         else
            d = 7 - d
         .
      .
      p = p + dir[d]
   .
.
func go p d .
   len seen[] len m$[]
   beam p d seen[]
   for m in seen[]
      sum += if m > 0
   .
   return sum
.
print go (nc + 1) 1
for c = 1 to nc
   max = higher max go (nc + c) 2
   max = higher max go (nc * nr + c) 4
.
for r = 1 to nr
   max = higher max go (nc * r + 1) 1
   max = higher max go (nc * r + nc - 1) 3
.
print max
# 
input_data
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....
