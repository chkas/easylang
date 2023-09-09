# AoC-17 - Day 22: Sporifica Virus
# 
visual = 1
# 
nc = 1000
len m[] nc * nc
arrbase m[] 0
# 
background 000
subr show
   if visual = 0
      break 1
   .
   f = 100 / 70
   clear
   for r range0 70
      for c range0 70
         h = m[(r + nc div 2 - 35) * nc + c + nc div 2 - 35]
         if h > 0
            color 200 * h
            move c * f r * f
            rect f f
         .
      .
   .
   sleep 0
.
# 
s$ = input
l = len s$
p = nc div 2 + nc div 2 * nc
ii = p - l div 2 - l div 2 * nc
repeat
   for i to l
      m[ii] = 2 * if substr s$ i 1 = "#"
      ii += 1
   .
   s$ = input
   until s$ = ""
   ii += nc - l
   show
.
m0[] = m[]
# 
dir[] = [ -nc 1 nc -1 ]
dir = 1
for i range0 10000
   if m[p] = 0
      dir = (dir - 2) mod 4 + 1
      infections += 1
   else
      dir = dir mod 4 + 1
   .
   m[p] = (m[p] + 2) mod 4
   p += dir[dir]
   if i < 1700 and i mod 2 = 0
      show
   .
.
print infections
# 
swap m[] m0[]
p = nc div 2 + nc div 2 * nc
dir = 1
infections = 0
for i range0 10000000
   if m[p] = 0
      dir = (dir - 2) mod 4 + 1
   elif m[p] = 1
      infections += 1
   elif m[p] = 2
      dir = dir mod 4 + 1
   else
      dir = (dir + 1) mod 4 + 1
   .
   m[p] = (m[p] + 1) mod 4
   p += dir[dir]
   if i < 25000 and i mod 100 = 0
      show
   .
.
print infections
# 
input_data
..#
#..
...


