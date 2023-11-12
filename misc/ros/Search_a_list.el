haystack$[] = [ "Zig" "Zag" "Wally" "Ronald" "Bush" "Krusty" "Charlie" "Bush" "Boz" "Zag" ]
# 
func getind needle$ .
   for i to len haystack$[]
      if haystack$[i] = needle$
         return i
      .
   .
   return 0
.
# arrays are 1 based
for n$ in [ "Bush" "Washington" ]
   h = getind n$
   if h = 0
      print n$ & " not found"
   else
      print n$ & " found at " & h
   .
.
