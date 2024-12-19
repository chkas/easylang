spRadius = 10
angle = 90
background 000
# define the spinners, each element is x, y, color
spData[][] = [ [ 50 50 955 ] [ 25 50 369 ] [ 75 50 309 ] [ 50 25 390 ] [ 50 75 930 ] ]
spCount = len spData[][]
# 
on timer
   clear
   for sp = 1 to spCount
      x = spData[sp][1]
      y = spData[sp][2]
      color spData[sp][3]
      move x y
      line x + spRadius * cos angle y + spRadius * sin angle
      angle -= 1
      if angle < 0
         angle += 360
      .
   .
   timer 0.001
.
timer 0
