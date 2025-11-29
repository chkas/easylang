background 888
clear
proc eye x y . .
   color 999
   move x y
   circle 6.5
   color 000
   cx = mouse_x - x
   cy = mouse_y - y
   l = sqrt (cy * cy + cx * cx) / 2
   move x + cx / l y + cy / l
   circle 3
.
subr eyes
   eye 10 90
   eye 30 90
   mx = mouse_x
   my = mouse_y
.
linewidth 2
on mouse_move
   if down = 1
      move mx my
      line mouse_x mouse_y
   .
   eyes
.
on mouse_down
   down = 1
   move mouse_x mouse_y
   circle 1
   eyes
.
on mouse_up
   down = 0
.
eyes

