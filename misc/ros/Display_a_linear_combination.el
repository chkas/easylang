func$ lincomb scalars[] .
   for m to len scalars[]
      scalar = scalars[m]
      m$ = "(" & m & ")"
      if scalar <> 0
         if scalar > 0
            if str$ <> "" : str$ &= "+"
         else
            str$ &= "-"
         .
         scalar = abs scalar
         if scalar = 1
            str$ &= "e" & m$
         else
            str$ &= scalar & "*e" & m$
         .
      .
   .
   if str$ = "" : str$ = 0
   return str$
.
scalars[][] = [ [ 1 2 3 ] [ 0 1 2 3 ] [ 1 0 3 4 ] [ 1 2 0 ] [ 0 0 0 ] [ 0 ] [ 1 1 1 ] [ -1 -1 -1 ] [ -1 -2 0 -3 ] [ -1 ] ]
for i to len scalars[][]
   print lincomb scalars[i][]
.
