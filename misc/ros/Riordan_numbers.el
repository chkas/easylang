cnt = 32
print "First " & cnt & " Riordan numbers:"
app = 1 ; ap = 0
print app ; print ap
for n = 2 to cnt - 1
   a = (n - 1) * (2 * ap + 3 * app) / (n + 1)
   print a
   app = ap
   ap = a
.
