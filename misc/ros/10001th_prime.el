fastfunc isprim num .
   if num mod 2 = 0 and num > 2
      return 0
   .
   i = 3
   while i <= sqrt num
      if num mod i = 0
         return 0
      .
      i += 2
   .
   return 1
.
i = 2
repeat
   if isprim i = 1
      nprim += 1
   .
   until nprim = 10001
   i += 1
.
print i
