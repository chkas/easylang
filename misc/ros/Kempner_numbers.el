func[][] primfact x .
   p = 2
   while x <> 1
      if x mod p = 0
         r[][] &= [ p 0 ]
         while x mod p = 0
            r[$][2] += 1
            x = x div p
         .
      .
      p += 1
   .
   return r[][]
.
func valp n p .
   while n <> 0
      n = n div p
      s += n
   .
   return s
.
func k p e .
   if e <= p : return e * p
   t = e * (p - 1) div p * p
   while valp t p < e : t += p
   return t
.
func kempner n .
   if n = 1 : return 1
   f[][] = primfact n
   for i to len f[][]
      max = higher max k f[i][1] f[i][2]
   .
   return max
.
for i = 1 to 50
   write kempner i & " "
.
print ""
