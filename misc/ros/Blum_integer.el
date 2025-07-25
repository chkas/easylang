fastfunc semiprim n .
   d = 3
   while d * d <= n
      while n mod d = 0
         if c = 2 : return 0
         n /= d
         c += 1
      .
      d += 2
   .
   if c = 1 : return n
   return 0
.
print "The first 50 Blum integers:"
n = 3
numfmt 4 0
repeat
   prim1 = semiprim n
   if prim1 <> 0 and prim1 mod 4 = 3
      prim2 = n div prim1
      if prim2 <> prim1 and prim2 mod 4 = 3
         c += 1
         if c <= 50
            write n
            if c mod 10 = 0 : print ""
         .
      .
   .
   until c >= 26828
   n += 2
.
print ""
print "The 26828th Blum integer is: " & n

