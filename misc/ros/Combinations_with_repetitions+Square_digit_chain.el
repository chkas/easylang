func fac n .
   r = 1
   for i = 2 to n
      r *= i
   .
   return r
.
fastfunc ends89 n .
   repeat
      s = 0
      while n > 0
         d = n mod 10
         s += d * d
         n = n div 10
      .
      n = s
      if n = 89
         return 1
      .
      until n = 1
   .
   return 0
.
items[] = [ 0 1 2 3 4 5 6 7 8 9 ]
global comb[] sum .
# 
proc docomb .
   ncomb = fac len comb[]
   for i = 1 to len comb[]
      h = items[comb[i]]
      cnt += 1
      if i = len comb[] or h <> items[comb[i + 1]]
         ncomb /= fac cnt
         cnt = 0
      .
      v = v * 10 + h
   .
   if v > 0 and ends89 v = 1
      sum += ncomb
   .
.
proc combine pos val .
   if pos > len comb[]
      docomb
      return
   .
   for i = val to len items[]
      comb[pos] = i
      combine pos + 1 i
   .
.
for h in [ 7 8 11 14 ]
   len comb[] h
   sum = 0
   combine 1 1
   print sum
.
