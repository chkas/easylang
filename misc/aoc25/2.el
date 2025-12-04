# AoC-25 - Day 2: Gift Shop
#
func isinv1 n$ .
   ln = len n$
   return if substr n$ 1 (ln div 2) = substr n$ (ln div 2 + 1) 999
.
func isinv2 n$ .
   ln = len n$
   for lt = 1 to ln div 2
      t$ = substr n$ 1 lt
      for i = lt + 1 step lt to ln
         if substr n$ i lt <> t$ : break 1
      .
      if i > ln : return 1
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
