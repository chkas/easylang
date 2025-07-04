func isAntisymmetric a[][] .
   n = len a[][]
   for i to n
      if a[i][i] <> 0 : return 0
      for j = i + 1 to n : if a[i][j] <> -a[j][i] : return 0
   .
   return 1
.
func fac n .
   for i to n - 1 : n *= i
   return n
.
proc mkperms n &perms[][] &signs[] .
   total = fac n
   for i to n : p[] &= i
   len signs[] total
   len perms[][] total
   idx = 1
   repeat
      perms[idx][] = p[]
      signs[idx] = -1
      if cnt mod 2 = 0 : signs[idx] = 1
      idx += 1
      i = n - 1
      while i > 0 and p[i] >= p[i + 1] : i -= 1
      until i = 0
      j = n
      while p[j] <= p[i] : j -= 1
      swap p[i] p[j]
      cnt += 1
      k = i + 1
      l = n
      while k < l
         swap p[k] p[l]
         cnt += 1
         k += 1
         l -= 1
      .
   .
.
#
func faffian a[][] pfaf &valid .
   valid = 1
   m = len a[][]
   if m mod 2 <> 0
      valid = 0
      print "matrix size must be even "
   .
   if isAntisymmetric a[][] = 0
      print "matrix is not antissymmetric"
      valid = 0
      return 0
   .
   n = m / 2
   normal = 1 / ((pow 2 n) * fac n)
   mkperms m perms[][] signs[]
   for p = 1 to len perms[][]
      sgn = signs[p]
      if pfaf = 0 : sgn = 1
      prod = 1
      for i = 1 to n
         prod *= a[perms[p][2 * i - 1]][perms[p][2 * i]]
         suma += sgn * prod
      .
   .
   return suma * normal
.
m1[][] = [ [ 0 1 ], [ -1 0 ] ]
m2[][] = [ [ 0 1 -1 2 ] [ -1 0 3 -4 ] [ 1 -3 0 5 ] [ -2 4 -5 0 ] ]
print m1[][]
h = faffian m1[][] 1 val
if val = 1 : print "Pfaffian: " & h
h = faffian m1[][] 0 val
if val = 1 : print "Hfaffian: " & h
print ""
print m2[][]
h = faffian m2[][] 1 val
if val = 1 : print "Pfaffian: " & h
h = faffian m2[][] 0 val
if val = 1 : print "Hfaffian: " & h
