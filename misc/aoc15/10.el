# AoC-15 - Day 10: Elves Look, Elves Say
# 
f[] = number strchars input
proc run . .
   fn[] = [ ]
   n = 1
   for i = 2 to len f[]
      if f[i] = f[i - 1]
         n += 1
      else
         fn[] &= n
         fn[] &= f[i - 1]
         n = 1
      .
   .
   fn[] &= n
   fn[] &= f[i - 1]
   swap f[] fn[]
.
for i to 50
   run
   if i = 40
      print len f[]
   .
.
print len f[]
# 
input_data
1


