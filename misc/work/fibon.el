func fib n .
   if n < 2
      return n
   .
   return fib (n - 2) + fib (n - 1)
.
time0 = systime
print "Calculating ..."
print fib 35 & " - " & systime - time0

