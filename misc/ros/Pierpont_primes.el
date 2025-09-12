fastfunc isprim num .
   if num < 2 : return 0
   if num mod 2 = 0 and num > 2 : return 0
   i = 3
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 2
   .
   return 1
.
fastfunc mod2x3x n .
   while n mod 2 = 0 : n /= 2
   while n mod 3 = 0 : n /= 3
   return n
.
proc show50 offs .
   i = 1
   while cnt < 50
      if mod2x3x i = 1 and isprim (i + offs) = 1
         cnt += 1
         write i + offs & " "
      .
      i += 1
   .
   print ""
   print ""
.
show50 1
show50 -1
