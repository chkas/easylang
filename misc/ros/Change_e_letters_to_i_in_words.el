repeat
   s$ = input
   until s$ = ""
   if len s$ > 5
      w$[] &= s$
   .
.
func search s$ .
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
   h$ = ""
   for c$ in strchars w$
      if c$ = "e"
         c$ = "i"
      .
      h$ &= c$
   .
   if h$ <> w$ and search h$ = 1
      print w$ & " -> " & h$
   .
.
# the content of unixdict.txt 
input_data
10th
.
analyses
analysis
.
