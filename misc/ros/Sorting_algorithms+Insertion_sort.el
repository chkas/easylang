proc sort &d[] .
   for i = 2 to len d[]
      h = d[i]
      j = i - 1
      while j >= 1 and h < d[j]
         d[j + 1] = d[j]
         j -= 1
      .
      d[j + 1] = h
   .
.
data[] = [ 29 4 72 44 55 26 27 77 92 5 ]
sort data[]
print data[]
