proc sortuniq &d[] .
   i = 1
   while i < len d[]
      for j = i + 1 to len d[]
         if d[j] < d[i] : swap d[j] d[i]
      .
      if i > 1 and d[i] = d[i - 1]
         swap d[$] d[i]
         len d[] -1
      else
         i += 1
      .
   .
.
for a = 2 to 5 : for b = 2 to 5
   pows[] &= pow a b
.
sortuniq pows[]
print pows[]
