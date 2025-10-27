func hpo2 n .
   return bitand n -n
.
func lhpo2 n .
   m = hpo2 n
   while m mod 2 = 0
      m = bitshift m -1
      q += 1
   .
   return q
.
func nimsum x y .
   return bitxor x y
.
func nimprod x y .
   if x < 2 or y < 2 : return x * y
   h = hpo2 x
   if x > h
      a = nimprod h y
      b = nimprod bitxor x h y
      return bitxor a b
   .
   if hpo2 y < y : return nimprod y x
   xp = lhpo2 x
   yp = lhpo2 y
   comp = bitand xp yp
   if comp = 0 : return x * y
   h = hpo2 comp
   a = nimprod bitshift x -h bitshift y -h
   b = bitshift 3 (h - 1)
   return nimprod a b
.
numfmt 3 0
write " + | "
for a = 0 to 15 : write a
print ""
print "--- -------------------------------------------------"
for b = 0 to 15
   write b & " |"
   for a = 0 to 15 : write nimsum a b
   print ""
.
print ""
write " * | "
for a = 0 to 15 : write a
print ""
print "--- -------------------------------------------------"
for b = 0 to 15
   write b & " |"
   for a = 0 to 15 : write nimprod a b
   print ""
.
print ""
a = 21508
b = 42689
print a & " + " & b & " = " & nimsum a b
print a & " * " & b & " = " & nimprod a b
