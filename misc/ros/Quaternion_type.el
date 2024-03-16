func qnorm q[] .
   for i to 4
      s += q[i] * q[i]
   .
   return sqrt s
.
func[] qneg q[] .
   for i to 4
      q[i] = -q[i]
   .
   return q[]
.
func[] qconj q[] .
   for i = 2 to 4
      q[i] = -q[i]
   .
   return q[]
.
func[] qaddreal q[] r .
   q[1] += r
   return q[]
.
func[] qadd q[] q2[] .
   for i to 4
      q[i] += q2[i]
   .
   return q[]
.
func[] qmulreal q[] r .
   for i to 4
      q[i] *= r
   .
   return q[]
.
func[] qmul q1[] q2[] .
   res[] &= q1[1] * q2[1] - q1[2] * q2[2] - q1[3] * q2[3] - q1[4] * q2[4]
   res[] &= q1[1] * q2[2] + q1[2] * q2[1] + q1[3] * q2[4] - q1[4] * q2[3]
   res[] &= q1[1] * q2[3] - q1[2] * q2[4] + q1[3] * q2[1] + q1[4] * q2[2]
   res[] &= q1[1] * q2[4] + q1[2] * q2[3] - q1[3] * q2[2] + q1[4] * q2[1]
   return res[]
.
q[] = [ 1 2 3 4 ]
q1[] = [ 2 3 4 5 ]
q2[] = [ 3 4 5 6 ]
r = 7
# 
print "q = " & q[]
print "q1 = " & q1[]
print "q2 = " & q2[]
print "r = " & r
print "norm(q) = " & qnorm q[]
print "neg(q) = " & qneg q[]
print "conjugate(q) = " & qconj q[]
print "q+r = " & qaddreal q[] r
print "q1+q2 = " & qadd q1[] q2[]
print "qr = " & qmulreal q[] r
print "q1q2 = " & qmul q1[] q2[]
print "q2q1 = " & qmul q2[] q1[]
if q1[] <> q2[]
   print "q1 != q2"
.
