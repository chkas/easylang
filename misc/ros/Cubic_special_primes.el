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
p = 2
n = 1
write 2 & " "
repeat
   h = p + n * n * n
   until h >= 15000
   if isprim h = 1
      p = h
      n = 1
      write p & " "
   else
      n += 1
   .
.
