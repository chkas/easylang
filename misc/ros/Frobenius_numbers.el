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
prim = 2
repeat
   prim0 = prim
   prim = nextprim prim
   x = prim0 * prim - prim0 - prim
   until x >= 10000
   write x & " "
.
