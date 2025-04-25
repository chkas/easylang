# AoC-16 - Day 12: Leonardo's Monorail
# 
repeat
   s$ = input
   until s$ = ""
   prog$[] &= s$
.
# 
proc run inp .
   for s$ in prog$[]
      s$[] = strsplit s$ " "
      p$[] &= s$[1]
      r = strcode s$[2] - 96
      if r <= 0
         r1[] &= 0
         n1[] &= number s$[2]
      else
         r1[] &= r
         n1[] &= 0
      .
      if len s$[] = 3
         r = strcode s$[3] - 96
         if r <= 0
            r2[] &= 0
            n2[] &= number s$[3]
         else
            r2[] &= r
            n2[] &= 0
         .
      else
         r2[] &= 0
         n2[] &= 0
      .
   .
   len r[] 4
   r[3] = inp
   pc = 1
   while pc <  len p$[]
      c$ = p$[pc]
      r1 = r1[pc]
      r2 = r2[pc]
      n1 = n1[pc]
      if r1 > 0
         n1 = r[r1]
      .
      n2 = n2[pc]
      if r2 > 0
         n2 = r[r2]
      .
      if c$ = "cpy"
         if r2 > 0
            r[r2] = n1
         .
      elif c$ = "jnz"
         if n1 <> 0
            pc += n2
            pc -= 1
         .
      elif c$ = "inc"
         r[r1] += 1
      elif c$ = "dec"
         r[r1] -= 1
      else
         print "error"
      .
      pc += 1
   .
   print r[1]
.
run 0
run 1
# 
# 
input_data
cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a


