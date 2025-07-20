func digsum n .
   while n > 0
      r += n mod 10
      n = n div 10
   .
   return r
.
func digprod n .
   r = 1
   while n > 0
      r *= n mod 10
      n = n div 10
   .
   return r
.
func digroot n .
   while n > 9 : n = digsum n
   return n
.
func mult n .
   m = 1
   while m > 0 and n > 0
      dm = n mod 10
      m *= dm
      n = n div 10
   .
   return m
.
func mult_digroot n .
   m = n
   while m >= 10 : m = mult m
   return m
.
func is_dividuus n .
   if n mod digsum n <> 0 : return 0
   if n mod digprod n <> 0 : return 0
   if n mod digroot n <> 0 : return 0
   mdr = mult_digroot n
   return if mdr <> 0 and n mod mdr = 0
.
while cnt < 50
   i += 1
   if is_dividuus i = 1
      cnt += 1
      write i & " "
   .
.
print ""
