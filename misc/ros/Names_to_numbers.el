names$[] = [ "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety" "hundred" "thousand" "million" "billion" "trillion" "quadrillion" ]
values[] = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 30 40 50 60 70 80 90 100 1000 1000000 1000000000 1e12 1e15 ]
zeros$[] = [ "zero" "nought" "nil" "none" "nothing" ]
#
func nametonum text$ .
   sgn = 1
   if substr text$ 1 6 = "minus "
      sgn = -1
      text$ = substr text$ 7 99999
   .
   if substr text$ 1 2 = "a "
      text$ = "one " & substr text$ 3 99999
   .
   words$[] = strtok text$ ",- "
   if len words$[] = 1 : for s$ in zeros$[]
      if s$ = words$[1] : return 0
   .
   multiplier = 1
   for i = len words$[] downto 1 : if words$[i] <> "and"
      num = 0
      for j to len names$[] : if words$[i] = names$[j]
         num = values[j]
         break 1
      .
      if num = 0
         print "'" & words$[i] & "' is not a valid number"
         return 0
      .
      if num = lastnum
         print "'" & text$ & "' is not a well formed numeric string"
         return 0
      .
      if num >= 1000
         if lastnum >= 100
            print "'" & text$ & "' is not a well formed numeric string"
            return 0
         .
         multiplier = num
         if i = 1 : sum += multiplier
      elif num >= 100
         multiplier *= 100
         if i = 1 : sum += multiplier
      elif num >= 20
         if lastnum >= 10 and lastnum <= 90
            print "'" & text$ & "' is not a well formed numeric string"
            return 0
         .
         sum += num * multiplier
      else
         if lastnum >= 1 and lastnum <= 90
            print "'" & text$ & "' is not a well formed numeric string"
            return 0
         .
         sum += num * multiplier
      .
      lastnum = num
   .
   return sgn * sum
.
tests$[] = [ "none" "one" "twenty-five" "minus one hundred and seventeen" "hundred and fifty-six" "minus two thousand two" "nine thousand seven hundred one" "minus six hundred and twenty six thousand eight hundred and fourteen" "four million seven hundred thousand three hundred and eighty-six" "fifty-one billion two hundred and fifty-two million seventeen thousand one hundred eighty-four" "two hundred and one billion twenty-one million two thousand and one" "minus three hundred trillion nine million four hundred and one thousand and thirty-one" "one quadrillion and one" "minus nine quadrillion one hundred thirty-seven" ]
for s$ in tests$[]
   print s$ & " => " & nametonum s$
.
