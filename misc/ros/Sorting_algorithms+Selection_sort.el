proc sort &d[] .
   for i = 1 to len d[] - 1 : for j = i + 1 to len d[]
      if d[j] < d[i] : swap d[j] d[i]
   .
.
data[] = [ 29 4 72 44 55 26 27 77 92 5 ]
sort data[]
print data[]
