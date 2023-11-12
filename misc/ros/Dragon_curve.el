color 050
linewidth 0.5
x = 25
y = 60
move x y
angle = 0
# 
proc dragon size lev d . .
   if lev = 0
      x -= cos angle * size
      y += sin angle * size
      line x y
   else
      dragon size / sqrt 2 lev - 1 1
      angle -= d * 90
      dragon size / sqrt 2 lev - 1 -1
   .
.
dragon 60 12 1
