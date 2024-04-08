sym$[] = [ "F" "?" "T" ]
arrbase sym$[] -1
# 
func tnot x .
   return -x
.
func tand x y .
   if x > y
      return tand y x
   .
   return x
.
func tor x y .
   if x < y
      return tor y x
   .
   return x
.
func teqv x y .
   return x * y
.
func timp x y .
   if -y > x
      return -y
   .
   return x
.
print "     (AND)    ( OR)    (EQV)    (IMP)   (NOT)"
print "     F ? T    F ? T    F ? T    F ? T        "
print "    -----------------------------------------"
for i = -1 to 1
   o$ = " " & sym$[i] & " | "
   o$ &= sym$[tand -1 i] & " " & sym$[tand 0 i] & " " & sym$[tand 1 i]
   o$ &= "    "
   o$ &= sym$[tor -1 i] & " " & sym$[tor 0 i] & " " & sym$[tor 1 i]
   o$ &= "    "
   o$ &= sym$[timp -1 i] & " " & sym$[timp 0 i] & " " & sym$[timp 1 i]
   o$ &= "    "
   o$ &= sym$[timp -1 i] & " " & sym$[timp 0 i] & " " & sym$[timp 1 i]
   o$ &= "     " & sym$[tnot i]
   print o$
.
