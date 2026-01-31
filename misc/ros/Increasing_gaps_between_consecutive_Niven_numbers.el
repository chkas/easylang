fastfunc divisible n d .
   if d mod 2 = 0 and n mod 2 = 1 : return 0
   if n mod d = 0 : return 1
.
global sum .
fastproc digsum n .
   sum += 1
   while n > 0 and n mod 10 = 0
      sum -= 9
      n = n div 10
   .
.
global prev gap gap_index niven_ind niven .
prevn = 1
fastfunc getnext .
   repeat
      niven += 1
      digsum niven
      if divisible niven sum = 1
         prev = prevn
         prevn = niven
         niven_ind += 1
         if niven > prev + gap
            gap_index += 1
            gap = niven - prev
            return 1
         .
      .
      until niven >= 10000000
   .
   return 0
.
numfmt 8 0
print " Gap index    Gap  Niven index  Niven number"
print " ---------    ---  -----------  ------------"
while getnext = 1
   print gap_index & gap & " " & niven_ind - 1 & "    " & prev
.
