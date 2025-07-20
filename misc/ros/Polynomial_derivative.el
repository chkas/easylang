func[] polderiv p[] .
   for i = 2 to len p[]
      r[] &= (i - 1) * p[i]
   .
   return r[]
.
func$ pol2str p[] .
   for i = len p[] downto 1
      if p[i] <> 0
         if res$ <> ""
            if p[i] < 0
               res$ &= " - "
            else
               res$ &= " + "
            .
         else
            if p[i] < 0 : res$ &= "-"
         .
         coeff = abs p[i]
         if i = 1
            res$ &= coeff
         else
            if coeff > 1 : res$ &= coeff
            res$ &= "x"
            if i > 2 : res$ &= "^" & i - 1
         .
      .
   .
   if res$ = "" : res$ = "0"
   return res$
.
proc test p[] .
   print pol2str p[] & " -> " & pol2str polderiv p[]
.
test [ 5 ]
test [ 4 -3 ]
test [ -1 6 5 ]
test [ -4 3 -2 1 ]
test [ 1 1 0 -1 -1 ]
