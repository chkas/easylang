func isint x .
   if x mod 1 = 0
      return 1
   .
.
num[] = [ 25.000000 24.999999 25.0001 -2.1e120 -5e-2 0 / 0 1 / 0 ]
# 
numfmt 10 0
for n in num[]
   write n & " -> "
   if isint n = 1
      print "integer"
   else
      print "no integer"
   .
.
