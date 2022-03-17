# AoC-17 - Day 23: Coprocessor Conflagration
# 
repeat
  s$ = input
  until s$ = ""
  m$[] &= s$
.
subr run
  pc = 0
  while 1 = 1
    if pc >= len m$[]
      break 1
    .
    if part2 = 1
      if pc = 8
        b = r[1]
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
    i$ = substr m$[pc] 0 3
    r1 = (strcode substr m$[pc] 4 1) - 97
    h = strcode substr m$[pc] 6 1
    if h >= 97
      v = r[h - 97]
    else
      v = number substr m$[pc] 6 9
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
        h = strcode substr m$[pc] 6 1
      .
      if h > 0
        pc += v - 1
      .
    elif i$ = "jnz"
      if r1 >= 0
        h = r[r1]
      else
        h = strcode substr m$[pc] 6 1
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
len r[] 26
call run
print nmul
part2 = 1
r[0] = 1
call run
print nprim
# 
# 
input_data
set b 79
set c b
jnz a 2
jnz 1 5
mul b 100
sub b -100000
set c b
sub c -17000
set f 1
set d 2
set e 2
set g d
mul g e
sub g b
jnz g 2
set f 0
sub e -1
set g e
sub g b
jnz g -8
sub d -1
set g d
sub g b
jnz g -13
jnz f 2
sub h -1
set g b
sub g c
jnz g 2
jnz 1 3
sub b -17
jnz 1 -23


