# AoC-25 - Day 6: Trash Compactor
#
repeat
   s$ = input
   until s$ = ""
   m$[][] &= strchars s$
   in$[][] &= strtok s$ " "
.
ncols = len in$[1][]
nrows = len in$[][] - 1
for i to ncols
   op$ = in$[$][i]
   s = 0
   if op$ = "*" : s = 1
   mlen = 0
   for j = 1 to nrows
      mlen = higher mlen len in$[j][i]
      if op$ = "*"
         s *= number in$[j][i]
      else
         s += number in$[j][i]
      .
   .
   sum += s
   mlen[] &= mlen
.
print sum
pos = 1
for i to ncols
   op$ = in$[$][i]
   s = 0
   if op$ = "*" : s = 1
   for p = pos to pos + mlen[i] - 1
      s$ = ""
      for j = 1 to nrows
         if p > len m$[j][]
            s$ &= " "
         else
            s$ &= m$[j][p]
         .
      .
      n = number s$
      if op$ = "*"
         s *= n
      else
         s += n
      .
   .
   sum2 += s
   pos += mlen[i] + 1
.
print sum2
#
input_data
123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +
