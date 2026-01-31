fastfunc rev h .
   while h > 0
      nrev = nrev * 10 + h mod 10
      h = h div 10
   .
   return nrev
.
fastfunc next n .
   while 1 = 1
      n += 1
      nrev = rev n
      if sqrt (n + nrev) mod 1 = 0
         if n - nrev >= 1 and sqrt (n - nrev) mod 1 = 0
            return n
         .
      .
   .
.
for cnt to 5
   n = next n
   print n
.
