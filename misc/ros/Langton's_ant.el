len f[] 100 * 100
proc show .
   for y = 0 to 99 : for x = 0 to 99
      if f[y * 100 + x + 1] = 1
         grect x y 1 1
      .
   .
.
proc run x y dir .
   dx[] = [ 0 1 0 -1 ]
   dy[] = [ -1 0 1 0 ]
   while x >= 0 and x < 100 and y >= 0 and y < 100
      v = f[y * 100 + x + 1]
      f[y * 100 + x + 1] = 1 - v
      dir = (dir + 2 * v) mod 4 + 1
      x += dx[dir]
      y += dy[dir]
   .
.
run 70 40 0
show
