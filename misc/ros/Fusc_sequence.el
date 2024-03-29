FUSCMAX = 20000000
len fusc[] FUSCMAX + 1
arrbase fusc[] 0
# 
fusc[0] = 0
fusc[1] = 1
for n = 2 to FUSCMAX
   if n mod 2 = 0
      fusc[n] = fusc[n / 2]
   else
      fusc[n] = fusc[(n - 1) / 2] + fusc[(n + 1) / 2]
   .
.
for n = 0 to 60
   write fusc[n] & " "
.
print ""
print ""
for i = 0 to 5
   val = -1
   if i <> 0
      val = floor pow 10 i
   .
   for j = start to FUSCMAX
      if fusc[j] > val
         print "fusc[" & j & "] = " & fusc[j]
         start = j
         break 1
      .
   .
.
