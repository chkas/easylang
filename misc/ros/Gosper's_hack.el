func gospers_hack x .
   xm = bitnot x + 1
   c = bitand x xm
   r = x + c
   return bitor (bitshift bitxor r x -2 div c) r
.
for start in [ 1 3 7 15 ]
   write start & ": "
   x = start
   for i to 10
      x = gospers_hack x
      write x & " "
   .
   print ""
.
