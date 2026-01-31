func$ itoa n b .
   if n = 0 : return ""
   d = n mod b + 48
   if d >= 58 : d += 7
   return itoa (n div b) b & strchar d
.
fastfunc unique s b .
   len dig[] b + 1
   while s > 0
      dig[s mod b + 1] = 1
      s = s div b
   .
   for v in dig[] : cnt += v
   return cnt
.
fastfunc find b .
   n = floor pow b ((b - 1) / 2) + 1
   repeat
      sq = n * n
      until unique sq b = b
      n += 1
   .
   return n
.
for b = 2 to 14
   n = find b
   print "Base " & b & ": " & itoa n b & "² = " & itoa (n * n) b
.
