global d[] .
func circsort lo hi swaps .
   if lo = hi
      return swaps
   .
   high = hi
   low = lo
   mid = (hi - lo) div 2
   while lo < hi
      if d[lo] > d[hi]
         swap d[lo] d[hi]
         swaps += 1
      .
      lo += 1
      hi -= 1
   .
   if lo = hi
      if d[lo] > d[hi + 1]
         swap d[lo] d[hi + 1]
         swaps += 1
      .
   .
   swaps = circsort low (low + mid) swaps
   swaps = circsort (low + mid + 1) high swaps
   return swaps
.
d[] = [ -4 -1 1 0 5 -7 -2 4 -6 -3 2 6 3 7 -5 ]
while circsort 1 len d[] 0 > 0
   # 
.
print d[]
