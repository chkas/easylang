# AoC-23 - Day 1: Trebuchet?!
# 
part = 2
# 
d$[] = [ "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" ]
repeat
   s$ = input
   until s$ = ""
   digs[] = [ ]
   for i to len s$
      h = number substr s$ i 1
      if error = 0
         digs[] &= h
      elif part = 2
         for h to 9
            if substr s$ i len d$[h] = d$[h]
               digs[] &= h
            .
         .
      .
   .
   s += digs[1] * 10 + digs[len digs[]]
.
print s
# 
input_data
two1nine
eightwo23three
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen