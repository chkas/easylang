func fua lim .
   # this is interpreted
   i = 1
   while i <= lim
      sum += i
      i += 1
   .
   return sum
.
start = systime
print fua 1e8
print systime - start
# 
fastfunc fub lim .
   # this is compiled to wasm
   i = 1
   while i <= lim
      sum += i
      i += 1
   .
   return sum
.
start = systime
print fub 1e8
print systime - start
