maxn = 1000000
len sieve[] maxn
proc mksieve . .
   max = sqrt len sieve[]
   for d = 2 to max
      if sieve[d] = 0
         for i = d * d step d to len sieve[]
            sieve[i] = 1
         .
      .
   .
   sieve[] &= 0
.
mksieve
func nextprim n .
   repeat
      n += 1
      until sieve[n] = 0
   .
   return n
.
# 
func digs n .
   while n > 0
      r += pow 10 (n mod 10)
      n = n div 10
   .
   return r
.
print "First 30 Ormiston pairs:"
a = 2
repeat
   b = a
   db = da
   a = nextprim a
   until a > maxn
   da = digs a
   if da = db
      cnt += 1
      if cnt <= 30
         write "(" & b & " " & a & ") "
      .
   .
.
print ""
print "Ormiston pairs up to million: " & cnt
