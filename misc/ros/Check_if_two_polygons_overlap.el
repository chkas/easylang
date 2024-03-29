func dot a[] b[] .
   return a[1] * b[1] + a[2] * b[2]
.
proc addAxes . poly[][] r[][] .
   for i to len poly[][]
      v1[] = poly[i][]
      j = (i + 1) mod1 len poly[][]
      v2[] = poly[j][]
      r[][] &= [ -(v1[2] - v2[2]) v1[1] - v2[1] ]
   .
.
proc projectAxis . poly[][] axis[] min max .
   min = 1 / 0
   max = -1 / 0
   for i to len poly[][]
      p = dot axis[] poly[i][]
      min = lower min p
      max = higher max p
   .
.
proc polyOverlap . poly1[][] poly2[][] r .
   axes[][] = [ ]
   addAxes poly1[][] axes[][]
   addAxes poly2[][] axes[][]
   for i to len axes[][]
      axis[] = axes[i][]
      projectAxis poly1[][] axis[] min1 max1
      projectAxis poly2[][] axis[] min2 max2
      if max1 < min2 or max2 < min1
         r = 0
         return
      .
   .
   r = 1
.
proc polyDraw col . poly[][] .
   color col
   linewidth 0.5
   for i to len poly[][]
      line poly[i][1] * 9 + 5 poly[i][2] * 9 + 5
   .
   line poly[1][1] * 9 + 5 poly[1][2] * 9 + 5
.
poly1[][] = [ [ 0 0 ] [ 0 2 ] [ 1 4 ] [ 2 2 ] [ 2 0 ] ]
poly2[][] = [ [ 4 0 ] [ 4 2 ] [ 5 4 ] [ 6 2 ] [ 6 0 ] ]
poly3[][] = [ [ 1 0 ] [ 1 2 ] [ 5 4 ] [ 9 2 ] [ 9 0 ] ]
# 
polyDraw 900 poly1[][]
polyDraw 090 poly2[][]
polyDraw 009 poly3[][]
# 
polyOverlap poly1[][] poly2[][] r ; print r
polyOverlap poly1[][] poly3[][] r ; print r
polyOverlap poly2[][] poly3[][] r ; print r
