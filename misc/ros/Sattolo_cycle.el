proc sattolo_cycle &a[] .
   for i = len a[] downto 2
      r = random (i - 1)
      swap a[r] a[i]
   .
.
arr[] = [ 1 2 3 ]
sattolo_cycle arr[]
print arr[]
