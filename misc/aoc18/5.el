# AoC-18 - Day 5: Alchemical Reduction
#
a0$ = input
#
proc reduce &a$ .
   repeat
      a$[] = strchars a$
      i = 1
      done = 1
      while i < len a$[]
         h = strcode a$[i] - strcode a$[i + 1]
         if abs h = 32
            a$[i] = ""
            a$[i + 1] = ""
            i += 2
            done = 0
         else
            i += 1
         .
      .
      a$ = strjoin a$[] ""
      until done = 1
   .
.
a$ = a0$
reduce a$
print len a$
#
min = 50000
for k to 26
   x1$ = strchar (k + 64)
   x2$ = strchar (k + 96)
   a$[] = strchars a0$
   for i to len a$[]
      if a$[i] = x1$ or a$[i] = x2$
         a$[i] = ""
      .
   .
   a$ = strjoin a$[] ""
   reduce a$
   min = lower len a$ min
.
print min
#
input_data
dabAcCaCBAcCcaDA

