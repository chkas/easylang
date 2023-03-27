# AoC-18 - Day 1: Chronal Calibration
# 
repeat
   s$ = input
   until s$ = ""
   l[] &= number s$
.
# 
len in[] 2000000
for i to len l[]
   s += l[i]
   in[s + 1000000] = 1
.
print s
# 
i = 1
repeat
   s += l[i]
   until in[s + 1000000] = 1
   i = i mod len l[] + 1
.
print s
# 
input_data
+7
+7
-2
-7
-4



