fastfunc ndig n .
   while n > 0
      n = n div 10
      d += 1
   .
   return d
.
fastfunc getexp n f .
   while n mod f = 0
      n = n div f
      e += 1
   .
   return e
.
len d[] 2000000
fastproc sieve .
   # count factors and get digit count
   d[1] = 1
   for i = 2 to len d[] : if d[i] = 0
      j = i
      while j <= len d[]
         d[j] += ndig i
         e = getexp j i
         if e > 1 : d[j] += ndig e
         j += i
      .
   .
   # classify
   for i to len d[]
      d[i] = sign (ndig i - d[i]) + 2
   .
.
sieve
proc show t s$ .
   print "First 50 " & s$ & " numbers: "
   print ""
   i = 1
   repeat
      if d[i] = t
         cnt += 1
         if cnt <= 50 : write i & " "
      .
      until cnt = 10000
      i += 1
   .
   print ""
   print ""
   print "10000th " & s$ & " number: " & i
   print ""
.
show 1 "Wasteful"
show 2 "Equidigital"
show 3 "Frugal"
len sum[] 3
for i to 999999 : sum[d[i]] += 1
print "For numbers less than 1000000 there are "
print "Wasteful: " & sum[1]
print "Equidigital: " & sum[2]
print "Frugal: " & sum[3]
