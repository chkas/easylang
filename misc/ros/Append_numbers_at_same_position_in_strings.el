list1[] = [ 1 2 3 4 5 6 7 8 9 ]
list2[] = [ 10 11 12 13 14 15 16 17 18 ]
list3[] = [ 19 20 21 22 23 24 25 26 27 ]
# 
for i to len list1[]
   s$ = list1[i] & list2[i] & list3[i]
   r[] &= number s$
.
print r[]
