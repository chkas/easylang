TR = 20
K = -0.07
func analytic T0 t .
   return TR + (T0 - TR) * pow 2.71828 (K * t)
.
ytxt = 95
proc draw_analytic a b .
   gcolor 009
   gtext 80 ytxt "analytic"
   ytxt -= 5
   for t = a to b
      yp = y
      y = analytic 100 t
      if t > a : gline t - 1 yp t y
   .
.
drawgrid
glinewidth 0.3
gtextsize 3
draw_analytic 0 100
# 
func newton_cooling temp .
   return K * (temp - TR)
.
proc draw_euler y t t2 step col .
   gcolor col
   gtext 80 ytxt "step: " & step
   ytxt -= 5
   repeat
      t += step
      yp = y
      y += step * newton_cooling y
      gline t - step yp t y
      until t >= t2
   .
.
draw_euler 100 0 100 10 900
draw_euler 100 0 100 5 555
draw_euler 100 0 100 2 090
