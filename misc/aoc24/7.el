# AoC-24 - Day 7: Bridge Repair
#
func cutend a b .
   h = pow 10 (floor log10 b + 1)
   if a mod h = b : return a div h
   return 0
.
global part .
#
func valid r a[] .
   if len a[] = 2 : return if r = a[2]
   v = a[$]
   len a[] -1
   if valid (r - v) a[] = 1 : return 1
   if r mod v = 0
      if valid (r / v) a[] = 1 : return 1
   .
   if part = 2
      h = cutend r v
      if h > 0 and valid h a[] = 1 : return 1
   .
   return 0
.
repeat
   s$ = input
   until s$ = ""
   a[] = number strsplit s$ " "
   part = 1
   if valid a[1] a[] = 1 : sum1 += a[1]
   part = 2
   if valid a[1] a[] = 1 : sum2 += a[1]
.
print sum1
print sum2
#
input_data
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20

