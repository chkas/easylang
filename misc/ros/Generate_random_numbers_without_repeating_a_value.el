proc shuffle . a[] .
   for i = len a[] downto 2
      r = randint i
      swap a[r] a[i]
   .
.
for i to 20
   arr[] &= i
.
shuffle arr[]
print arr[]
