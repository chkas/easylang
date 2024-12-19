# AoC-24 - Day 3: Mull It Over
#
global ind inp$[] num sum1 sum2 dont .
#
func is s$ .
   if ind + len s$ - 1 > len inp$[] : return 0
   s$[] = strchars s$
   for i to len s$
      if s$[i] <> inp$[ind + i - 1] : return 0
   .
   ind += len s$
   return 1
.
func isnum .
   if ind > len inp$[] : return 0
   h = number inp$[ind]
   if error = 1 : return 0
   ind += 1
   num = h
   for i to 2
      if ind > len inp$[] : return 1
      h = number inp$[ind]
      if error = 1 : return 1
      num = num * 10 + h
      ind += 1
   .
   return 1
.
proc doline . .
   repeat
      if is "mul(" = 1 and isnum = 1
         a = num
         if is "," = 1 and isnum = 1 and is ")" = 1
            sum1 += a * num
            if dont = 0 : sum2 += a * num
         .
      elif is "don't()" = 1
         dont = 1
      elif is "do()" = 1
         dont = 0
      else
         ind += 1
      .
      until ind > len inp$[]
   .
.
repeat
   s$ = input
   until s$ = ""
   inp$[] = strchars s$
   ind = 1
   doline
.
print sum1
print sum2
#
input_data
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))

