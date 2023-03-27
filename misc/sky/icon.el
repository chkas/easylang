c = 797
color c
rect 100 100
color 000
linewidth 6
move 24 24
line 76 24
line 76 76
line 24 76
line 24 24
# 
color 333
move 27 27
rect 46 46
x[] = [ 43 55 37 50 57 61 ]
y[] = [ 35 39 45 50 58 68 ]
color 999
for i = 1 to len x[]
  move x[i] y[i]
  circle 1
.
# 
color c
move 75 75
circle 2
#sysfunc "id:10"

