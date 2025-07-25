proc tree x1 y1 x2 y2 depth .
   if depth < 8
      dx = x2 - x1
      dy = y1 - y2
      x3 = x2 + dy
      y3 = y2 + dx
      x4 = x1 + dy
      y4 = y1 + dx
      x5 = x4 + 0.5 * (dx + dy)
      y5 = y4 + 0.5 * (dx - dy)
      gcolor3 30 20 + depth * 6 10
      gpolygon [ x1 y1 x2 y2 x3 y3 x4 y4 ]
      gpolygon [ x3 y3 x4 y4 x5 y5 ]
      tree x4 y4 x5 y5 depth + 1
      tree x5 y5 x3 y3 depth + 1
   .
.
tree 41 10 59 10 0
