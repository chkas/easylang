func cmp &a[] &b[] .
   for i = 1 to lower len a[] len b[]
      if a[i] < b[i] : return -1
      if a[i] > b[i] : return 1
   .
   return len a[] - len b[]
.
proc sort &d[][] .
   for i = 1 to len d[][] - 1 : for j = i + 1 to len d[][]
      if cmp d[i][] d[j][] > 0 : swap d[j][] d[i][]
   .
.
func[] divisors n .
   for i = 2 to n div 2
      if n mod i = 0 : divs[] &= i
   .
   return divs[]
.
len cache[] 100000
func erdosFactorCnt n .
   if n = 0 : return 0
   if cache[n] > 0 : return cache[n]
   sum = 1
   for d in divisors n : sum += erdosFactorCnt (n / d)
   cache[n] = sum
   return sum
.
divs48[] = divisors 48
func[][] moreMultiples toSeq[] .
   for v in divs48[]
      if v > toSeq[$] and v mod toSeq[$] = 0
         oneMores[][] &= toSeq[]
         oneMores[$][] &= v
      .
   .
   for i to len oneMores[][]
      s[][] = moreMultiples oneMores[i][]
      for j to len s[][]
         oneMores[][] &= [ ]
         swap oneMores[$][] s[j][]
      .
   .
   return oneMores[][]
.
list[][] = moreMultiples [ 1 ]
list[][] &= [ 1 ]
for i to len list[][] : list[i][] &= 48
sort list[][]
print len list[][] & " sequences using first definition:"
print list[][]
print ""
print len list[][] & " sequences using second definition:"
for i to len list[][]
   for j = 2 to len list[i][]
      list[i][j - 1] = list[i][j] / list[i][j - 1]
   .
   len list[i][] -1
.
print list[][]
print ""
print "OEIS A163272:"
repeat
   if erdosFactorCnt v = v
      write v & " "
      cnt += 1
   .
   until cnt = 7
   v += 1
   if v > 4 : v += 3
.
print ""
