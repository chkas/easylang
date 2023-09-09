# AoC-15 - Day 23: Opening the Turing Lock
# 
repeat
   s$ = input
   until s$ = ""
   p$[] &= s$
.
# 
proc run r[] . .
   pc = 1
   while pc <= len p$[]
      s$[] = strsplit p$[pc] ", "
      c$ = s$[1]
      if c$ = "jmp"
         pc = pc + number s$[2] - 1
      else
         r = strcode s$[2] - 96
         if c$ = "inc"
            r[r] += 1
         elif c$ = "hlf"
            r[r] = r[r] div 2
         elif c$ = "tpl"
            r[r] *= 3
         elif c$ = "jie"
            if r[r] mod 2 = 0
               pc = pc + number s$[4] - 1
            .
         elif c$ = "jio"
            if r[r] = 1
               pc = pc + number s$[4] - 1
            .
         .
      .
      pc += 1
   .
   print r[2]
.
run [ 0 0 ]
run [ 1 0 ]
# 
input_data
inc b
jio b, +2
tpl b
inc b
jio a, +2
tpl b


