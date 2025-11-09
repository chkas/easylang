func$ bottle num .
   if num = 1 : return "1 bottle"
   return num & " bottles"
.
i = 99
repeat
   print bottle i & " of beer on the wall"
   print bottle i & " of beer"
   print "Take one down, pass it around"
   i -= 1
   until i = 0
   print bottle i & " of beer on the wall"
   print ""
.
print "No more bottles of beer on the wall"
