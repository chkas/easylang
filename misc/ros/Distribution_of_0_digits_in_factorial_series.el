global bn[] .
fastproc bnmul b .
   for i to len bn[]
      h = c + bn[i] * b
      bn[i] = h mod 10000000
      c = h div 10000000
   .
   if c > 0 : bn[] &= c
.
fastfunc nzeros .
   for k to len bn[]
      d = bn[k]
      for i to 7
         if d mod 10 = 0 : cnt += 1
         d = d div 10
      .
   .
   cnt -= 7 - (floor log bn[$] 10 + 1)
   return cnt
.
func bnlen .
   if bn[] = [ 0 ] : return 1
   return (len bn[] - 1) * 7 + floor log bn[$] 10 + 1
.
bn[] = [ 1 ]
numfmt 0 9
lim = 100
for n to 10000
   bnmul n
   sum += nzeros / bnlen
   if n = lim
      print sum / n
      lim *= 10
   .
.
