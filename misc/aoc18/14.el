# AoC-18 - Day 14: Chocolate Charts
# 
f[] = [ 3 7 ]
i1 = 1
i2 = 2
s$ = input
inp = number s$
inlen = len s$
inmod = pow 10 inlen
# 
subr add
   f[] &= dig
   n = (n * 10 + dig) mod inmod
   if n = inp
      print len f[] - inlen
      done = 1
   .
   if len f[] = inp + 10
      for i = inp + 1 to inp + 10
         write f[i]
      .
      print ""
   .
.
repeat
   new = f[i1] + f[i2]
   if new >= 10
      dig = 1
      call add
      new -= 10
   .
   dig = new
   call add
   until done = 1
   i1 = (i1 + f[i1]) mod len f[] + 1
   i2 = (i2 + f[i2]) mod len f[] + 1
.
# 
input_data
2018

