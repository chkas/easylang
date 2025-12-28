func logn n .
   return log n 0
.
proc sundaram np &primes[] .
   nmax = floor (np * (logn np + logn logn np) - 0.9385) + 1
   k = (nmax - 2) / 2
   len marked[] k
   for i to k
      h = 2 * i + 2 * i * i
      while h <= k
         marked[h] = 1
         h += 2 * i + 1
      .
   .
   i = 1
   primes[] = [ ]
   while np > 0
      if marked[i] = 0
         np -= 1
         primes[] &= 2 * i + 1
      .
      i += 1
   .
.
sundaram 100 primes[]
print primes[]
sundaram 1000000 primes[]
print primes[len primes[]]
