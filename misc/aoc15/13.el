# AoC-15 - Day 13: Knights of the Dinner Table
#
global name$[] .
proc getid n$ &id .
   for id to len name$[]
      if name$[id] = n$
         return
      .
   .
   name$[] &= n$
.
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
n = floor sqrt len inp$[] + 2
len h[] n * n + n
for s$ in inp$[]
   s$[] = strtok s$ " ."
   getid s$[1] a
   getid s$[11] b
   h = number s$[4]
   if s$[3] = "lose": h = -h
   h[a * n + b] = h
.
global permlist[][] perm[] .
proc mk_permlist k .
   for i = k to len perm[]
      swap perm[i] perm[k]
      mk_permlist k + 1
      swap perm[k] perm[i]
   .
   if k = len perm[]
      permlist[][] &= perm[]
   .
.
#
for part to 2
   perm[] = [ ]
   for i = 2 to n - 2 + part
      perm[] &= i
   .
   len permlist[][] 0
   mk_permlist 1
   #
   max = 0
   for p to len permlist[][]
      swap perm[] permlist[p][]
      perm[] &= 1
      np = len perm[]
      h = 0
      for i to np
         h += h[perm[i] * n + perm[i mod np + 1]]
         h += h[perm[i mod np + 1] * n + perm[i]]
      .
      max = higher h max
   .
   print max
.
#
input_data
Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol.
Alice would lose 2 happiness units by sitting next to David.
Bob would gain 83 happiness units by sitting next to Alice.
Bob would lose 7 happiness units by sitting next to Carol.
Bob would lose 63 happiness units by sitting next to David.
Carol would lose 62 happiness units by sitting next to Alice.
Carol would gain 60 happiness units by sitting next to Bob.
Carol would gain 55 happiness units by sitting next to David.
David would gain 46 happiness units by sitting next to Alice.
David would lose 7 happiness units by sitting next to Bob.
David would gain 41 happiness units by sitting next to Carol.


