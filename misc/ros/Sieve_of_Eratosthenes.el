len sieve[] 100
max = sqrt len sieve[]
for i = 2 to max
   if sieve[i] = 0
      for j = i * i step i to len sieve[]
         sieve[j] = 1
      .
   .
.
for i = 2 to len sieve[]
   if sieve[i] = 0 : write i & " "
.
print ""
