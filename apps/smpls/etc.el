func mysqrt a . b .
   b = 1
   repeat
      ar = a * b
      a = (a + b) / 2
      b = ar / a
      until a - b < 1e-20
   .
.
numfmt 0 20
call mysqrt 2 r
print r



