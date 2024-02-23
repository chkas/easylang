proc vadd a[] b[] . r[] .
   r[] = [ ]
   for i to len a[]
      r[] &= a[i] + b[i]
   .
.
proc vsub a[] b[] . r[] .
   r[] = [ ]
   for i to len a[]
      r[] &= a[i] - b[i]
   .
.
proc vmul a[] b . r[] .
   r[] = [ ]
   for i to len a[]
      r[] &= a[i] * b
   .
.
proc vdiv a[] b . r[] .
   r[] = [ ]
   for i to len a[]
      r[] &= a[i] / b
   .
.
vadd [ 5 7 ] [ 2 3 ] r[]
print r[]
vsub [ 5 7 ] [ 2 3 ] r[]
print r[]
vmul [ 5 7 ] 11 r[]
print r[]
vdiv [ 5 7 ] 2 r[]
print r[]
