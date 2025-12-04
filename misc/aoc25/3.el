# AoC-25 - Day 3: Lobby
#
func getvolt s$ mcnt .
   a[] = number strchars s$
   for cnt = 1 to mcnt
      mi += 1
      for i = mi + 1 to len a[] - 12 + cnt
         if a[i] > a[mi] : mi = i
      .
      v = v * 10 + a[mi]
   .
   return v
.
repeat
   s$ = input
   until s$ = ""
   sum1 += getvolt s$ 2
   sum2 += getvolt s$ 12
.
print sum1
print sum2
#
input_data
987654321111111
811111111111119
234234234234278
818181911112111
