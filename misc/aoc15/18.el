# AoC-15 - Day 18: Like a GIF For Your Yard
#
visualization = 1
#
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
if len inp$[] = 0
   print "no input"
   random_seed 1
   for i to 100
      s$ = ""
      for j to 100
         if randomf < 0.3
            s$ &= "#"
         else
            s$ &= "."
         .
      .
      inp$[] &= s$
   .
.
#
n = len inp$[] + 1
global p[] f[] .
#
f = 100 / (n - 1)
gbackground 000
gcolor 543
proc show .
   if visualization = 1
      gclear
      for r to n - 1 : for c to n - 1
         if f[r * n + c + 1] = 1
            grect (c - 1) * f (r - 1) * f f * 0.9 f * 0.9
         .
      .
      sleep 0.05
   .
.
proc patch .
   f[n + 2] = 1
   f[n + n] = 1
   f[n * (n - 1) + 2] = 1
   f[n * n] = 1
.
proc update .
   swap f[] p[]
   for r to n - 1
      sm = 0
      i = r * n + 1
      sr = p[i - n + 1] + p[i + 1] + p[i + n + 1]
      for c to n - 1
         i += 1
         sl = sm
         sm = sr
         sr = p[i - n + 1] + p[i + 1] + p[i + n + 1]
         s = sl + sm + sr
         if s = 3 or s = 4 and p[i] = 1
            f[i] = 1
         else
            f[i] = 0
         .
      .
   .
.
for part to 2
   len f[] 0
   for i to n : f[] &= 0
   for s$ in inp$[]
      f[] &= 0
      for i to n - 1
         f[] &= if substr s$ i 1 = "#"
      .
   .
   for i to n + 1 : f[] &= 0
   if part = 2
      patch
   .
   len p[] len f[]
   for step to 100
      update
      if part = 2 : patch
      show
   .
   sum = 0
   for v in f[] : sum += v
   print sum
.
#
input_data
