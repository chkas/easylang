# AoC-16 - Day 9: Explosives in Cyberspace
# 
inp$ = input
# 
is_part2 = 0
proc getlen s$ . lng .
   lng = 0
   i = 1
   while i <= len s$
      c$ = substr s$ i 1
      if c$ = "("
         h$ = ""
         repeat
            i += 1
            c$ = substr s$ i 1
            until c$ = ")"
            h$ &= c$
         .
         i += 1
         h[] = number strsplit h$ "x"
         h$ = ""
         for j to h[1]
            h$ &= substr s$ i 1
            i += 1
         .
         if is_part2 = 1
            call getlen h$ l
         else
            l = len h$
         .
         lng += l * h[2]
      else
         lng += 1
         i += 1
      .
   .
.
# 
call getlen inp$ l
print l
is_part2 = 1
call getlen inp$ l
print l
# 
input_data
(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN


