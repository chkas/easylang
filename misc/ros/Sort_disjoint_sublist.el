val[] = [ 7 6 5 4 3 2 1 0 ]
ind[] = [ 7 2 8 ]
#
for i = 1 to len ind[] - 1
   for j = i + 1 to len ind[]
      if ind[j] < ind[i]
         swap ind[j] ind[i]
      .
   .
. 
for i = 1 to len ind[] - 1
   for j = i + 1 to len ind[]
      if val[ind[j]] < val[ind[i]]
         swap val[ind[j]] val[ind[i]]
      .
   .
.
print val[]
