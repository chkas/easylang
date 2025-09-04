proc set &mem[] ind .
   msk = bitshift 1 (ind mod 48)
   ind = ind div 48
   mem[ind] = bitor mem[ind] msk
.
func get &mem[] ind .
   msk = bitshift 1 (ind mod 48)
   return bitand mem[ind div 48] msk
.
global primes[] .
proc mkprimes n .
   arrbase mem[] 0
   len mem[] n div 48 + 1
   max = sqrt n
   for d = 2 to max
      if get mem[] d = 0
         for i = d * d step d to n
            set mem[] i
         .
      .
   .
   primes[] = [ ]
   for i = 2 to n
      if get mem[] i = 0 : primes[] &= i
   .
.
func phi x a .
   while a > 1
      pa = primes[a]
      if x <= pa : return 1
      sum += phi (x div pa) (a - 1)
      a -= 1
   .
   return x - (x div 2) - sum
.
func pix n .
   if n < 2 : return 0
   if n = 2 : return 1
   mkprimes n
   a = len primes[]
   return phi n a + a - 1
.
for i = 0 to 9
   n = pow 10 i
   print "10^" & i & "  " & pix n
.
