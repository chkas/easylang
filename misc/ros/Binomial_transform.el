sysconf zero_based
#
func factorial n .
   f = 1
   for i = 2 to n : f *= i
   return f
.
func binomial n k .
   return factorial n / factorial (n - k) / factorial k
.
func[] btForward a[] .
   for n range0 len a[]
      b[] &= 0
      for k = 0 to n
         b[n] += binomial n k * a[k]
      .
   .
   return b[]
.
func[] btInverse b[] .
   for n range0 len b[]
      a[] &= 0
      for k = 0 to n
         h = binomial n k * b[k]
         if bitand (n - k) 1 > 0 : h *= -1
         a[n] += h
      .
   .
   return a[]
.
func[] btSelfInverting a[] .
   for n range0 len a[]
      b[] &= 0
      for k = 0 to n
         h = binomial n k * a[k]
         if bitand k 1 > 0 : h *= -1
         b[n] += h
      .
   .
   return b[]
.
seqs[][] = [ [ 1 1 2 5 14 42 132 429 1430 4862 16796 58786 208012 742900 2674440 9694845 35357670 129644790 477638700 1767263190 ] [ 0 1 1 0 1 0 1 0 0 0 1 0 1 0 0 0 1 0 1 0 ] [ 0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 ] [ 1 0 0 1 0 1 1 1 2 2 3 4 5 7 9 12 16 21 28 37 ] ]
names$[] = [ "Catalan number sequence:" "Prime flip-flop sequence:" "Fibonacci number sequence:" "Padovan number sequence:" ]
for i range0 4
   print names$[i]
   print seqs[i][]
   print "Forward binomial transform:"
   fwd[] = btForward seqs[i][]
   print fwd[]
   print "Inverse binomial transform:"
   print btInverse seqs[i][]
   print "Round trip:"
   print btInverse fwd[]
   print "Self-inverting:"
   fwd[] = btSelfInverting seqs[i][]
   print fwd[]
   print "Re-inverted:"
   print btSelfInverting fwd[]
   print ""
.
