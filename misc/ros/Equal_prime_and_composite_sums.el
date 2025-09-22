fastfunc isprim num .
   if num < 2 : return 0
   if num mod 2 = 0 and num > 2 : return 0
   i = 3
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 2
   .
   return 1
.
comp = 2
cont = 1
#
numfmt 11 0
print "        sum     primes composites"
repeat
   if primeSum < compSum or cont = 1
      repeat
         prime += 1
         until isprim prime = 1
      .
      primeSum += prime
      primeCnt += 1
   .
   if compSum < primeSum or cont = 1
      repeat
         comp += 1
         until isprim comp = 0
      .
      compSum += comp
      compCnt += 1
   .
   cont = 0
   if primeSum = compSum
      print primeSum & primeCnt & compCnt
      cont = 1
      cnt += 1
   .
   until cnt >= 8
.
