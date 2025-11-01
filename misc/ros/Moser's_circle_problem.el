lim = 20
# 
func binomial n k .
   if k < 0 or k > n : return 0
   r = 1
   for i = 1 to k : r = r * (n - i + 1) / i
   return r
.
func[] binomial_trans p .
   for n = 0 to p - 1
      s = 0
      for k = 0 to lower n 4 : s += binomial n k
      res[] &= s
   .
   return res[]
.
func[] pascal_tri p .
   len a[][] p
   for i to p : len a[i][] p
   for r to p
      a[r][1] = 1
      if r > 1 : for c = 2 to r
         a[r][c] = a[r - 1][c - 1] + a[r - 1][c]
      .
   .
   for r = 1 to p
      res[] &= 0
      for c to 5 : res[r] += a[r][c]
   .
   return res[]
.
func moser n .
   pn = n
   res = 24
   for c in [ -18 23 -6 1 ]
      res += c * pn
      pn *= n
   .
   return res / 24
.
print "Direct calculation of a 4th order equation:"
for i = 1 to lim : write moser i & " "
print "\n\nUsing a binomial sums:"
for i = 1 to lim : write binomial i 4 + binomial i 2 + 1 & " "
print "\n\nUsing a binomial transform:"
for v in binomial_trans lim : write v & " "
print "\n\nPartial sums of Pascals triangle:"
for v in pascal_tri lim : write v & " "
print ""
