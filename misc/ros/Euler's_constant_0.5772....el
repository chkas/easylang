fastfunc gethn n .
   i = 1
   while i <= n
      hn += 1 / i
      i += 1
   .
   return hn
.
n = 10e8
numfmt 0 9
print gethn n - log n 0
