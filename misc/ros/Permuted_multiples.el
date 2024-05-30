func norm n .
   len f[] 10
   arrbase f[] 0
   while n > 0
      d = n mod 10
      f[d] += 1
      n = n div 10
   .
   for i = 0 to 9
      for j to f[i]
         r = r * 10 + i
      .
   .
   return r
.
repeat
   n += 1
   x = norm n
   for j = 2 to 6
      if norm (n * j) <> x
         break 1
      .
   .
   until j = 7
.
print n
