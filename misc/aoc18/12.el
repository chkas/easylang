# AoC-18 - Day 12: Subterranean Sustainability
#
n_rounds = 200
global f[] rul[] .
proc read .
   a$[] = strchars substr input 16 999
   len f[] 4 + 2 * n_rounds + len a$[]
   arrbase f[] 0
   #
   for i = 1 to len a$[]
      if a$[i] = "#"
         f[i + n_rounds + 1] = 1
      .
   .
   s$ = input
   s$ = s$
   #
   len rul[] 32
   arrbase rul[] 0
   repeat
      a$[] = strchars input
      until len a$[] = 0
      ri = 0
      for i = 1 to 5
         ri *= 2
         if a$[i] = "#" : ri += 1
      .
      if a$[10] = "#" : rul[ri] = 1
   .
.
read
#
proc run .
   len p[] len f[]
   arrbase p[] 0
   for ro = 1 to n_rounds
      sp = s
      s = 0
      swap f[] p[]
      for i = 2 to len f[] - 3
         ri = 0
         for j = -2 to 2
            ri *= 2
            ri += p[i + j]
         .
         f[i] = rul[ri]
         s += f[i] * (i - n_rounds - 2)
      .
      if ro = 20 : print s
   .
   dif = s - sp
   print 50000000000 * dif - n_rounds * dif + s
.
run
#
input_data
initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #

