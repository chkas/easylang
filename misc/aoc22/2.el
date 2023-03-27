# AoC-22 - Day 2: Rock Paper Scissors
# 
# 
win[] = [ 2 3 1 ]
loose[] = [ 3 1 2 ]
# 
repeat
   s$ = input
   until s$ = ""
   a = (strcode substr s$ 1 1) - strcode "A" + 1
   b = (strcode substr s$ 3 1) - strcode "X" + 1
   x1 += b
   if b = a
      x1 += 3
   elif win[a] = b
      x1 += 6
   .
   if b = 2
      x2 += 3 + a
   elif b = 3
      x2 += 6 + win[a]
   else
      x2 += loose[a]
   .
.
print x1
print x2
# 
input_data
A Y
B X
C Z

