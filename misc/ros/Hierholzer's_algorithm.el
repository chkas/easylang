proc prcircuit adja[][] .
   if len adja[][] = 0 : return
   curr = 1
   path[] &= curr
   while len path[] > 0
      if len adja[curr][] > 0
         path[] &= curr
         next = adja[curr][len adja[curr][]]
         len adja[curr][] -1
         curr = next
      else
         circ[] &= curr
         curr = path[$]
         len path[] -1
      .
   .
   for i = len circ[] downto 1
      write circ[i]
      if i <> 1 : write " => "
   .
   print ""
.
prcircuit [ [ 2 ] [ 3 ] [ 1 ] ]
prcircuit [ [ 2 7 ] [ 3 ] [ 1 4 ] [ 5 ] [ 3 6 ] [ 1 ] [ 5 ] ]
