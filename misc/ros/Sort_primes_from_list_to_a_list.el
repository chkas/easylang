fastfunc isprim num .
   i = 2
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 1
   .
   return 1
.
proc sort &d[] .
   for i = 1 to len d[] - 1 : for j = i + 1 to len d[]
      if d[j] < d[i] : swap d[j] d[i]
   .
.
inp[] = [ 2 43 81 122 63 13 7 95 103 ]
for v in inp[]
   if isprim v = 1 : d[] &= v
.
sort d[]
print d[]
