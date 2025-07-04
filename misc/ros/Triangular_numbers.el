print "Triangular:"
t[] = [ 0 ]
for n = 2 to 30 : t[] &= t[n - 1] + n - 1
print t[]
print ""
print "Tetrahedral:"
for n = 2 to 30 : t[n] += t[n - 1]
print t[]
print ""
print "Pentatopic:"
for n = 2 to 30 : t[n] += t[n - 1]
print t[]
print ""
print "12-Simplex:"
for r = 5 to 12
   for n = 2 to 30 : t[n] += t[n - 1]
.
print t[]
print ""
for x in [ 7140, 21408696, 26728085384, 14545501785001 ]
   print "Roots of " & x
   root = (sqrt (x * 8 + 1) - 1) / 2
   write root & " "
   temp = sqrt (x * x * 9 - 1 / 27)
   root = pow (x * 3 + temp) (1 / 3) + pow (x * 3 - temp) (1 / 3) - 1
   write root & " "
   root = (sqrt (sqrt (x * 24 + 1) * 4 + 5) - 3) / 2
   print root
   print ""
.
