# AoC-18 - Day 19: Go With The Flow
# 
global ipr cd[] .
memn$[] = [ "addr" "addi" "mulr" "muli" "banr" "bani" "borr" "bori" "setr" "seti" "gtir" "gtri" "gtrr" "eqir" "eqri" "eqrr" ]
func read . .
  ipr = number substr input 4 1
  repeat
    s$ = input
    until s$ = ""
    s$[] = strsplit s$ " "
    for i range 16
      if memn$[i] = s$[0]
        break 1
      .
    .
    cd[] &= i
    cd[] &= number s$[1]
    cd[] &= number s$[2]
    cd[] &= number s$[3]
  .
.
call read
# 
len r[] 6
#
func opf op a b c . .
  if op = 0
    r[c] = r[a] + r[b]
  elif op = 1
    r[c] = r[a] + b
  elif op = 2
    r[c] = r[a] * r[b]
  elif op = 3
    r[c] = r[a] * b
    # 
  elif op = 8
    r[c] = r[a]
  elif op = 9
    r[c] = a
    # 
  elif op = 10
    if a > r[b]
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 11
    if r[a] > b
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 12
    if r[a] > r[b]
      r[c] = 1
    else
      r[c] = 0
    .
    # 
  elif op = 13
    if a = r[b]
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 14
    if r[a] = b
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 15
    if r[a] = r[b]
      r[c] = 1
    else
      r[c] = 0
    .
    # 
  elif op = 4
    h = bitand r[a] r[b]
    r[c] = h
  elif op = 5
    h = bitand r[a] b
    r[c] = h
  elif op = 6
    h = bitor r[a] r[b]
    r[c] = h
  elif op = 7
    h = bitor r[a] b
    r[c] = h
  .
.
func part1 . .
  ip = 0
  repeat
    ind = ip * 4
    until ind >= len cd[]
    r[ipr] = ip
    call opf cd[ind] cd[ind + 1] cd[ind + 2] cd[ind + 3]
    ip = r[ipr]
    ip += 1
  .
  print r[0]
.
call part1
# 
func part2 . .
  r[] = [ 1 0 0 0 0 0 ]
  ip = 0
  repeat
    ind = ip * 4
    r[ipr] = ip
    call opf cd[ind] cd[ind + 1] cd[ind + 2] cd[ind + 3]
    ip = r[ipr]
    until ip = 0
    ip += 1
  .
  # 
  for i range 6
    if r[i] > n
      n = r[i]
    .
  .
  for i = 1 to sqrt n
    if n mod i = 0
      sum += i
      sum += n div i
    .
  .
  if sqrt n = floor sqrt n
    sum -= sqrt n
  .
  print sum
.
call part2
# 
input_data
#ip 5
addi 5 16 5    jmp l17
seti 1 0 3     r3 = 1    
seti 1 2 2 l2: r2 = 1
mulr 3 2 4 l3: r4 = r3 * r2 
eqrr 4 1 4     if r4 = r1
addr 4 5 5 l5: then jmp over
addi 5 1 5     jmp over
addr 3 0 0     r0 += r3  
addi 2 1 2     r2 += 1
gtrr 2 1 4     if r2 > r1
addr 5 4 5     then jmp over 
seti 2 7 5     jmp l3
addi 3 1 3     r3 += 1
gtrr 3 1 4     if r3 > r1
addr 4 5 5     then jmp over
seti 1 3 5     jmp l2
mulr 5 5 5     r5 *= r5
addi 1 2 1 l17:
mulr 1 1 1
mulr 5 1 1
muli 1 11 1
addi 4 7 4
mulr 4 5 4
addi 4 20 4
addr 1 4 1
addr 5 0 5
seti 0 4 5
setr 5 9 4
mulr 4 5 4
addr 5 4 4
mulr 5 4 4
muli 4 14 4
mulr 4 5 4
addr 1 4 1
seti 0 2 0
seti 0 5 5



