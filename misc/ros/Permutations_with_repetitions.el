n = 3
values$[] = strchars "ABCD"
# 
func decide pc$[] .
   return if pc$[1] = "B" and pc$[2] = "C"
.
for i to n
   pn[] &= 1
.
len pc$[] n
repeat
   for i to len pn[]
      pc$[i] = values$[pn[i]]
   .
   print strjoin pc$[]
   until decide pc$[] = 1
   i = 1
   repeat
      pn[i] += 1
      until pn[i] <= len values$[]
      pn[i] = 1
      i += 1
      if i = n
         print "done"
         break 2
      .
   .
.
