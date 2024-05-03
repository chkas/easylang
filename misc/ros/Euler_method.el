TR = 20
K = -0.07
func analytic T0 t .
   return TR + (T0 - TR) * pow 2.71828 (K * t)
.
ytxt = 95
proc draw_analytic a b . .
   color 009
   move 80 ytxt
   ytxt -= 5
   text "analytic"
   for t = a to b
      line t analytic 100 t
   .
.
drawgrid
linewidth 0.3
textsize 3
draw_analytic 0 100
# 
func newton_cooling temp .
   return K * (temp - TR)
.
proc draw_euler y0 a b step col . .
   color col
   move 80 ytxt
   ytxt -= 5
   text "step: " & step
   t = a
   y = y0
   while t < b
      line t y
      t += step
      y += step * newton_cooling y
   .
.
draw_euler 100 0 100 10 900
draw_euler 100 0 100 5 555
draw_euler 100 0 100 2 090
