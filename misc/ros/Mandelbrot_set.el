# Mandelbrot
# 
res = 4
maxiter = 200
# better but slower: res = 8 maxiter = 300
# 
mid = res * 50
center_x = 3 * mid / 2
center_y = mid
scale = mid
# 
gbackground 000
gtextsize 2
# 
fastfunc iter cx cy max .
   while xx + yy < 4 and it < max
      y = 2 * x * y + cy
      x = xx - yy + cx
      xx = x * x
      yy = y * y
      it += 1
   .
   return it
.
proc draw .
   gclear
   for scr_y = 0 to 2 * mid - 1
      cy = (scr_y - center_y) / scale
      for scr_x = 0 to 2 * mid - 1
         cx = (scr_x - center_x) / scale
         it = iter cx cy maxiter
         if it < maxiter
            gcolor3 it * 5 it it * 0.7
            grect scr_x / res scr_y / res 1 / res 1 / res
         .
      .
   .
   gcolor 990
   gtext 1 1 "Short press to zoom in, long to zoom out"
.
on timer
   if done = 0
      center_x += (mid - center_x) * 3 / 4
      center_y += (mid - center_y) * 3 / 4
      scale /= 4
      draw
      done = 1
   .
.
on mouse_down
   done = 0
   center_x += mid - mouse_x * res
   center_y += mid - mouse_y * res
   timer 0.3
.
on mouse_up
   if done = 0
      center_x -= mid - center_x
      center_y -= mid - center_y
      scale *= 2
      draw
      done = 1
   .
.
draw
