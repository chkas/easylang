ax = 10
ay = 20
bx = 90
by = 30
cx = 50
cy = 80
# 
func sgn px py ax ay bx by .
   return sign ((px - bx) * (ay - by) - (ax - bx) * (py - by))
.
func isin px py ax ay bx by cx cy .
   z1 = sgn px py ax ay bx by
   z2 = sgn px py bx by cx cy
   z3 = sgn px py cx cy ax ay
   return if abs (z1 + z2 + z3) = 3
.
proc drawpoly in .
   if in = 1
      gcolor 822
   else
      gcolor 444
   .
   gpolygon [ ax ay bx by cx cy ]
.
gtextsize 4
gtext 5 90 "Move mouse into the triangle"
drawpoly 0
# 
on mouse_move
   if isin mouse_x mouse_y ax ay bx by cx cy <> in
      in = 1 - in
      drawpoly in
   .
.
