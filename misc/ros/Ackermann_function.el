func ackerm m n .
   if m = 0 : return n + 1
   if n = 0 : return ackerm (m - 1) 1
   return ackerm (m - 1) ackerm m (n - 1)
.
print ackerm 3 6
