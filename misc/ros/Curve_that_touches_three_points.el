func lagrange p[][] x .
   r = (x - p[2][1]) * (x - p[3][1]) / (p[1][1] - p[2][1]) / (p[1][1] - p[3][1]) * p[1][2]
   r += (x - p[1][1]) * (x - p[3][1]) / (p[2][1] - p[1][1]) / (p[2][1] - p[3][1]) * p[2][2]
   r += (x - p[1][1]) * (x - p[2][1]) / (p[3][1] - p[1][1]) / (p[3][1] - p[2][1]) * p[3][2]
   return r
.
proc quadratic n p[][] .
   for i to 3 : gcircle p[i][1] p[i][2] 1
   gpenup
   glineto p[1][1] p[1][2]
   for k to 2
      dx = (p[k + 1][1] - p[k][1]) / n
      for i to n
         x = p[k][1] + dx * i
         glineto x lagrange p[][] x
      .
   .
.
quadratic 20 [ [ 5 5 ] [ 50 70 ] [ 95 50 ] ]
