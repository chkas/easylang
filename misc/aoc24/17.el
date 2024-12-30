# AoC-24 - Day 17: Chronospatial Computer
#
s$ = input
a0 = number substr s$ 13 99
s$ = input
s$ = input
s$ = input
s$ = s$
prog[] = number strsplit substr input 10 9999 ","
#
proc run a . out[] .
   out[] = [ ]
   pc = 1
   repeat
      in = prog[pc]
      lit = prog[pc + 1]
      if lit <= 3
         com = lit
      elif lit = 4
         com = a
      elif lit = 5
         com = b
      elif lit = 6
         com = c
      .
      if in = 0
         a = bitshift a -com
      elif in = 1
         b = bitxor b lit
      elif in = 2
         b = bitand com 7
      elif in = 3
         if a <> 0
            pc = lit + 1
            pc -= 2
         .
      elif in = 4
         b = bitxor b c
      elif in = 5
         out[] &= bitand com 7
      elif in = 6
         b = bitshift a -com
      elif in = 7
         c = bitshift a -com
      .
      pc += 2
      until pc > len prog[]
   .
.
proc part1 . .
   run a0 out[]
   for i to len out[] - 1 : write out[i] & ","
   print out[i]
.
part1
#
proc test ndig . r[] .
   swap r[] r0[]
   for r in r0[]
      for h = r * 8 to r * 8 + 7
         run h out[]
         for i to ndig
            if prog[$ - ndig + i] <> out[i] : break 1
         .
         if i > ndig and h > 0 : r[] &= h
      .
   .
.
#
proc part2 . .
   if len prog[] < 16 : return
   r[] = [ 0 ]
   for ndig = 1 to 16 : test ndig r[]
   print r[1]
.
part2
#
input_data
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
