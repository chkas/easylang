proc qsort left right . d[] .
   while left < right
      # partition 
      piv = d[left]
      mid = left
      for i = left + 1 to right
         if d[i] < piv
            mid += 1
            swap d[i] d[mid]
         .
      .
      swap d[left] d[mid]
      # 
      if mid < (right + left) / 2
         qsort left mid - 1 d[]
         left = mid + 1
      else
         qsort mid + 1 right d[]
         right = mid - 1
      .
   .
.
proc sort . d[] .
   qsort 1 len d[] d[]
.
d[] = [ 29 4 72 44 55 26 27 77 92 5 ]
sort d[]
print d[]
