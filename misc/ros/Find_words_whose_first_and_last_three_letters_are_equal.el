repeat
   s$ = input
   until s$ = ""
   l = len s$
   if l > 5
      if substr s$ 1 3 = substr s$ (l - 2) 3
         print s$
      .
   .
.
# the content of unixdict.txt 
input_data
10th
.
einstein
.
