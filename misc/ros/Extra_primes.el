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
func digprim n .
   while n > 0
      d = n mod 10
      if d < 2 or d = 4 or d = 6 or d >= 8
         return 0
      .
      sum += d
      n = n div 10
   .
   return isprim sum
.
p = 2
while p < 10000
   if isprim p = 1 and digprim p = 1
      write p & " "
   .
   p += 1
.
