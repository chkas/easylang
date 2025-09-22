sysconf topleft
global pts[][] n k0 .
proc drawpts .
   for pt[] in pts[][]
      gcircle pt[1] / 4 pt[2] / 4 0.5
   .
.
proc lineto x y .
   glineto x / 4 y / 4
.
proc init k pts0[][] .
   k0 = k
   swap pts0[][] pts[][]
   n = len pts[][]
.
func help i k x .
   return (x - i) / k
.
func calc i k x .
   if k = 1
      if i <= x and x < i + 1 : return 1
      return 0
   .
   h = help i (k - 1) x * calc i (k - 1) x
   return h + (1 - help (i + 1) (k - 1) x) * calc (i + 1) (k - 1) x
.
proc bspline .
   gpenup
   t = k0 - 1
   while t <= n
      x = 0
      y = 0
      for i to n
         f = calc (i - 1) k0 t
         x += f * pts[i][1]
         y += f * pts[i][2]
      .
      lineto x y
      t += 0.1
   .
.
init 4 [ [ 171 171 ] [ 185 111 ] [ 202 109 ] [ 202 189 ] [ 328 160 ] [ 208 254 ] [ 241 330 ] [ 164 252 ] [ 69 278 ] [ 139 208 ] [ 72 148 ] [ 168 172 ] ]
drawpts
bspline
