func entropy s$ .
   l = len s$
   if l <= 1 : return 0
   for v$ in strchars s$
      cnt0 += if v$ = "0"
   .
   cnt1 = l - cnt0
   return -(cnt0 / l * log (cnt0 / l) 2 + cnt1 / l * log (cnt1 / l) 2)
.
a$ = ""
b$ = ""
func$ fibword .
   if a$ = ""
      a$ = "1"
      return a$
   .
   if b$ = ""
      b$ = "0"
      return b$
   .
   a$ = b$ & a$
   swap a$ b$
   return b$
.
numfmt 8 6
print "      n   length  entropy"
print "    ——————————————————————"
for n to 37
   s$ = fibword
   print n & " " & len s$ & " " & entropy s$
.
