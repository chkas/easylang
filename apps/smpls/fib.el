proc fib n . res .
  if n < 2
    res = n
  .
  prev = 0
  val = 1
  for _ = 0 to n - 2
    res = prev + val
    prev = val
    val = res
  .
.
fib 36 r
print r

