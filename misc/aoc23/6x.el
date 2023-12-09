# AoC-23 - Day 6: Wait For It
# 
global t[] d[] t2 d2 .
proc init . .
   for _ to 2
      s$ = substr input 10 -1
      i = 0
      repeat
         repeat
            i += 1
            until substr s$ i 1 <> " "
         .
         t[] &= number substr s$ i -1
         repeat
            t2 = t2 * 10 + number substr s$ i 1
            i += 1
            until substr s$ i 1 = " " or substr s$ i 1 = ""
         .
         until substr s$ i 1 = ""
      .
      swap t2 d2
      swap t[] d[]
   .
.
call init
# 
func wins t0 d0 .
   for t = 1 to t0 - 1
      s = t
      d = s * (t0 - t)
      w += if (d > d0)
   .
   return w
.
prod = 1
for i to len t[]
   prod *= wins t[i] d[i]
.
print prod
print wins t2 d2
# 
input_data
Time:      7  15   30
Distance:  9  40  200
