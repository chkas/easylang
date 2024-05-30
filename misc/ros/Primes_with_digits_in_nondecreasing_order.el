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
fastfunc nextprim prim .
   repeat
      prim += 1
      until isprim prim = 1
   .
   return prim
.
func digok n .
   d = 9
   while n > 0
      dp = d
      d = n mod 10
      if dp < d
         return 0
      .
      n = n div 10
   .
   return 1
.
p = 2
repeat
   if digok p = 1
      write p & " "
   .
   p = nextprim p
   until p >= 1000
.
