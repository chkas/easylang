# AoC-15 - Day 1: Not Quite Lisp
# 
s$ = input
for i to len s$
   if substr s$ i 1 = "("
      fl += 1
   else
      fl -= 1
      if fl = -1 and bas = 0
         bas = i
      .
   .
.
print fl
print bas
# 
input_data
()())())


