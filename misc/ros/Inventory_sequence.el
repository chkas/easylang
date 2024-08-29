sysconf zero_based
repeat
   cnts[] &= 0
   n = cnts[i]
   cnts[n] += 1
   if len cnts[] <= 100
      write n & " "
   .
   i += 1
   if n = 0
      i = 0
   .
   until n > 1000
.
print ""
print len cnts[] & " " & n
