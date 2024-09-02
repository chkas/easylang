repeat
   s$ = input
   until s$ = ""
   if len s$ >= 3
      w$[] &= s$
   .
.
func binsearch s$ .
   max = len w$[] + 1
   while min + 1 < max
      mid = min + (max - min) div 2
      h = strcmp w$[mid] s$
      if h = 0
         return 1
      elif h < 0
         min = mid
      else
         max = mid
      .
   .
   return 0
.
for w$ in w$[]
   if len w$ >= 6
      a$ = ""
      b$ = ""
      for i to len w$
         if i mod 2 = 1
            a$ &= substr w$ i 1
         else
            b$ &= substr w$ i 1
         .
      .
      if binsearch a$ = 1 and binsearch b$ = 1
         print w$ & " -> " & a$ & " " & b$
      .
   .
.
# the content of unixdict.txt 
input_data
10th
.
fin
friend
red
