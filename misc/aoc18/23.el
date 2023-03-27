# AoC-18 - Day 23: Experimental Emergency Teleportation
# 
# not generally correct
# 
minr = 1 / 0
# 
repeat
   s$[] = strsplit input "<,> ="
   until len s$[] < 9
   x = number s$[3]
   y = number s$[4]
   z = number s$[5]
   r = number s$[9]
   bx[] &= x
   by[] &= y
   bz[] &= z
   br[] &= r
   if x < xmin
      xmin = x
   elif x > xmax
      xmax = x
   .
   if y < xmin
      ymin = y
   elif y > ymax
      ymax = y
   .
   if z < zmin
      zmin = z
   elif z > zmax
      zmax = z
   .
   if r > maxr
      maxr = r
      maxi = len br[]
   elif r < minr
      minr = r
   .
.
bn = len bx[]
for i to bn
   if abs (bx[maxi] - bx[i]) + abs (by[maxi] - by[i]) + abs (bz[maxi] - bz[i]) <= maxr
      cnt += 1
   .
.
print cnt
# 
step = minr div 2
# 
repeat
   max_cnt = 0
   x = xmin
   while x <= xmax
      y = ymin
      while y <= ymax
         z = zmin
         while z <= zmax
            cnt = 0
            for i to bn
               if abs (x - bx[i]) + abs (y - by[i]) + abs (z - bz[i]) <= br[i]
                  cnt += 1
               .
            .
            if cnt > max_cnt
               my_dist = abs x + abs y + abs z
               xm = x
               ym = y
               zm = z
               max_cnt = cnt
            elif cnt = max_cnt and abs x + abs y + abs z < my_dist
               my_dist = abs x + abs y + abs z
            .
            z += step
         .
         y += step
      .
      x += step
   .
   xmin = xm - step
   xmax = xm + step
   ymin = ym - step
   ymax = ym + step
   zmin = zm - step
   zmax = zm + step
   until step = 1
   step = step div 10 + 1
.
# print max_cnt
print my_dist
# 
# 
input_data
pos=<10,12,12>, r=2
pos=<12,14,12>, r=2
pos=<16,12,12>, r=4
pos=<14,14,14>, r=6
pos=<50,50,50>, r=200
pos=<10,10,10>, r=5



