func$[] convergents x maxcnt .
   eps = 1e-9
   for i to maxcnt
      ipart = floor x
      fpart = x - ipart
      comps[] &= ipart
      if abs fpart < eps : break 1
      x = 1 / fpart
   .
   numa = 0
   denoma = 1
   numb = 1
   denomb = 0
   for comp in comps[]
      swap numa numb
      swap denoma denomb
      numb += comp * numa
      denomb += comp * denoma
      if denomb = 1
         r$[] &= numb
      else
         r$[] &= numb & "/" & denomb
      .
   .
   return r$[]
.
proc test s$ n .
   print s$ & " = " & strjoin convergents n 8 " "
.
test "415/93" 415 / 93
test "649/200" 649 / 200
test "sqrt(2)" sqrt 2
test "sqrt(5)" sqrt 5
test "golden ratio" (sqrt 5 + 1) / 2
