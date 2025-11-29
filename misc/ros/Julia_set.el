fastfunc getiter x y .
   cx = -0.7
   cy = 0.27015
   while iter < 127
      if x * x + y * y > 4 : return iter
      h = x * x - y * y + cx
      y = 2 * x * y + cy
      x = h
      iter += 1
   .
.
gbackground 0
for y = 10 step 0.3 to 90
   for x = 0 step 0.3 to 100
      gcolor3 0 0 0
      iter = getiter ((x - 50) / 33) ((y - 50) / 33)
      if iter < 128
         gcolor3 iter * 0.05 0 0
      .
      grect x y 0.4 0.4
   .
.
