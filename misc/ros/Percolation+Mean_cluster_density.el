global m[] nn n nclust .
proc mkgrid p n0 .
   n = n0
   nn = n * n
   m[] = [ ]
   for i to nn : if randomf < p
      m[] &= -1
   else
      m[] &= 0
   .
.
proc show .
   gbackground 000
   gclear
   sc = 100 / n
   for clust to nclust
      c = random 8 + 1
      c += (random 8 + 1) * 10
      c += (random 8 + 1) * 100
      gcolor c
      for i to nn
         x = (i - 1) mod n
         y = (i - 1) div n
         if m[i] = clust
            grect x * sc, y * sc, sc * 0.97, sc * 0.97
         .
      .
   .
.
proc flood i .
   m[i] = nclust
   if i > n and m[i - n] = -1 : flood (i - n)
   if i mod n <> 0 and m[i + 1] = -1 : flood (i + 1)
   if i <= nn - n and m[i + n] = -1 : flood (i + n)
   if i mod n <> 1 and m[i - 1] = -1 : flood (i - 1)
.
proc mkcluster .
   nclust = 0
   for i to nn : if m[i] = -1
      nclust += 1
      flood i
   .
.
mkgrid 0.5 100
mkcluster
show
numfmt 0 4
for n in [ 10 100 1000 ]
   sum = 0
   for i to 5
      mkgrid 0.5 n
      mkcluster
      sum += nclust / nn
   .
   print n & ": " & sum / 5
.
