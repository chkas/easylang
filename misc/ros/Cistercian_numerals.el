proc cist x y n .
   linewidth 0.5
   dx[] = [ 4 -4 4 -4 ]
   dy[] = [ 4 4 -4 -4 ]
   for i to 4
      dx = dx[i]
      dy = dy[i]
      dy2 = 2 * dy
      d = n mod 10
      n = n div 10
      move x y
      # 
      line x y + 8
      move x y - 8
      line x y
      if d = 1
         move x y + dy2
         line x + dx y + dy2
      elif d = 2
         move x y + dy
         line x + dx y + dy
      elif d = 3
         move x y + dy2
         line x + dx y + dy
      elif d = 4
         move x y + dy
         line x + dx y + dy2
      elif d = 5
         move x y + dy
         line x + dx y + dy2
         line x y + dy2
      elif d = 6
         move x + dx y + dy
         line x + dx y + dy2
      elif d = 7
         move x y + dy2
         line x + dx y + dy2
         line x + dx y + dy
      elif d = 8
         move x y + dy
         line x + dx y + dy
         line x + dx y + dy2
      elif d = 9
         move x y + dy
         line x + dx y + dy
         line x + dx y + dy2
         line x y + dy2
      .
   .
   x += 12
.
x = 8
for n in [ 0 1 20 300 4000 5555 6789 2023 ]
   cist x 80 n
   x += 12
.
