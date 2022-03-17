func fib n . res .
  if n < 2
    res = n
  .
  prev = 0
  val = 1
  for _ range n - 1
    res = prev + val
    prev = val
    val = res
  .
.
call fib 36 r
print r

