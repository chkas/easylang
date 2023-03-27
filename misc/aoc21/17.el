# AoC-21 - Day 17: Trick Shot
# 
# For each trial, simulate the firing probe
# with vx and vy until the probe hits or
# passes the target. vx can be at most x2,
# vy from -y2 to y2.
# 
a$[] = strsplit input " "
b$[] = strsplit a$[3] "."
x1 = number substr b$[1] 3 99
x2 = number substr b$[3] 1 len b$[2] - 1
b$[] = strsplit a$[4] "."
y1 = number b$[3]
y2 = number substr b$[1] 3 99
# 
for vx0 = 1 to x2
   for vy0 = y2 to -y2
      x = 0 ; y = 0
      vy = vy0 ; vx = vx0
      my = 0
      repeat
         x += vx ; y += vy
         until x > x2 or y < y2
         my = higher my y
         if x >= x1 and y <= y1
            maxy = higher maxy my
            npos += 1
            break 1
         .
         vx = higher (vx - 1) 0
         vy -= 1
      .
   .
.
print maxy
print npos
# 
input_data
target area: x=20..30, y=-10..-5

