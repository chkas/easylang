fastfunc rev h .
   while h > 0
      r = r * 10 + h mod 10
      h = h div 10
   .
   return r
.
fastfunc issqr n .
   h = sqrt n
   if h = floor h : return 1
   return 0
.
po = 1
lim = 1
a = 0
fastfunc next n .
   while 1 = 1
      n += 1
      if n = lim
         a += 2
         if a = 10
            a = 2
            po *= 10
         .
         n = a * po
         lim = n + po
      .
      q = n mod 10
      if a <> 2 or q = 2
         if a <> 4 or q = 0
            if a <> 6 or q = 0 or q = 5
               # 
               s9 = (n mod 9 * 2) mod 9
               if s9 <= 1 or s9 = 4 or s9 = 7
                  # 
                  if q <> 1 and q <> 4 and q <> 6 and q <> 9
                     h = a - q
                     if h <= 1 or h >= 4 and h <= 6
                        # 
                        nrev = rev n
                        if issqr (n + nrev) = 1
                           if n > nrev and issqr (n - nrev) = 1
                              return n
                           .
                        .
                     .
                  .
               .
            .
         .
      .
   .
.
for cnt to 5
   n = next n
   print n
.
