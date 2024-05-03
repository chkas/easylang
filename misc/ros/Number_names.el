small$[] = [ "zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen" ]
tens$[] = [ "" "" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety" ]
illions$[] = [ "" " thousand" " million" " billion" " trillion" " quadrillion" " quintillion" ]
func$ say n .
   if n < 0
      t$ = "negative "
      n = -n
   .
   if n < 20
      t$ &= small$[n + 1]
   elif n < 100
      t$ &= tens$[n div 10 + 1]
      s = n mod 10
      if s > 0
         t$ &= "-" & small$[s + 1]
      .
   elif n < 1000
      t$ &= small$[n div 100 + 1] & " hundred"
      s = n mod 100
      if s > 0
         t$ &= " " & say s
      .
   else
      i = 1
      while n > 0
         p = n mod 1000
         n = n div 1000
         if p > 0
            ix$ = say p & illions$[i]
            if sx$ <> ""
               ix$ &= " " & sx$
            .
            sx$ = ix$
         .
         i += 1
      .
      t$ &= sx$
   .
   return t$
.
for n in [ 12 1048576 9e18 -2 0 ]
   print say n
.
