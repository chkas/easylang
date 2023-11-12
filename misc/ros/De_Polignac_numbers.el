func isprim num .
   i = 2
   while i <= sqrt num
      if num mod i = 0
         return 0
      .
      i += 1
   .
   return 1
.
p = 2
for i to 20
   pow2[] &= p
   p *= 2
.
n = 1
while count < 50
   j = 1
   repeat
      p = pow2[j]
      until p > n or isprim (n - p) = 1
      j += 1
   .
   if p > n
      count += 1
      print n
   .
   n += 2
.
