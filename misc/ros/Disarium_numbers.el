fastfunc disarium n .
   n0 = n
   ndig = floor log n 10 + 1
   for i = ndig downto 1
      h += pow (n mod 10) i
      n = n div 10
   .
   if h = n0 : return 1
.
fastfunc nextdisarium n .
   repeat
      n += 1
      until disarium n = 1
   .
   return n
.
for i to 18
   n = nextdisarium n
   write n & " "
.
print ""
