maxn = 1e9
slen = (maxn - 1) / 2
len sieve@[] slen + 1
fastproc .
   klim = (floor sqrt maxn - 1) / 2
   for kd = 1 to klim : if sieve@[kd] = 0
      d = 2 * kd + 1
      start = (d * d - 1) / 2
      for k = start step 2 * d to slen - d
         sieve@[k] = 1
         sieve@[k + d] = 1
      .
      if k <= slen : sieve@[k] = 1
   .
.
len pow10[] 10
proc .
   for i = 1 to 10 : pow10[i] = pow 10 (i - 1)
.
indsv = 0
fastfunc nextprim .
   repeat
      indsv += 1
      until sieve@[indsv] = 0
   .
   return indsv * 2 + 1
.
fastfunc digs n .
   while n > 0
      r += pow10[n mod 10 + 1]
      n = n div 10
   .
   return r
.
a = 3
b = 2
c = 0
fastproc next .
   db = digs b
   da = digs a
   repeat
      c = b
      dc = db
      b = a
      db = da
      a = nextprim
      da = digs a
      until a > maxn or da = db and da = dc
   .
.
# 
print "Smallest member of the first 25 Ormiston triples:"
repeat
   next
   until a > maxn
   cnt += 1
   if cnt <= 25 : write c & " "
.
print ""
print "Ormiston triples before 1 billion: " & cnt
