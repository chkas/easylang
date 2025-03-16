fastfunc isprim num .
   i = 3
   while i <= sqrt num
      if num mod i = 0
         return 0
      .
      i += 2
   .
   return 1
.
nprim = 1
i = 3
repeat
   if isprim i = 1
      nprim += 1
   .
   until nprim = 10001
   i += 2
.
print i
