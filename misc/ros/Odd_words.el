repeat
   s$ = input
   until s$ = ""
   if len s$ >= 5
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
   if len w$ >= 9
      h$[] = strchars w$
      h$ = ""
      for i = 1 step 2 to len h$[]
         h$ &= h$[i]
      .
      if binsearch h$ = 1
         print w$ & " -> " & h$
      .
   .
.
# the content of unixdict.txt 
input_data
10th
.
barbarian
.
brain
.
