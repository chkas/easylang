x = 5
y = 10
ang = 60
glinewidth 0.5
glineto x y
# 
proc curv o l a .
   if o = 0
      x += cos ang * l
      y += sin ang * l
      glineto x y
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
curv 7 90 -60
