proc simulate verbose &t &last .
   if verbose = 1 : print "Seconds   Steps behind   Steps ahead"
   curr = 1
   last = 100
   t = 0
   repeat
      t += 1
      curr += 1
      until curr > last
      for i to 5
         n = random last
         if n < curr : curr += 1
         last += 1
      .
      if verbose = 1 and t >= 600 and t <= 609
         print " " & t & "       " & curr & "           " & last - curr
         if t = 609 : return
      .
   .
.
simulate 1 t n
print ""
for i to 10000
   simulate 0 t n
   tsum += t
   stepsum += n
.
print "Average seconds taken: " & tsum / 10000
print "Average final length of staircase: " & stepsum / 10000
