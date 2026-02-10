len d[] 20
fastfunc pown n p .
   r = 1
   for i = 1 to p : r *= n
   return r
.
fastfunc narcis n .
   h = n
   while h > 0
      i += 1
      d[i] = h mod 10
      h = h div 10
   .
   for j = 1 to i
      s += pown d[j] i
   .
   if s = n : return 1
   return 0
.
fastfunc next n .
   repeat
      n += 1
      until narcis n = 1
   .
   return n
.
n = -1
while cnt < 25
   n = next n
   write n & " "
   cnt += 1
.
print ""
