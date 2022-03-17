# AoC-16 - Day 25: Clock Signal
# 
repeat
  s$ = input
  until s$ = ""
  prog$[] &= s$
.
# 
func run inp . ok .
  n1o = 1
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
    elif c$ = "jnz"
      if n1 <> 0
        pc += n2
        pc -= 1
      .
    elif c$ = "inc"
      r[r1] += 1
    elif c$ = "dec"
      r[r1] -= 1
    elif c$ = "out"
      if n1 = n1o
        ok = 0
        pc = 999
      else
        n1o = n1
        siglen += 1
        if siglen = 20
          ok = 1
          pc = 999
        .
      .
    else
      print "error " & c$
    .
    pc += 1
  .
.
for i range 10000
  call run i ok
  if ok = 1
    print i
    break 1
  .
.
# 
input_data
cpy a d
cpy 15 c
cpy 170 b
inc d
dec b
jnz b -2
dec c
jnz c -5
cpy d a
jnz 0 0
cpy a b
cpy 0 a
cpy 2 c
jnz b 2
jnz 1 6
dec b
dec c
jnz c -4
inc a
jnz 1 -7
cpy 2 b
jnz c 2
jnz 1 4
dec b
dec c
jnz 1 -4
jnz 0 0
out b
jnz a -19
jnz 1 -21


