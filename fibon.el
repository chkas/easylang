func fib n . res .
  if n < 2
    res = n
  else
    call fib n - 1 a 
    call fib n - 2 b 
    res = a + b
  .
.
time0 = systime
print "Calculating ..."
call fib 34 r
print r & " - " & systime - time0

