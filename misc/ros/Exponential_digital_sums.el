func digsum bn[] .
   for d in bn[] : for i to 7
      sum += d mod 10
      d = d div 10
   .
   return sum
.
proc bnmul &a[] b .
   for d in a[]
      h = c + d * b
      r[] &= h mod 10000000
      c = h div 10000000
   .
   if c > 0 : r[] &= c
   swap a[] r[]
.
proc show nshow min .
   n = 2
   while cnt < nshow
      num[] = [ n ]
      c = 0
      s$ = ""
      for i = 2 to 100
         bnmul num[] n
         if digsum num[] = n
            c += 1
            s$ &= n & "^" & i & "  "
         .
      .
      if c >= min
         cnt += 1
         print s$
      .
      n += 1
   .
   print ""
.
show 20 1
show 10 3
