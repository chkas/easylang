# AoC-17 - Day 23: Coprocessor Conflagration
# 
repeat
   s$ = input
   until s$ = ""
   m$[] &= s$
.
subr run
   pc = 1
   while 1 = 1
      if pc > len m$[]
         break 1
      .
      if part2 = 1
         if pc = 9
            b = r[2]
            # prime test
            for i = 2 to floor sqrt b
               if b mod i = 0
                  nprim += 1
                  break 1
               .
            .
            pc = 26
         .
      .
      i$ = substr m$[pc] 1 3
      r1 = (strcode substr m$[pc] 5 1) - 96
      h = strcode substr m$[pc] 7 1
      if h >= 97
         v = r[h - 96]
      else
         v = number substr m$[pc] 7 9
      .
      if i$ = "set"
         r[r1] = v
      elif i$ = "sub"
         r[r1] -= v
      elif i$ = "mul"
         nmul += 1
         r[r1] *= v
      elif i$ = "jgz"
         if r1 >= 0
            h = r[r1]
         else
            h = strcode substr m$[pc] 7 1
         .
         if h > 0
            pc += v - 1
         .
      elif i$ = "jnz"
         if r1 > 0
            h = r[r1]
         else
            h = strcode substr m$[pc] 7 1
         .
         if h <> 0
            pc += v - 1
         .
      else
         print "error"
      .
      pc += 1
   .
.
if len m$[] = 0
   print "input data needed"
else
   len r[] 26
   call run
   print nmul
   part2 = 1
   r[1] = 1
   call run
   print nprim
.
# 
# 
input_data


