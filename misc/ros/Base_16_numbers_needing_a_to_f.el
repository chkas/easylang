func has_hexdig n .
   while n > 0
      d = n mod 16
      if d >= 10
         return 1
      .
      n = n div 16
   .
   return 0
.
for i to 500
   if has_hexdig i = 1
      write i & " "
   .
.
