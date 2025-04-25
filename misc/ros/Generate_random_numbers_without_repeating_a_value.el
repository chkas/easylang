proc shuffle &a[] .
   for i = len a[] downto 2
      r = random i
      swap a[r] a[i]
   .
.
for i to 20 : arr[] &= i
shuffle arr[]
print arr[]
