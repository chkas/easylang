perms$[] = [ "ABCD" "CABD" "ACDB" "DACB" "BCDA" "ACBD" "ADCB" "CDAB" "DABC" "BCAD" "CADB" "CDBA" "CBAD" "ABDC" "ADBC" "BDCA" "DCBA" "BACD" "BADC" "BDAC" "CBDA" "DBCA" "DCAB" ]
n = len perms$[1]
len cnt[] n
# 
nn = 1
for i to n - 1
   nn *= i
.
for i to 4
   for j to n
      cnt[j] = 0
   .
   for s$ in perms$[]
      cod = strcode substr s$ i 1 - 64
      cnt[cod] += 1
   .
   for j to n
      if cnt[j] <> nn
         miss$ &= strchar (j + 64)
         break 1
      .
   .
.
print miss$
