func mypow n exp .
   if exp < 0
      exp = -exp
      n = 1 / n
   .
   r = 1
   for i to exp : r *= n
   return r
.
print mypow pi 2
print mypow 2 -2
