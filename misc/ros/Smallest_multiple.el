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
n = 20
res = 1
for p = 2 to n
   if isprim p = 1
      f = p
      while f * p <= n
         f = f * p
      .
      res *= f
   .
.
print res
