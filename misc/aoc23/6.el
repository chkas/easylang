# AoC-23 - Day 6: Wait For It
# 
proc ginp . t[] t2 .
   t[] = number strsplit input " "
   for t in t[]
      h$ &= t
   .
   t2 = number h$
.
ginp t[] t2
ginp d[] d2
# 
func f t0 d0 .
   for t = 0 to t0
      d = t * (t0 - t)
      w += if d > d0
   .
   return w
.
prod = 1
for i to len t[]
   prod *= f t[i] d[i]
.
print prod
print f t2 d2
# 
input_data
Time:      7  15   30
Distance:  9  40  200
