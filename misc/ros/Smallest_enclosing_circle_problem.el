func sqr a .
   return a * a
.
func dist a[] b[] .
   return sqrt (sqr (a[1] - b[1]) + sqr (a[2] - b[2]))
.
func[] circ_center bx by cx cy .
   b = bx * bx + by * by
   c = cx * cx + cy * cy
   d = bx * cy - by * cx
   return [ (cy * b - by * c) / (2 * d) (bx * c - cx * b) / (2 * d) ]
.
func contains ci[] p[] .
   return if dist ci[] p[] <= ci[3]
.
func encloses ci[] ps[][] .
   for i to len ps[][]
      if contains ci[] ps[i][] = 0
         return 0
      .
   .
   return 1
.
func[] circle_from3 a[] b[] c[] .
   h[] = circ_center (b[1] - a[1]) (b[2] - a[2]) (c[1] - a[1]) (c[2] - a[2])
   h[1] += a[1]
   h[2] += a[2]
   h[] &= dist h[] a[]
   return h[]
.
func[] circle_from2 a[] b[] .
   c[] &= (a[1] + b[1]) / 2
   c[] &= (a[2] + b[2]) / 2
   c[] &= dist a[] b[] / 2
   return c[]
.
func[] trivial rs[][] .
   if len rs[][] = 0
      return [ 0 0 0 ]
   elif len rs[][] = 1
      return [ rs[1][1] rs[1][2] 0 ]
   elif len rs[][] = 2
      return circle_from2 rs[1][] rs[2][]
   .
   for i to 2
      for j = i + 1 to 3
         c[] = circle_from2 rs[i][] rs[j][]
         if encloses c[] rs[][] = 1
            return c[]
         .
      .
   .
   return circle_from3 rs[1][] rs[2][] rs[3][]
.
func[] welzl ps[][] rs[][] .
   n = len ps[][]
   if n = 0 or len rs[][] = 3
      return trivial rs[][]
   .
   swap ps[n][] ps[random n][]
   p[] = ps[n][]
   len ps[][] -1
   d[] = welzl ps[][] rs[][]
   if contains d[] p[] = 1
      return d[]
   .
   rs[][] &= p[]
   return welzl ps[][] rs[][]
.
print welzl [ [ 5 -2 ] [ -3 -2 ] [ -2 5 ] [ 1 6 ] [ 0 2 ] ] [ ]
# 
proc circ x y r . .
   linewidth 0.2
   text ""
   for a = 0 to 360
      line x + sin a * r y + cos a * r
   .
.
for i to 10
   x = randomf * 80 + 10
   y = randomf * 80 + 10
   move x y
   ps[][] &= [ x y ]
   circle 0.6
.
circ[] = welzl ps[][] [ ]
circ circ[1] circ[2] circ[3]
