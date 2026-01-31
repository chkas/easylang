fastfunc jpnum m .
   limite = 7
   repeat
      n = m
      fac = 1
      for i = 2 to limite : fac *= i
      i = limite
      repeat
         q = n div fac
         if n mod fac = 0
            if q = 1 : return 1
            n = q
         else
            fac = fac / i
            i -= 1
         .
         until i = 1
      .
      limite -= 1
      until limite = 0
   .
   return 0
.
write 1 & " "
fastfunc next n .
   repeat
      n += 2
      until jpnum n = 1
   .
   return n
.
for c = 2 to 50
   n = next n
   write n & " "
.
repeat
   sn = n
   n = next n
   until n >= 1e8
.
print ""
print "The largest Jordan-Polya number before 100 million: " & sn
