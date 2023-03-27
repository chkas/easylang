# AoC-17 - Day 11: Hex Ed
# 
in$[] = strsplit input ","
for c$ in in$[]
   if c$ = "n"
      y -= 2
   elif c$ = "s"
      y += 2
   elif c$ = "nw"
      x -= 1
      y -= 1
   elif c$ = "ne"
      x += 1
      y -= 1
   elif c$ = "sw"
      x -= 1
      y += 1
   elif c$ = "se"
      x += 1
      y += 1
   .
   steps = abs x
   if abs y > steps
      steps += (abs y - steps) div 2
   .
   max = higher max steps
.
print steps
print max
# 
input_data
se,sw,se,sw,sw


 


