n = 5
m = 3
len result[] m
# 
proc combinations pos val . .
   if pos <= m
      for i = val to n - m
         result[pos] = pos + i
         combinations pos + 1 i
      .
   else
      print result[]
   .
.
combinations 1 0
