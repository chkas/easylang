func$ invert cadena$ .
   for i = 1 to len cadena$
      b$ = substr cadena$ i 1
      if b$ = "0"
         inverted$ = inverted$ & "1"
      elif b$ = "1"
         inverted$ = inverted$ & "0"
      .
   .
   return inverted$
.
func$ sturmian_word m n .
   sturmian$ = ""
   if m > n : return invert sturmian_word n m
   k = 1
   repeat
      current = floor (k * m / n)
      previous = floor ((k - 1) * m / n)
      until k * m mod n = 0
      if previous = current
         sturmian$ = sturmian$ & "0"
      else
         sturmian$ = sturmian$ & "10"
      .
      k += 1
   .
   return sturmian$
.
func$ fibword n .
   sn_1$ = "0"
   sn$ = "01"
   for i = 2 to n
      tmp$ = sn$
      sn$ = sn$ & sn_1$
      sn_1$ = tmp$
   .
   return sn$
.
fib$ = fibword 10
sturmian$ = sturmian_word 13 21
if substr fib$ 1 len sturmian$ = sturmian$ : print sturmian$
