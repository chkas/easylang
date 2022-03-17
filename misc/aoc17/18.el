# AoC-17 - Day 18: Duet
# 
repeat
  s$ = input
  until s$ = ""
  m$[] &= s$
.
subr run
  while 1 = 1
    if pc >= len m$[]
      break 1
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
    elif i$ = "add"
      r[r1] += v
    elif i$ = "mul"
      r[r1] *= v
    elif i$ = "mod"
      r[r1] = r[r1] mod v
    elif i$ = "jgz"
      if r1 >= 0
        h = r[r1]
      else
        h = strcode substr m$[pc] 6 1
      .
      if h > 0
        pc += v - 1
      .
    elif i$ = "snd"
      if part2 = 1
        if id = 1
          sum += 1
        .
        q1[] &= r[r1]
      else
        snd = r[r1]
      .
    elif i$ = "rcv"
      if part2 = 1
        if len q[] = 0
          break 1
        .
        r[r1] = q[0]
        for i range len q[] - 1
          q[i] = q[i + 1]
        .
        len q[] len q[] - 1
      else
        if r[r1] <> 0
          break 1
        .
      .
    else
      print "error"
    .
    pc += 1
  .
.
len r[] 26
call run
print snd
# 
part2 = 1
pc = 0
id = 0
id1 = 1
r[] = [ ]
len r[] 26
len r1[] 26
r1[15] = 1
# 
while 1 = 1
  call run
  if len q1[] = 0 or pc >= len m$[]
    break 1
  .
  swap id id1
  swap pc pc1
  swap r[] r1[]
  swap q[] q1[]
.
print sum
# 
input_data
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 464
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19


