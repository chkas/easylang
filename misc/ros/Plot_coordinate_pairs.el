x[] = [ 0 1 2 3 4 5 6 7 8 9 ]
y[] = [ 2.7 2.8 31.4 38.1 58.0 76.2 100.5 130.0 149.3 180.0 ]
# 
glinewidth 0.5
gline 10 5 10 97
gline 10 5 95 5
gtextsize 3
n = len x[]
for i to n : max = higher y[i] max
glinewidth 0.1
sty = max div 9
stx = x[n] div 9
for i range0 10
   gline 10 5 + i * 10 95 5 + i * 10
   gtext 2 4 + i * 10 i * sty
   gline i * 9 + 10 5 i * 9 + 10 97
   gtext i * 9 + 10 1 i * stx
.
color 900
linewidth 0.5
gpenup
for i = 1 to n
   x = x[i] * 9 / stx + 10
   y = y[i] / sty * 10 + 5
   glineto x y
.
