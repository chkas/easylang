TR = 20
K = -0.07
ytxt = 95
drawgrid
glinewidth 0.3
gtextsize 3
# 
func newton_cooling temp .
   return K * (temp - TR)
.
proc draw_euler y t t2 step col .
   gcolor col
   gtext 80 ytxt "step: " & step
   ytxt -= 5
   gpenup
   while t <= t2
      glineto t y
      t += step
      y += step * newton_cooling y
   .
.
func analytic T0 t .
   return TR + (T0 - TR) * pow 2.71828 (K * t)
.
proc draw_analytic a b .
   gcolor 009
   gtext 80 ytxt "analytic"
   ytxt -= 5
   gpenup
   for t = a to b
      y = analytic 100 t
      glineto t y
   .
.
draw_euler 100 0 100 10 900
draw_euler 100 0 100 5 555
draw_euler 100 0 100 2 090
draw_analytic 0 100
