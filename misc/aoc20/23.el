# AoC-20 - Day 23: Crab Cups
#
global n next[] cur .
inp[] = number strchars input
#
proc init n0 .
   n = n0
   if n0 = 0 : n = len inp[]
   len next[] n
   cur = inp[1]
   h = cur
   for i = 2 to len inp[]
      next[h] = inp[i]
      h = next[h]
   .
   for i = i to n
      next[h] = i
      h = i
   .
   next[h] = cur
.
proc mov .
   tak1 = next[cur]
   tak2 = next[tak1]
   tak3 = next[tak2]
   next[cur] = next[tak3]
   dest = cur
   repeat
      dest = (dest - 2) mod n + 1
      until dest <> tak1 and dest <> tak2 and dest <> tak3
   .
   next[tak3] = next[dest]
   next[dest] = tak1
   cur = next[cur]
.
proc part1 .
   init 0
   for i to 100
      mov
   .
   h = next[1]
   while h <> 1
      s$ &= h
      h = next[h]
   .
   print s$
.
part1
#
proc part2 .
   init 1000000
   for i to 10000000
      mov
   .
   print next[1] * next[next[1]]
.
part2
#
input_data
389125467

