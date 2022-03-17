# AoC-16 - Day 23: Safe Cracking
# 
repeat
  s$ = input
  until s$ = ""
  prog$[] &= s$
.
prog$[3] = "cpy b a"
prog$[4] = "mul d a"
prog$[5] = "jnz 1 5"
# 
func run inp . .
  for s$ in prog$[]
    s$[] = strsplit s$ " "
    r = strcode s$[1] - 97
    if r < 0
      r1[] &= -1
      n1[] &= number s$[1]
    else
      r1[] &= r
      n1[] &= 0
    .
    if len s$[] = 3
      r = strcode s$[2] - 97
      if r < 0
        r2[] &= -1
        n2[] &= number s$[2]
      else
        r2[] &= r
        n2[] &= 0
      .
    else
      r2[] &= -1
      n2[] &= 0
    .
    p$[] &= s$[0]
  .
  len r[] 4
  r[0] = inp
  pc = 0
  repeat
    until pc >= len p$[]
    c$ = p$[pc]
    r1 = r1[pc]
    r2 = r2[pc]
    n1 = n1[pc]
    if r1 >= 0
      n1 = r[r1]
    .
    n2 = n2[pc]
    if r2 >= 0
      n2 = r[r2]
    .
    if c$ = "cpy"
      if r2 >= 0
        r[r2] = n1
      .
    elif c$ = "mul"
      if r2 >= 0
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
      if h >= 0 and h < len p$[]
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
  print r[0]
.
call run 7
call run 12
# 
input_data
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
inc a
dec c
jnz c -2
dec d
jnz d -5
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -16 c
jnz 1 c
cpy 75 c
jnz 85 d
inc a
inc d
jnz d -2
inc c
jnz c -5

