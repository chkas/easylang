func perm x y .
   z = 1
   for i = x - y + 1 to x
      z *= i
   .
   return z
.
func fact x .
   z = 1
   for i = 2 to x
      z *= i
   .
   return z
.
func comb x y .
   if x - y < y
      y = x - y
   .
   return perm x y / fact y
.
#
e = 2.7182818284590452354
func log n .
   return log10 n / log10 e
.
func lstirling n .
   if n < 10
      return lstirling (n + 1) - log (n + 1)
   .
   return 0.5 * log (2 * pi * n) + n * log (n / e + 1 / (12 * e * n))
.
func$ tolog v .
   h = v div log 10
   return pow e (v - h * log 10) & "e" & h
.
func$ permf n k .
   return tolog (lstirling n - lstirling (n - k))
.
func$ combf n k .
   return tolog (lstirling n - lstirling (n - k) - lstirling k)
.
print "=> Exact results:"
for n = 1 to 12
   p = n div 3
   print "P(" & n & "," & p & ")=" & perm n p
.
# 
# double has 53 bits for integer
# 
for n = 10 step 10 to 50
   p = n div 3
   print "C(" & n & "," & p & ")=" & comb n p
.
# 
print ""
print "=> Floating point approximations:"
for n in [ 5 50 500 1000 5000 15000 ]
   p = n div 3
   print "P(" & n & "," & p & ")=" & permf n p
.
for n = 100 step 100 to 1000
   p = n div 3
   print "C(" & n & "," & p & ")=" & combf n p
.
