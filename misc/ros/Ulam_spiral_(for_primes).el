func isprim num .
   if num < 2 : return 0
   i = 2
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 1
   .
   return 1
.
# 
subr turn
   if dx = 1
      dx = 0
      dy = 1
   elif dy = 1
      dy = 0
      dx = -1
   elif dx = -1
      dx = 0
      dy = -1
   else
      dx = 1
      dy = 0
   .
.
subr step
   n += 1
   x += dx
   y += dy
   if isprim n = 1 : gcircle x y 0.5
.
gtextsize 3
n = 1
x = 50
y = 50
dx = 1
dy = 0
lng = 0
# 
for k to 49
   step
   lng += 2
   turn
   for j to lng - 1 : step
   for i to 3
      turn
      for j to lng : step
   .
.
