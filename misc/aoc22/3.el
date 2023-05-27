# AoC-22 - Day 3: Rucksack Reorganization
# 
proc code c$ . c .
   c = strcode c$ - strcode "a" + 1
   if c < 1
      c += strcode "a" - strcode "A" + 26
   .
.
len a[] 52
len b[] 52
# 
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
   l = len s$ div 2
   for c$ in strchars substr s$ 1 l
      call code c$ c
      a[c] = 1
   .
   for c$ in strchars substr s$ l + 1 -1
      call code c$ c
      if a[c] = 1
         a[c] = 0
         sum += c
      .
   .
   for i = 1 to 52
      a[i] = 0
   .
.
print sum
# 
sum = 0
for ii = 1 step 3 to len inp$[] - 2
   for c$ in strchars inp$[ii]
      call code c$ c
      a[c] = 1
   .
   for c$ in strchars inp$[ii + 1]
      call code c$ c
      b[c] = 1
   .
   for c$ in strchars inp$[ii + 2]
      call code c$ c
      if a[c] = 1 and b[c] = 1
         a[c] = 0
         sum += c
      .
   .
   for i = 1 to 52
      a[i] = 0
      b[i] = 0
   .
.
print sum
# 
input_data
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw

