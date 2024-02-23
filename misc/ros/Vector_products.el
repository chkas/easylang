func vdot a[] b[] .
   for i to len a[]
      r += a[i] * b[i]
   .
   return r
.
proc vcross a[] b[] . r[] .
   len r[] 3
   r[1] = a[2] * b[3] - a[3] * b[2]
   r[2] = a[3] * b[1] - a[1] * b[3]
   r[3] = a[1] * b[2] - a[2] * b[1]
.
a[] = [ 3 4 5 ]
b[] = [ 4 3 5 ]
c[] = [ -5 -12 -13 ]
# 
print vdot a[] b[]
#
vcross a[] b[] r[]
print r[]
# 
vcross b[] c[] r[]
print vdot a[] r[]
# 
vcross b[] c[] r[]
vcross a[] r[] r[]
print r[]
