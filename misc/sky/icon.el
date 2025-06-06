c = 797
gcolor c
grect 0 0 100 100
gcolor 000
glinewidth 6
gline 24 24 76 24
gline 76 24 76 76
gline 76 76 24 76
gline 24 76 24 24
#
gcolor 333
grect 27 27 46 46
x[] = [ 43 55 37 50 57 61 ]
y[] = [ 35 39 45 50 58 68 ]
gcolor 999
for i = 1 to len x[]
   gcircle x[i] y[i] 1
.
#
gcolor c
gcircle 75 75 2
# sysproc "id:10"

