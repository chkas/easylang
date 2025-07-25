node[][] = [ [ -1 -1 -1 ] [ -1 -1 1 ] [ -1 1 -1 ] [ -1 1 1 ] [ 1 -1 -1 ] [ 1 -1 1 ] [ 1 1 -1 ] [ 1 1 1 ] ]
edge[][] = [ [ 1 2 ] [ 2 4 ] [ 4 3 ] [ 3 1 ] [ 5 6 ] [ 6 8 ] [ 8 7 ] [ 7 5 ] [ 1 5 ] [ 2 6 ] [ 3 7 ] [ 4 8 ] ]
# 
proc scale f .
   for i = 1 to len node[][] : for d = 1 to 3
      node[i][d] *= f
   .
.
proc rotate angx angy .
   sinx = sin angx
   cosx = cos angx
   siny = sin angy
   cosy = cos angy
   for i = 1 to len node[][]
      x = node[i][1]
      z = node[i][3]
      node[i][1] = x * cosx - z * sinx
      y = node[i][2]
      z = z * cosx + x * sinx
      node[i][2] = y * cosy - z * siny
      node[i][3] = z * cosy + y * siny
   .
.
len nd[] 3
proc draw .
   gclear
   m = 999
   mi = -1
   for i = 1 to len node[][]
      if node[i][3] < m
         m = node[i][3]
         mi = i
      .
   .
   ix = 1
   for i = 1 to len edge[][]
      if edge[i][1] = mi
         nd[ix] = edge[i][2]
         ix += 1
      elif edge[i][2] = mi
         nd[ix] = edge[i][1]
         ix += 1
      .
   .
   for ni = 1 to len nd[] : for i = 1 to len edge[][]
      if edge[i][1] = nd[ni] or edge[i][2] = nd[ni]
         x1 = node[edge[i][1]][1]
         y1 = node[edge[i][1]][2]
         x2 = node[edge[i][2]][1]
         y2 = node[edge[i][2]][2]
         gline x1 + 50 y1 + 50 x2 + 50 y2 + 50
      .
   .
.
scale 25
rotate 45 atan sqrt 2
draw
on animate
   rotate 1 0
   draw
.
