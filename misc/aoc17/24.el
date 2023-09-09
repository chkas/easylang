# AoC-17 - Day 24: Electromagnetic Moat
# 
# base0
s0$ = input
repeat
   s$ = input
   until s$ = ""
   h[] = number strsplit s$ "/"
   a[] &= h[1]
   b[] &= h[2]
.
h[] = number strsplit s0$ "/"
a[] &= h[1]
b[] &= h[2]
n = len a[]
len used[] n
# 
arrbase a[] 0
arrbase b[] 0
arrbase used[] 0
# 
proc con pins used[] ln . str0 ln0 ln0str .
   str0 = 0
   ln0 = 0
   for i range0 n
      if used[i] = 0 and (a[i] = pins or b[i] = pins)
         used[i] = 1
         if a[i] = pins
            con b[i] used[] ln + 1 str ln lnstr
         else
            con a[i] used[] ln + 1 str ln lnstr
         .
         used[i] = 0
         str += a[i] + b[i]
         if str > str0
            str0 = str
         .
         ln = ln + 1
         if ln > ln0
            ln0 = ln
            ln0str = a[i] + b[i] + lnstr
         elif ln = ln0 and str > ln0str
            ln0str = a[i] + b[i] + lnstr
         .
      .
   .
.
# 
con 0 used[] 0 str ln lnstr
print str
print lnstr
# 
input_data
0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10



