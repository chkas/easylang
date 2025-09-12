fastfunc isprim3 num .
   if num mod 2 = 0 : return 0
   i = 3
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 2
   .
   return 1
.
fastfunc divcnt n .
   tot = 1
   p = 2
   while p <= sqrt n
      cnt = 1
      while n mod p = 0
         cnt += 1
         n = n div p
      .
      p += 1
      tot *= cnt
   .
   if n > 1 : tot *= 2
   return tot
.
for n to 99999
   h = divcnt n
   if h > 2 and isprim3 h = 1
      write n & " "
   .
.
print ""
