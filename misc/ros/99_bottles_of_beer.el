func$ bottle num .
   if num = 1
      return "bottle"
   .
   return "bottles"
.
# 
i = 99
repeat
   print i & " " & bottle i & " of beer on the wall"
   print i & " " & bottle i & " of beer"
   print "Take one down, pass it around"
   i -= 1
   until i = 0
   print i & " " & bottle i & " of beer on the wall"
   print ""
.
print "No more bottles of beer on the wall"
