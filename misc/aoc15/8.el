# AoC-15 - Day 8: Matchsticks
# 
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
for s$ in inp$[]
   lit += len s$
   mem += len s$ - 2
   s$ = substr s$ 2 len s$ - 2
   s$[] = strchars s$
   i = 1
   while i <= len s$[]
      if s$[i] = "\\"
         if s$[i + 1] = "x"
            i += 4
            mem -= 3
         else
            i += 2
            mem -= 1
         .
      else
         i += 1
      .
   .
.
print lit - mem
# 
lit = 0
mem = 0
for s$ in inp$[]
   lit += len s$
   mem += len s$ + 2
   for c$ in strchars s$
      if c$ = "\"" or c$ = "\\"
         mem += 1
      .
   .
.
print mem - lit
#  
input_data
""
"abc"
"aaa\"aaa"
"\x27"

