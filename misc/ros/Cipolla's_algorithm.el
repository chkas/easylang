func mul_mod a b m .
   y = a mod m
   while b > 0
      if b mod 2 = 1 : x = (x + y) mod m
      y = 2 * y mod m
      b = b div 2
   .
   return x
.
func pow_mod b p m .
   x = 1
   while p > 0
      if p mod 2 = 1 : x = mul_mod x b m
      b = mul_mod b b m
      p = p div 2
   .
   return x
.
fastfunc isprim num .
   i = 2
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 1
   .
   return 1
.
func legendre a p .
   x = pow_mod a ((p - 1) / 2) p
   if p - 1 = x : return x - p
   return x
.
func[] fp2mul a[] b[] p w2 .
   tmp1 = mul_mod a[1] b[1] p
   tmp2 = mul_mod a[2] b[2] p
   tmp2 = mul_mod tmp2 w2 p
   ans[] &= (tmp1 + tmp2) mod p
   tmp1 = mul_mod a[1] b[2] p
   tmp2 = mul_mod a[2] b[1] p
   ans[] &= (tmp1 + tmp2) mod p
   return ans[]
.
func[] fp2square a[] p w2 .
   return fp2mul a[] a[] p w2
.
func[] fp2pow a[] n p w2 .
   if n = 0 : return [ 1 0 ]
   if n = 1 : return a[]
   if n mod 2 = 0 : return fp2square fp2pow a[] (n / 2) p w2 p w2
   return fp2mul a[] fp2pow a[] (n - 1) p w2 p w2
.
proc test n p .
   write "n = " & n & " p = " & p & " -> "
   if p = 2 or isprim p = 0 or legendre n p <> 1
      print "no solution"
      return
   .
   while 1 = 1
      repeat
         a = random (p - 2) + 1
         w2 = a * a - n
         until legendre w2 p = -1
      .
      ans[] = [ a 1 ]
      ans[] = fp2pow ans[] ((p + 1) / 2) p w2
      if ans[2] = 0
         x1 = ans[1]
         x2 = p - x1
         if mul_mod x1 x1 p = n and mul_mod x2 x2 p = n
            print " x1 = " & x1 & " x2 = " & x2
            return
         .
      .
   .
.
test 10 13
test 56 101
test 8218 10007
test 8219 10007
test 331575 1000003
test 665165880 1000000007
