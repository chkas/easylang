# AoC-20 - Day 6: Custom Customs
#
repeat
   s$ = input
   until s$ = "" and sp$ = ""
   inp$[] &= s$
   sp$ = s$
.
proc part1 . .
   len a[] 26
   inp = 1
   while inp <= len inp$[]
      repeat
         s$ = inp$[inp]
         until s$ = ""
         for c$ in strchars s$
            a[strcode c$ - 97 + 1] = 1
         .
         inp += 1
      .
      for i to 26
         sum += a[i]
         a[i] = 0
      .
      inp += 1
   .
   print sum
.
part1
#
proc part2 . .
   len b[] 26
   for i to 26 : a[] &= 1
   inp = 1
   while inp <= len inp$[]
      repeat
         s$ = inp$[inp]
         until s$ = ""
         for c$ in strchars s$
            b[strcode c$ - strcode "a" + 1] = 1
         .
         for i to 26
            a[i] *= b[i]
            b[i] = 0
         .
         inp += 1
      .
      for i to 26
         sum += a[i]
         a[i] = 1
      .
      inp += 1
   .
   print sum
.
part2
#
input_data
abc

a
b
c

ab
ac

a
a
a
a

b
