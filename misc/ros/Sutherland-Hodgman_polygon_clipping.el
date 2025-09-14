func inside p[] cp1[] cp2[] .
   return if (cp2[1] - cp1[1]) * (p[2] - cp1[2]) > (cp2[2] - cp1[2]) * (p[1] - cp1[1])
.
func[] intersect cp1[] cp2[] s[] e[] .
   dcx = cp1[1] - cp2[1]
   dcy = cp1[2] - cp2[2]
   dpx = s[1] - e[1]
   dpy = s[2] - e[2]
   n1 = cp1[1] * cp2[2] - cp1[2] * cp2[1]
   n2 = s[1] * e[2] - s[2] * e[1]
   n3 = 1 / (dcx * dpy - dcy * dpx)
   x = (n1 * dpx - n2 * dcx) * n3
   y = (n1 * dpy - n2 * dcy) * n3
   return [ x y ]
.
func[][] clip subject[][] clip[][] .
   swap out[][] subject[][]
   cp1[] = clip[$][]
   for cp2[] in clip[][]
      swap inp[][] out[][]
      out[][] = [ ]
      s[] = inp[$][]
      for e[] in inp[][]
         if inside e[] cp1[] cp2[] = 1
            if inside s[] cp1[] cp2[] = 0
               out[][] &= intersect cp1[] cp2[] s[] e[]
            .
            out[][] &= e[]
         elif inside s[] cp1[] cp2[] = 1
            out[][] &= intersect cp1[] cp2[] s[] e[]
         .
         s[] = e[]
      .
      cp1[] = cp2[]
   .
   return out[][]
.
proc fill col polyg[][] .
   gcolor col
   for p[] in polyg[][]
      h[] &= p[1] / 4
      h[] &= p[2] / 4
   .
   gpolygon h[]
.
subject[][] = [ [ 50 150 ] [ 200 50 ] [ 350 150 ] [ 350 300 ] [ 250 300 ] [ 200 250 ] [ 150 350 ] [ 100 250 ] [ 100 200 ] ]
clip[][] = [ [ 100 100 ] [ 300 100 ] [ 300 300 ] [ 100 300 ] ]
out[][] = clip subject[][] clip[][]
for p[] in out[][] : print p[]
# 
gbackground 000
gclear
fill 944 subject[][]
fill 494 clip[][]
fill 994 out[][]
