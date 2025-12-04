# AoC-25 - Day 2: Gift Shop
#
fastfunc isinv1 n .
   e = 10
   repeat
      a = n mod e
      b = n div e
      until a >= b
      e *= 10
   .
   if a = b and a * 10 >= e : return 1
   return 0
.
fastfunc isinv2 n0 .
   e = 10
   while e < n0
      d = n0 mod e
      n = n0 div e
      while n >= e / 10 and n mod e = d
         n = n div e
      .
      if n = 0 : return 1
      e = e * 10
   .
   return 0
.
a[] = number strtok input "-,"
for r = 1 step 2 to len a[]
   for n = a[r] to a[r + 1]
      if isinv1 n = 1 : inva1 += n
      if isinv2 n = 1 : inva2 += n
   .
.
print inva1
print inva2
#
input_data
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
