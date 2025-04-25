func gcd a b .
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   return a
.
proc test p[] .
   if gcd p[1] p[2] = 1
      print p[]
   .
.
pairs[][] = [ [ 21 15 ] [ 17 23 ] [ 36 12 ] [ 18 29 ] [ 60 15 ] ]
for i to len pairs[][]
   test pairs[i][]
.
