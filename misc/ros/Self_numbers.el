fastfunc digsum h .
   while h > 0
      ds += h mod 10
      h = h div 10
   .
   return ds
.
fastfunc isself j i .
   sum = j + digsum j
   while j < i
      if sum = i : return 0
      sum += 2
      j += 1
      if j mod 10 = 0
         if j mod 100 <> 0
            sum -= 9
         else
            sum = j + digsum j
         .
         if sum + 18 <= i or sum > i or (sum + i) mod 2 <> 0
            j += 9
            sum += 18
         .
      .
   .
   return 1
.
global pow10 offs .
fastfunc next ind .
   repeat
      ind += 1
      if ind = pow10
         pow10 *= 10
         offs += 9
      .
      until isself (ind - offs) ind = 1
   .
   return ind
.
proc first50 .
   pow10 = 10
   offs = 9
   repeat
      ind = next ind
      cnt += 1
      write ind & " "
      until cnt = 50
   .
   print ""
.
first50
#  
fastfunc getselfnr lim .
   pow10 = 10
   offs = 9
   repeat
      ind = next ind
      cnt += 1
      until cnt = lim
   .
   return ind
.
print getselfnr 100000000
