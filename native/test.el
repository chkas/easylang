func fib n .
  if n < 2 : return n
  return fib (n - 1) + fib (n - 2)
.
time0 = systime
print "Calculating ..."
print fib 33 & " - " & systime - time0

