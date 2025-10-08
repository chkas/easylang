proc hourgl_puzzle .
   repeat
      t7_left = 7 - t4 mod 7
      until t7_left = 9 - 4
      t4 += 4
   .
   print "Turn over both hour glasses at the same time"
   print "and continue flipping them each when they "
   print "individually run down until the 4 hour glass"
   print "is flipped " & t4 div 4 & " times, wherupon the 7 hour glass"
   print "is immediately placed on its side with " & t7_left & " hours"
   print "of sand in it."
   print "You can measure 9 hours by flipping the 4 hour"
   print "glass once, then flipping the remaining sand in"
   print "the 7 hour glass when the 4 hour glass ends."
.
hourgl_puzzle
