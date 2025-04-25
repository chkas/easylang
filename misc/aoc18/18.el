# AoC-18 - Day 18: Settlers of The North Pole
#
visual = 1
#
global n .
arrbase f[] 0
#
proc read .
   s$ = input
   n = len s$ + 2
   len f[] n
   while s$ <> ""
      f[] &= 0
      for c$ in strchars s$
         if c$ = "|"
            f[] &= 1
         elif c$ = "#"
            f[] &= 10
         else
            f[] &= 0
         .
      .
      f[] &= 0
      s$ = input
   .
   len f[] len f[] + n
.
read
len p[] len f[]
arrbase p[] 0
#
if visual = 1
   move 10 60
   text "WARNING: Flashing"
   sleep 2
.
proc show .
   if visual = 0
      break 1
   .
   sz = 100 / (n - 2)
   sz8 = sz / 8
   sz16 = sz / 16
   clear
   for r range0 n - 2
      for c range0 n - 2
         i = r * n + n + c + 1
         if f[i] >= 1
            if f[i] = 1
               color 050
            else
               color 432
            .
            move c * sz + sz16 r * sz + sz16
            rect sz - sz8 sz - sz8
         .
      .
   .
   if n < 15
      sleep 0.5
   .
   sleep 0.01
.
proc update .
   swap f[] p[]
   for r range0 n - 2
      for c range0 n - 2
         i = r * n + n + c + 1
         s = 0
         in = i - n - 1
         for rn = 1 to 3
            for cn = 1 to 3
               s += p[in]
               in += 1
            .
            in += n - 3
         .
         s -= p[i]
         f[i] = p[i]
         if p[i] = 0
            if s mod 10 >= 3
               f[i] = 1
            .
         elif p[i] = 1
            if s >= 30
               f[i] = 10
            .
         elif p[i] = 10
            if s < 10 or s mod 10 < 1
               f[i] = 0
            .
         .
      .
   .
.
proc hash &res ..
   res = 0
   for i range0 len f[]
      res = (res + f[i]) * 65521 mod 137438953447
   .
.
proc sum &r ..
   for i range0 len f[]
      if f[i] = 1
         sumt += 1
      elif f[i] = 10
         suml += 1
      .
   .
   r = sumt * suml
.
proc run .
   arrbase hash[] 0
   for i to 10
      update
      show
   .
   sum res
   print res
   #
   while 1 = 1
      hash r
      for i range0 len hash[]
         if r = hash[i]
            break 2
         .
      .
      hash[] &= r
      update
      show
   .
   m = len hash[] - i
   ind = (1000000000 - i - 10) mod m
   for i range0 ind
      update
      show
   .
   sum res
   print res
.
run
#
input_data
.#.#...|#.
.....#|##|
.|..|...#.
..|#.....#
#.#|||#|#|
...#.||...
.|....|...
||...#|.#|
|.||||..|.
...#.|..|.


