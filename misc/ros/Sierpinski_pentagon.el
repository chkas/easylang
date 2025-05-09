order = 5
# 
clear
linewidth 0.2
scale = 1 / (2 + cos 72 * 2)
# 
proc pentagon x y side depth .
   if depth = 0
      move x y
      for angle = 0 step 72 to 288
         x += cos angle * side
         y += sin angle * side
         line x y
      .
   else
      side *= scale
      dist = side + side * cos 72 * 2
      for angle = 0 step 72 to 288
         x += cos angle * dist
         y += sin angle * dist
         pentagon x y side depth - 1
      .
   .
.
pentagon 25 15 50 order - 1
