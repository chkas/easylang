# AoC-16 - Day 23: Safe Cracking
# 
repeat
   s$ = input
   until s$ = ""
   prog$[] &= s$
.
prog$[4] = "cpy b a"
prog$[5] = "mul d a"
prog$[6] = "jnz 1 5"
# 
proc run inp .
   for s$ in prog$[]
      s$[] = strsplit s$ " "
      r = strcode s$[2] - 96
      if r < 1
         r1[] &= 0
         n1[] &= number s$[2]
      else
         r1[] &= r
         n1[] &= 0
      .
      if len s$[] = 3
         r = strcode s$[3] - 96
         if r < 1
            r2[] &= r
            n2[] &= number s$[3]
         else
            r2[] &= r
            n2[] &= 0
         .
      else
         r2[] &= 0
         n2[] &= 0
      .
      p$[] &= s$[1]
   .
   len r[] 4
   r[1] = inp
   pc = 1
   while pc <= len p$[]
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
      elif c$ = "mul"
         if r2 > 0
            r[r2] = n1 * r[r2]
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
      elif c$ = "tgl"
         h = pc + n1
         if h >= 1 and h <= len p$[]
            s$ = p$[h]
            if s$ = "inc"
               s$ = "dec"
            elif s$ = "dec" or s$ = "tgl"
               s$ = "inc"
            elif s$ = "jnz"
               s$ = "cpy"
            else
               s$ = "jnz"
            .
            p$[h] = s$
         .
      else
         print "error"
      .
      pc += 1
   .
   print r[1]
.
run 7
run 12
# 
# ?? 
input_data
cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a

