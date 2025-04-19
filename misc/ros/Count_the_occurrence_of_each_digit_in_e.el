n = 2000
len dcount[] 10
arrbase dcount[] 0
dcount[2] = 1
for i to n : v[] &= 1
for col = 0 to 2 * n
   a = n + 1
   c = 0
   for i to n
      c += v[i] * 10
      v[i] = c mod a
      c = c div a
      a -= 1
   .
   dcount[c] += 1
.
print dcount[]
