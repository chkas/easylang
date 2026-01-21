FUSCMAX = 20000000
len fusc[] FUSCMAX + 1
#
fastproc fill .
   fusc[1] = 1
   for n = 2 to FUSCMAX
      if n mod 2 = 0
         fusc[n] = fusc[n / 2]
      else
         fusc[n] = fusc[(n - 1) / 2] + fusc[(n + 1) / 2]
      .
   .
.
fill
write "0 "
for n = 1 to 60 : write fusc[n] & " "
print ""
print ""
start = 1
print "fusc[0] = 0"
for i = 1 to 5
   val = floor pow 10 i
   for j = start to FUSCMAX
      if fusc[j] > val
         print "fusc[" & j & "] = " & fusc[j]
         start = j
         break 1
      .
   .
.
