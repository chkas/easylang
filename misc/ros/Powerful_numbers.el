proc sort &d[] .
   for i = 1 to len d[] - 1 : for j = i + 1 to len d[]
      if d[j] < d[i] : swap d[j] d[i]
   .
.
func isprim n .
   i = 2
   while i <= sqrt n
      if n mod i = 0 : return 0
      i += 1
   .
   return 1
.
func gcd a b .
   if b = 0 : return a
   return gcd b (a mod b)
.
for i = 2 to 99
   if isprim i = 1 : prims[] &= i
.
func isSquareFree x .
   for p in prims[]
      p2 = p * p
      if p2 > x : return 1
      if x mod p2 = 0 : return 0
   .
   print "xxx"
   return 1
.
func iroot x p .
   return pow x (1 / p)
.
func ipow x p .
   prod = 1
   while p > 0
      if p mod 2 <> 0 : prod *= x
      p = p div 2
      x *= x
   .
   return prod
.
global fk fn res[] .
proc f m r .
   if r < fk
      res[] &= m
      return
   .
   root = iroot (fn div m) r
   for v = 1 to root + 0.0001
      if r <= fk or isSquareFree v = 1 and gcd m v = 1
         f (m * pow v r) (r - 1)
      .
   .
.
func[] powerful n k .
   fn = n
   fk = k
   res[] = [ ]
   f 1 (2 * k - 1)
   sort res[]
   return res[]
.
p = 10
for k = 2 to 10
   p *= 10
   r[] = powerful p k
   write len r[] & " " & k & "-powerful numbers <= 10^" & k & ": "
   for i to 5 : write r[i] & " "
   write "... "
   for i = len r[] - 4 to len r[] : write r[i] & " "
   print ""
.
