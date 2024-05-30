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
func digodd n .
   while n > 0
      r += if n mod 2 = 1
      n = n div 10
   .
   return r
.
p = 2
repeat
   if digodd p = 1
      write p & " "
   .
   p = nextprim p
   until p >= 1000
.
