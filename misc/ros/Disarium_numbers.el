func disarium n .
   n0 = n
   ndig = floor log n 10 + 1
   for i = ndig downto 1
      h += pow (n mod 10) i
      n = n div 10
   .
   return if h = n0
.
while count < 19
   if disarium n = 1
      count += 1
      write n & " "
   .
   n += 1
.
print ""
