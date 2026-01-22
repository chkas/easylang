n = 10e7
len sieve[] n
fastproc mksieve .
   max = sqrt len sieve[]
   for i = 2 to max : if sieve[i] = 0
      j = i * i
      while j <= len sieve[]
         sieve[j] = 1
         j += i
      .
   .
.
mksieve
#   
fastfunc nextprim n .
   if n < 2 : return 2
   repeat
      n += 1
      until sieve[n] = 0
   .
   return n
.
proc strwkprimes ncnt sgn .
   write "First " & ncnt & ": "
   pr2 = 2
   pr3 = 3
   repeat
      pr1 = pr2
      pr2 = pr3
      until pr2 >= 10000000
      pr3 = nextprim pr3
      if pr1 < 1000000 and pr2 > 1000000
         print ""
         print "Count lower 10e6: " & cnt
      .
      if sgn * pr2 > sgn * (pr1 + pr3) / 2
         cnt += 1
         if cnt <= ncnt
            write pr2 & " "
         .
      .
   .
   print "Count lower 10e7: " & cnt
   print ""
.
print "Strong primes:"
strwkprimes 36 1
print "Weak primes:"
strwkprimes 37 -1
