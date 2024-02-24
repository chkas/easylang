func vdot a[] b[] .
   for i to len a[]
      r += a[i] * b[i]
   .
   return r
.
func[] vcross a[] b[] .
   r[] &= a[2] * b[3] - a[3] * b[2]
   r[] &= a[3] * b[1] - a[1] * b[3]
   r[] &= a[1] * b[2] - a[2] * b[1]
   return r[]
.
a[] = [ 3 4 5 ]
b[] = [ 4 3 5 ]
c[] = [ -5 -12 -13 ]
#
print vdot a[] b[]
print vcross a[] b[]
print vdot a[] vcross b[] c[]
print vcross a[] vcross b[] c[]