limit = 10000
maxn = 10000 * 9 * 4
# 
len consummate[] limit
# 
func digsum i .
   res = 0
   while i > 0
      res += i mod 10
      i = i div 10
   .
   return res
.
for d = 1 to maxn
   ds = digsum d
   if d mod ds = 0
      q = d / ds
      if q <= limit
         consummate[q] = 1
      .
   .
.
d = 1
repeat
   if d > len consummate[]
      print "error - increase limit"
      break 1
   .
   if consummate[d] = 0
      cnt += 1
      if cnt <= 50
         write d & " "
      .
   .
   until cnt = 1000
   d += 1
.
print ""
print ""
print d
