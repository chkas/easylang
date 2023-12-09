# AoC-23 - Day 9: Mirage Maintenance
# 
repeat
   s$ = input
   until s$ = ""
   a[] = number strsplit s$ " "
   r[] = [ ] ; l[] = [ ]
   while len a[] >= 2
      r[] &= a[len a[]]
      l[] &= a[1]
      for i = 2 to len a[]
         an[] &= a[i] - a[i - 1]
      .
      swap a[] an[]
      an[] = [ ]
   .
   r[] &= a[1]
   l[] &= a[1]
   #
   r = 0 ; l = 0
   for i = len r[] downto 1
      r = r[i] + r
      l = l[i] - l
   .
   sum1 += r
   sum2 += l
.
print sum1
print sum2
# 
input_data
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45