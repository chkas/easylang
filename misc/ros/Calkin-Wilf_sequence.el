fastfunc next n d .
   n = 2 * (n div d) * d + d - n
   return n
.
fastfunc search n0 d0 .
   n = 1
   d = 1
   i = 1
   while n <> n0 or d <> d0
      dp = d
      d = next n d
      n = dp
      i += 1
   .
   return i
.
print "The first 20 terms of the Calkwin-Wilf sequence are:"
n = 1
d = 1
for i to 20
   write n & "/" & d & " "
   dp = d
   d = next n d
   n = dp
.
print ""
print "83116/51639 is at position " & search 83116 51639
