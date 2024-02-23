fastfunc isprim num .
   if num mod 2 = 0
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
for n to 999
   cnt = 0
   for m to n
      cnt += if n mod m = 0
   .
   if cnt > 2 and isprim cnt = 1
      write n & " "
   .
.
