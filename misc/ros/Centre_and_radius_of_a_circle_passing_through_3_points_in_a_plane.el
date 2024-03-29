proc circ x1 y1 x2 y2 x3 y3 . cx cy cr .
   x12 = x1 - x2
   x13 = x1 - x3
   y12 = y1 - y2
   y13 = y1 - y3
   y31 = y3 - y1
   y21 = y2 - y1
   x31 = x3 - x1
   x21 = x2 - x1
   sx13 = x1 * x1 - x3 * x3
   sy13 = y1 * y1 - y3 * y3
   sx21 = x2 * x2 - x1 * x1
   sy21 = y2 * y2 - y1 * y1
   f = (sx13 * x12 + sy13 * x12 + sx21 * x13 + sy21 * x13) / (y31 * x12 - y21 * x13) / 2
   g = (sx13 * y12 + sy13 * y12 + sx21 * y13 + sy21 * y13) / (x31 * y12 - x21 * y13) / 2
   c = -x1 * x1 - y1 * y1 - 2 * g * x1 - 2 * f * y1
   cx = -g
   cy = -f
   cr = sqrt (cx * cx + cy * cy - c)
.
circ 22.83 2.07 14.39 30.24 33.65 17.31 cx cy cr
print "Centre: (" & cx & ", " & cy & ")  Radius: " & cr
