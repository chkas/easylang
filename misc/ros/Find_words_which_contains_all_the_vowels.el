repeat
   s$ = input
   until s$ = ""
   if len s$ > 10
      c[] = [ 0 0 0 0 0 0 ]
      for c$ in strchars s$
         h = strpos "aeiou" c$
         c[h + 1] += 1
      .
      if c[2] * c[3] * c[4] * c[5] * c[6] = 1
         print s$
      .
   .
.
# the content of unixdict.txt 
input_data
10th
1st
.
.
communicate
.
.
