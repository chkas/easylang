# AoC-16 - Day 12: Leonardo's Monorail
# 
repeat
  s$ = input
  until s$ = ""
  prog$[] &= s$
.
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
  r[2] = inp
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
  print r[0]
.
call run 0
call run 1
# 
# 
input_data
cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 18 c
cpy 11 d
inc a
dec d
jnz d -2
dec c
jnz c -5



