x = 5
y = 10
ang = 60
linewidth 0.5
# 
proc curv o l a . .
   if o = 0
      x += cos ang * l
      y += sin ang * l
      line x y
   else
      o -= 1
      l /= 2
      curv o l (-a)
      ang += a
      curv o l a
      ang += a
      curv o l (-a)
   .
.
move x y
curv 7 90 -60
