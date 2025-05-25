fastfunc isprim num .
   if num < 2 : return 0
   i = 2
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 1
   .
   return 1
.
func iserdosprim p .
   if isprim p = 0 : return 0
   k = 1
   f = 1
   while f < p
      if isprim (p - f) = 1 : return 0
      k += 1
      f *= k
   .
   return 1
.
for p = 2 to 2499
   if iserdosprim p = 1 : write p & " "
.
