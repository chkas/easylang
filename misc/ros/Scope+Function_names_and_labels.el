# function names are global, the must be
# implemented or declared before usage
# 
func foo1 a .
   return a + 1
.
print foo1 2
# 
funcdecl foo2 a .
print foo2 2
func foo2 a .
   return a + 2
.
