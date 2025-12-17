# AoC-25 - Day 8: Playground
#
repeat
   s$ = input
   until s$ = ""
   p[][] &= number strsplit s$ ","
.
n = len p[][]
global dists[][] .
#
proc qsort left right &d[][] .
   if left < right
      piv = d[left][1]
      mid = left
      for i = left + 1 to right
         if d[i][1] < piv
            mid += 1
            swap d[i][] d[mid][]
         .
      .
      swap d[left][] d[mid][]
      qsort left mid - 1 d[][]
      qsort mid + 1 right d[][]
   .
.
func dist a[] b[] .
   for i to 3 : d += (a[i] - b[i]) * (a[i] - b[i])
   return d
.
proc makedist .
   for i to n - 1 : for j = i + 1 to n
      h = dist p[i][] p[j][]
      dists[][] &= [ h i j ]
   .
   qsort 1 len dists[][] dists[][]
.
makedist
#
len con[][] n
proc makecon k .
   con[dists[k][2]][] &= dists[k][3]
   con[dists[k][3]][] &= dists[k][2]
.
#
global incluster[] clustcnt k .
#
proc add2cluster p .
   incluster[p] = 1
   clustcnt += 1
   for c in con[p][]
      if incluster[c] = 0 : add2cluster c
   .
.
proc dopart1 .
   rounds = 1000
   if n = 20 : rounds = 10
   for k to rounds : makecon k
   incluster[] = [ ]
   len incluster[] n
   for p to n
      if incluster[p] = 0
         clustcnt = 0
         add2cluster p
         clustcnt[] &= clustcnt
      .
   .
   for i to 3 : for j = i to len clustcnt[]
      if clustcnt[j] > clustcnt[i] : swap clustcnt[j] clustcnt[i]
   .
   print clustcnt[1] * clustcnt[2] * clustcnt[3]
.
dopart1
#
proc dopart2 .
   incluster[] = [ ]
   len incluster[] n
   clustcnt = 0
   add2cluster 1
   repeat
      makecon k
      a = dists[k][2]
      b = dists[k][3]
      if incluster[a] + incluster[b] = 1
         if incluster[a] = 1 : swap a b
         add2cluster a
      .
      until clustcnt = n
      k += 1
   .
   print p[dists[k][2]][1] * p[dists[k][3]][1]
.
dopart2
#
input_data
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
