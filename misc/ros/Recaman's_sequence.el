arrbase a[] 0
arrbase seen[] 0
len seen[] 100
# 
a[] &= 0
seen[0] = 1
i = 1
repeat
   h = a[i - 1] - i
   if h <= 0 or seen[h] = 1
      h = a[i - 1] + i
   .
   until seen[h] = 1
   seen[h] = 1
   a[] &= h
   if i = 14
      print a[]
   .
   i += 1
.
print h
