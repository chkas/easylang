# AoC-22 - Day 3: Rucksack Reorganization
#
func code c$ .
   c = strcode c$ - strcode "a" + 1
   if c < 1 : c += strcode "a" - strcode "A" + 26
   return c
.
#
global inp$[] .
proc read .
   repeat
      s$ = input
      until s$ = ""
      inp$[] &= s$
   .
.
read
#
proc part1 .
   len a[] 52
   for s$ in inp$[]
      for i = 1 to 52 : a[i] = 0
      l = len s$ div 2
      for c$ in strchars substr s$ 1 l : a[code c$] = 1
      for c$ in strchars substr s$ (l + 1) 99
         c = code c$
         if a[c] = 1
            a[c] = 0
            sum += c
         .
      .
   .
   print sum
.
part1
#
proc part2 .
   len a[] 52
   len b[] 52
   for ii = 1 step 3 to len inp$[] - 2
      for i = 1 to 52
         a[i] = 0
         b[i] = 0
      .
      for c$ in strchars inp$[ii] : a[code c$] = 1
      for c$ in strchars inp$[ii + 1] : b[code c$] = 1
      for c$ in strchars inp$[ii + 2]
         c = code c$
         if a[c] = 1 and b[c] = 1
            a[c] = 0
            sum += c
         .
      .
   .
   print sum
.
part2
#
input_data
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
