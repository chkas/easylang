# AoC-19 - Day 1: The Tyranny of the Rocket Equation
# 
proc fuel2 w . fs .
   fs = 0
   repeat
      f = w div 3 - 2
      until f <= 0
      fs += f
      w = f
   .
.
repeat
   s$ = input
   until s$ = ""
   w = number s$
   f1 += w div 3 - 2
   call fuel2 w h
   f2 += h
.
print f1
print f2
# 
input_data
12
14
1969
100756


