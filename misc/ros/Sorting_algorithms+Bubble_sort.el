proc bubbleSort . a[] .
   repeat
      changed = 0
      for i = 1 to len a[] - 1
         if a[i] > a[i + 1]
            swap a[i] a[i + 1]
            changed = 1
         .
      .
      until changed = 0
   .
.
array[] = [ 5 1 19 25 12 1 14 7 ]
bubbleSort array[]
print array[]
