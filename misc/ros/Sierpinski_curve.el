proc lsysexp level &axiom$ &rules$[] .
   for l to level
      an$ = ""
      for c$ in strchars axiom$
         for i = 1 step 2 to len rules$[]
            if rules$[i] = c$
               c$ = rules$[i + 1]
               break 1
            .
         .
         an$ &= c$
      .
      swap axiom$ an$
   .
.
proc lsysdraw axiom$ x y ang lng .
   glinewidth 0.3
   for c$ in strchars axiom$
      if c$ = "F" or c$ = "G"
         px = x
         py = y
         x += cos dir * lng
         y += sin dir * lng
         gline px py x y
      elif c$ = "-"
         dir -= ang
      elif c$ = "+"
         dir += ang
      .
   .
.
axiom$ = "F--xF--F--xF"
rules$[] = [ "x" "xF+G+xF--F--xF+G+x" ]
lsysexp 5 axiom$ rules$[]
lsysdraw axiom$ 50 98 45 0.9
