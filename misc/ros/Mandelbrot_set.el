res = 4
maxiter = 200
# 
# better but slower:
# res = 8
# maxiter = 300
# 
#  
mid = res * 50
center_x = 3 * mid / 2
center_y = mid
scale = mid
# 
background 000
textsize 2
# 
fastfunc iter cx cy maxiter .
   while xx + yy < 4 and it < maxiter
      y = 2 * x * y + cy
      x = xx - yy + cx
      xx = x * x
      yy = y * y
      it += 1
   .
   return it
.
proc draw .
   clear
   for scr_y = 0 to 2 * mid - 1
      cy = (scr_y - center_y) / scale
      for scr_x = 0 to 2 * mid - 1
         cx = (scr_x - center_x) / scale
         it = iter cx cy maxiter
         if it < maxiter
            color3 it / 20 it / 100 it / 150
            move scr_x / res scr_y / res
            rect 1 / res 1 / res
         .
      .
   .
   color 990
   move 1 1
   text "Short press to zoom in, long to zoom out"
.
on mouse_down
   time0 = systime
.
on mouse_up
   center_x += mid - mouse_x * res
   center_y += mid - mouse_y * res
   if systime - time0 < 0.3
      center_x -= mid - center_x
      center_y -= mid - center_y
      scale *= 2
   else
      center_x += (mid - center_x) * 3 / 4
      center_y += (mid - center_y) * 3 / 4
      scale /= 4
   .
   draw
.
draw
