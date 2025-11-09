# AoC-17 - Day 4: High-Entropy Passphrases
#
name$[] = [ ]
proc name n$ &ret .
   ret = 0
   for h$ in name$[]
      if h$ = n$
         ret = 1
         break 2
      .
   .
   name$[] &= n$
.
#
proc sort &s$ .
   d$[] = strchars s$
   for i to len d$[] - 1
      for j = i + 1 to len d$[]
         if strcode d$[j] < strcode d$[i]
            swap d$[j] d$[i]
         .
      .
   .
   s$ = strjoin d$[] ""
.
#
repeat
   in$ = input
   until in$ = ""
   name$[] = [ ]
   for s$ in strsplit in$ " "
      name s$ r
      if r = 1
         ndbl1 += 1
         break 1
      .
   .
   name$[] = [ ]
   for s$ in strsplit in$ " "
      sort s$
      name s$ r
      if r = 1
         ndbl2 += 1
         break 1
      .
   .
   n += 1
.
print n - ndbl1
print n - ndbl2
#
input_data
abcde fghij
abcde xyz ecdab
a ab abc abd abf abj
iiii oiii ooii oooi oooo
oiii ioii iioi iiio

