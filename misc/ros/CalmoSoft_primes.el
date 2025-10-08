fastfunc isprim num .
   if num mod 2 = 0 and num > 2 : return 0
   i = 3
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 2
   .
   return 1
.
for n = 2 to 99
   if isprim n = 1 : primes[] &= n
.
tam = len primes[]
primesum[] = [ 2 ]
for i = 2 to tam
   primesum[] &= primesum[i - 1] + primes[i]
.
for head = tam downto 1
   sum = primesum[head]
   for tail = 1 to head
      if head - tail > longest
         if isprim sum = 1
            longest = head - tail
            head0 = head
            tail0 = tail
         .
         sum -= primes[tail]
      .
   .
.
for i = tail0 to head0
   write primes[i] & " "
.
print ""
sum = 0
for i = tail0 to head0
   sum += primes[i]
   write primes[i]
   if i <> head0 : write " + "
.
print " = " & sum
print "Longest sequence = " & longest + 1
