# AoC-15 - Day 23: Opening the Turing Lock
# 
repeat
  s$ = input
  until s$ = ""
  p$[] &= s$
.
# 
len r[] 2
for part range 2
  pc = 0
  while pc < len p$[]
    s$[] = strsplit p$[pc] ", "
    c$ = s$[0]
    if c$ = "jmp"
      pc = pc + number s$[1] - 1
    else
      r = strcode s$[1] - 97
      if c$ = "inc"
        r[r] += 1
      elif c$ = "hlf"
        r[r] = r[r] div 2
      elif c$ = "tpl"
        r[r] *= 3
      elif c$ = "jie"
        if r[r] mod 2 = 0
          pc = pc + number s$[3] - 1
        .
      elif c$ = "jio"
        if r[r] = 1
          pc = pc + number s$[3] - 1
        .
      .
    .
    pc += 1
  .
  print r[1]
  r[] = [ 1 0 ]
.
# 
input_data
jio a, +16
inc a
inc a
tpl a
tpl a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
tpl a
inc a
jmp +23
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
tpl a
inc a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7


