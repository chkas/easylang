rad = 10
gbackground 000
# define the spinners, each element is x, y, color
sp[][] = [ [ 50 50 955 ] [ 25 50 369 ] [ 75 50 309 ] [ 50 25 390 ] [ 50 75 930 ] ]
# 
on animate
   gclear
   for i = 1 to len sp[][]
      gcolor sp[i][3]
      x = sp[i][1]
      y = sp[i][2]
      gline x y (x + rad * cos ang) (y + rad * sin ang)
      ang -= 1
      if ang < 0 : ang += 360
   .
.
