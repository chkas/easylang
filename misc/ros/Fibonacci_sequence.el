func fib n .
   if n < 2 : return n
   val = 1
   for i = 2 to n
      h = prev + val
      prev = val
      val = h
   .
   return val
.
print fib 36
