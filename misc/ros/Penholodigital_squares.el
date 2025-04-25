proc nextperm &a[] &k .
   n = len a[]
   k = n - 1
   while k >= 1 and a[k + 1] < a[k] : k -= 1
   if k = 0 : return
   l = n
   while a[l] < a[k] : l -= 1
   swap a[l] a[k]
   k += 1
   while k < n
      swap a[k] a[n]
      k += 1
      n -= 1
   .
.
func$ base n b .
   if n = 0 : return ""
   d = n mod b + 48
   if d >= 58 : d += 39
   return base (n div b) b & strchar d
.
for b in [ 9 10 11 12 ]
   print "Penholodigital squares in base " & b & ":"
   cnt = 0
   digs[] = [ ]
   for i to b - 1 : digs[] &= i
   repeat
      n = 0
      for d in digs[] : n = n * b + d
      if sqrt n mod 1 = 0
         cnt += 1
         write base sqrt n b & "² = " & base n b & " "
         if cnt mod 3 = 0 : print ""
      .
      nextperm digs[] ok
      until ok = 0
   .
   if cnt mod 3 <> 0 : print ""
   print "(" & cnt & " items)"
   print ""
.
