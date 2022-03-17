func fib n . res .
  if n < 2
    res = n
  else
    call fib n - 1 a 
    call fib n - 2 b 
    res = a + b
  .
.
t0 = systime
n = 36
print "Calculating recursive fibonacci of " & n
call fib n r
print "Result: " & r
print "Time: " &systime - t0

