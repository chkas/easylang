# AoC-20 - Day 12: Rain Risk
# 
repeat
   s$ = input
   until s$ = ""
   c$[] &= substr s$ 1 1
   c[] &= number substr s$ 2 99
.
# 
# Part 1
# 
deg = 90
for i to len c$[]
   c$ = c$[i]
   c = c[i]
   if c$ = "N"
      y -= c
   elif c$ = "E"
      x += c
   elif c$ = "S"
      y += c
   elif c$ = "W"
      x -= c
   elif c$ = "R"
      deg += c
      deg = deg mod 360
   elif c$ = "L"
      deg += 360 - c
      deg = deg mod 360
   elif c$ = "F"
      if deg = 0
         y -= c
      elif deg = 90
         x += c
      elif deg = 180
         y += c
      elif deg = 270
         x -= c
      else
         print "error turn"
      .
   else
      print "error"
   .
.
print abs x + abs y
# 
# Part 2 
# 
wx = 10
wy = -1
x = 0
y = 0
for i to len c$[]
   c$ = c$[i]
   c = c[i]
   if c$ = "N"
      wy -= c
   elif c$ = "E"
      wx += c
   elif c$ = "S"
      wy += c
   elif c$ = "W"
      wx -= c
   elif c$ = "R" or c$ = "L"
      if c$ = "L"
         c = 360 - c
      .
      wxo = wx
      wyo = wy
      if c = 90
         wy = wxo
         wx = -wyo
      elif c = 180
         wy = -wyo
         wx = -wxo
      elif c = 270
         wy = -wxo
         wx = wyo
      else
         print "error turn"
      .
   elif c$ = "F"
      x += wx * c
      y += wy * c
   else
      print "error"
   .
.
print abs x + abs y
# 
#  
input_data
F10
N3
F7
R90
F11


