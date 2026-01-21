global dig[] res .
fastproc test .
   for i = 1 to len dig[] : n = n * 10 + dig[i]
   for i = 1 to len dig[]
      if n mod dig[i] <> 0 : return
   .
   res = n
.
len use[] 9
fastproc perm pos .
   if res > 0 : return
   i = 9
   while i >= 1
      dig[pos] = i
      if use[i] = 0
         use[i] = 1
         if pos = len dig[]
            test
         else
            perm pos + 1
         .
         use[i] = 0
      .
      i -= 1
   .
.
for ndig = 9 downto 1
   len dig[] ndig
   perm 1
.
print res
