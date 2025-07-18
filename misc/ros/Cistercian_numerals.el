proc cist x y n .
   glinewidth 0.5
   dx[] = [ 4 -4 4 -4 ]
   dy[] = [ 4 4 -4 -4 ]
   for i to 4
      dx = dx[i]
      dy = dy[i]
      dy2 = 2 * dy
      d = n mod 10
      n = n div 10
      # 
      gline x y x y + 8
      gline x y - 8 x y
      if d = 1
         gline x y + dy2 x + dx y + dy2
      elif d = 2
         gline x y + dy x + dx y + dy
      elif d = 3
         gline x y + dy2 x + dx y + dy
      elif d = 4
         gline x y + dy x + dx y + dy2
      elif d = 5
         gline x y + dy x + dx y + dy2
         gline x + dx y + dy2 x y + dy2
      elif d = 6
         gline x + dx y + dy x + dx y + dy2
      elif d = 7
         gline x y + dy2 x + dx y + dy2
         gline x + dx y + dy2 x + dx y + dy
      elif d = 8
         gline x y + dy x + dx y + dy
         gline x + dx y + dy x + dx y + dy2
      elif d = 9
         gline x y + dy x + dx y + dy
         gline x + dx y + dy x + dx y + dy2
         gline x + dx y + dy2 x y + dy2
      .
   .
   x += 12
.
x = 8
for n in [ 0 1 20 300 4000 5555 6789 2023 ]
   cist x 80 n
   x += 12
.
