func$ midThreeDigits num .
   trueNumber$ = abs num
   if (len trueNumber$ < 3) or (len trueNumber$ mod 2 = 0)
      r$ = "error"
   else
      r$ = substr trueNumber$ ((len trueNumber$ - 3) / 2 + 1) 3
   .
   return r$
.
numbers[] = [ 123 12345 1234567 987654321 10001 -10001 -123 -100 100 -12345 1 2 -1 -10 2002 -2002 0 ]
for i in numbers[]
   print midThreeDigits i
.
