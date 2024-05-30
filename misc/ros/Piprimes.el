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
n = 1
repeat
   write p & " "
   n += 1
   if isprim n = 1
      p += 1
   .
   until p = 22
.
