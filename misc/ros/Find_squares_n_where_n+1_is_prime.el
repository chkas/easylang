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
n0 = 1
repeat
   n = n0 * n0
   until n >= 1000
   if isprim (n + 1) = 1
      write n & " "
   .
   n0 += 1
.
