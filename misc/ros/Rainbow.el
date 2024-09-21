s$ = "RAINBOW"
cols[] = [ 900 950 990 090 009 306 509 ]
textsize 15
background 000
clear
for i to 7
   color cols[i]
   move i * 11.5 60
   text substr s$ i 1
.
