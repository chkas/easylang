# Known:
#         [ 151]
#        [a ][b ]
#      [40][c ][d ]
#    [e ][f ][g ][h ]
#  [ X][11][ Y][ 4][ Z]
#
#  Y = X + Z
#
func solveForZ x .
   for z = 0 to 20
      e = x + 11
      f = 11 + (x + z)
      g = (x + z) + 4
      h = 4 + z
      if e + f = 40
         c = f + g
         d = g + h
         a = 40 + c
         b = c + d
         if a + b = 151 : return z
      .
   .
   return -1
.
repeat
   z = solveForZ x
   until z >= 0
   x += 1
.
print "X = " & x
print "Y = " & x + z
print "Z = " & z
