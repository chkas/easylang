func dot a[] b[] .
   return a[1] * b[1] + a[2] * b[2]
.
proc addAxes &poly[][] &r[][] .
   for i to len poly[][]
      v1[] = poly[i][]
      j = (i + 1) mod1 len poly[][]
      v2[] = poly[j][]
      r[][] &= [ -(v1[2] - v2[2]) v1[1] - v2[1] ]
   .
.
proc projectAxis &poly[][] &axis[] &min &max .
   min = 1 / 0
   max = -1 / 0
   for i to len poly[][]
      p = dot axis[] poly[i][]
      min = lower min p
      max = higher max p
   .
.
func polyOverlap &poly1[][] &poly2[][] .
   axes[][] = [ ]
   addAxes poly1[][] axes[][]
   addAxes poly2[][] axes[][]
   for i to len axes[][]
      axis[] = axes[i][]
      projectAxis poly1[][] axis[] min1 max1
      projectAxis poly2[][] axis[] min2 max2
      if max1 < min2 or max2 < min1 : return 0
   .
   return 1
.
coord_translate 5 5
coord_scale 10
proc polyDraw &poly[][] col .
   gcolor col
   glinewidth 0.05
   gpenup
   for i = 1 to len poly[][]
      glineto poly[i][1] poly[i][2]
   .
   glineto poly[1][1] poly[1][2]
.
proc rectToPoly &r[] &p[][] .
   p[][] = [ [ r[1] r[2] ] [ r[1] + r[3] r[2] ] [ r[1] + r[3] r[2] + r[4] ] [ r[1] r[2] + r[4] ] ]
.
poly1[][] = [ [ 0 0 ] [ 0 2 ] [ 1 4 ] [ 2 2 ] [ 2 0 ] ]
rect1[] = [ 4 0 2 2 ]
rect2[] = [ 1 0 8 2 ]
rectToPoly rect1[] poly2[][]
rectToPoly rect2[] poly3[][]
# 
polyDraw poly1[][] 900
polyDraw poly2[][] 090
polyDraw poly3[][] 009
# 
print polyOverlap poly1[][] poly2[][]
print polyOverlap poly1[][] poly3[][]
