subr home
   deg = 0
   x = 50
   y = 50
   down = 0
   gpenup
   glineto x y
.
home
# 
proc forward n .
   x += cos deg * n
   y += sin deg * n
   if down = 0 : gpenup
   glineto x y
   sleep 0.05
.
proc turn a .
   deg -= a
.
# 
proc house .
   turn 180
   forward 45
   turn 180
   down = 1
   # 
   forward 30
   turn 90
   forward 30
   turn 90
   forward 30
   turn 90
   forward 30
   # 
   turn 30
   forward 30
   turn 120
   forward 30
   home
.
house
# 
proc bar a[] .
   turn 90
   forward 30
   turn -90
   down = 1
   for i to len a[]
      max = higher max a[i]
   .
   for i to len a[]
      h = a[i] / max * 50
      w = 45 / len a[]
      turn -90
      forward h
      turn 90
      forward w
      turn 90
      forward h
      turn -90
   .
   turn 180
   forward 45
   home
.
bar [ 50 33 200 130 50 ]
