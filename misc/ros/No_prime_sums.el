kind$[] = [ "both" "odd" "even" ]
len sieve[] 100000
proc init .
   for i = 2 to sqrt len sieve[]
      if sieve[i] = 0
         j = i * i
         while j <= len sieve[]
            sieve[j] = 1
            j += i
         .
      .
   .
.
init
# 
func[] noprimesums kind .
   step = 2
   if kind = 1 : step = 1
   k = 2
   if kind = 2 : k = 3
   sums[] = [ 0 1 ]
   res[] = [ 1 ]
   while len res[] < 8
      repeat
         s = -1
         for s in sums[]
            if sieve[k + s] = 0 : break 1
         .
         until s = -1
         k += step
      .
      if kind = 1 or kind = 2 and k mod 2 = 1 or kind = 3 and k mod 2 = 0
         res[] &= k
         for s in sums[] : sums[] &= s + k
      .
      k += step
   .
   return res[]
.
for k to 3 : print kind$[k] & ": " & noprimesums k
