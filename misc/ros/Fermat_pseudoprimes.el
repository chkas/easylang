func modpow b e m .
   if m = 1 : return 0
   r = 1
   b = b mod m
   while e > 0
      if bitand e 1 = 1 : r = (r * b) mod m
      b = b * b mod m
      e = bitshift e -1
   .
   return r
.
fastfunc isprim num .
   if num mod 2 = 0 and num > 2 : return 0
   i = 3
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 2
   .
   return 1
.
func ferm_psdo_prim a x .
   return if isprim x = 0 and modpow a (x - 1) x = 1
.
print "First 20 Fermat pseudoprimes and count to 12000:"
for a = 1 to 20
   write "Base " & a & ": "
   cnt = 0
   x = 4
   while x <= 12000
      if ferm_psdo_prim a x = 1
         if cnt < 20 : write x & " "
         cnt += 1
      .
      x += 1
   .
   write "- " & cnt
   print ""
.
