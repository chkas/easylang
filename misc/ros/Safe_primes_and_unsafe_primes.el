n = 10000000 - 1
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
func isprim num .
   if num < 2 : return 0
   return 1 - sieve[num]
.
print "First 35 safe primes:"
for i = 2 to n
   if isprim i = 1 and isprim ((i - 1) div 2) = 1
      if count < 35 : write i & " "
      count += 1
   .
.
print ""
print "There are " & count & " safe primes below " & n + 1
for i = i to n
   if isprim i = 1 and isprim ((i - 1) div 2) = 1
      count += 1
   .
.
print "There are " & count & " safe primes below " & n + 1
print ""
count = 0
print "First 40 unsafe primes:"
for i = 2 to 999999
   if isprim i = 1 and isprim ((i - 1) div 2) = 0
      if count < 40 : write i & " "
      count += 1
   .
.
print ""
print "There are " & count & " unsafe primes below " & n + 1
for i = i to n
   if isprim i = 1 and isprim ((i - 1) div 2) = 0
      count += 1
   .
.
print "There are " & count & " unsafe primes below " & n + 1
