fastfunc isprim num .
   i = 2
   while i <= sqrt num
      if num mod i = 0
         return 0
      .
      i += 1
   .
   return 1
.
repeat
   s$ = input
   until s$ = ""
   c$ = ""
   for c$ in strchars s$
      if isprim strcode c$ = 0
         break 1
      .
   .
   if c$ = ""
      print s$
   .
.
# the content of unixdict.txt 
input_data
10th
.
age
.
