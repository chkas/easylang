repeat
   s$ = input
   until s$ = ""
   if len s$ > 9
      c$ = ""
      h = -1
      for c$ in strchars s$
         h0 = h
         h = sign strpos "aeiou" c$
         if h0 = h
            break 1
         .
      .
      if c$ = ""
         print s$
      .
   .
.
# the content of unixdict.txt 
input_data
10th
.
aboriginal
.
