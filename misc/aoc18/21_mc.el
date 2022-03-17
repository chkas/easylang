# AoC-18 - Day 21: Chronal Conversion
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
func bor a b . c .
  c = 0
  bit = 1
  while a > 0 or b > 0
    ar = a mod 2
    br = b mod 2
    if ar = 1 or br = 1
      c += bit
    .
    bit *= 2
    a = a div 2
    b = b div 2
  .
.
func band a b . c .
  c = 0
  bit = 1
  while a > 0 and b > 0
    ar = a mod 2
    br = b mod 2
    if ar = 1 and br = 1
      c += bit
    .
    bit *= 2
    a = a div 2
    b = b div 2
  .
.
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
  elif op = 4
    call band r[a] r[b] h
    r[c] = h
  elif op = 5
    call band r[a] b h
    r[c] = h
  elif op = 6
    call bor r[a] r[b] h
    r[c] = h
  elif op = 7
    call bor r[a] b h
    r[c] = h
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
  .
.
func run r0 . .
  ip = 0
  cnt = 0
  for i range len r[]
    r[i] = 0
  .
  r[0] = r0
  repeat
    ind = ip * 4
    #    until ind >= len cd[]
    until 1 = 2
    r[ipr] = ip
    if ip = 28
      cnt += 1
      if cnt mod 100 = 0
		pr cnt
      .
#      if r[1] = min
#          pr oldr1
#          pr cnt
#          break 2
#      .
      if cnt = 1
         min = r[1]
         pr min
      .
#      oldr1 = r[1]
      for i range len tbl[]
        if tbl[i] = r[1]
          pr i
          pr len tbl[]
          pr tbl[len tbl[] - 1]
          break 2
        .
      .
      tbl[] &= r[1]
#      pr len tbl[]
    .
    call opf cd[ind] cd[ind + 1] cd[ind + 2] cd[ind + 3]
    ip = r[ipr]
    ip += 1
    #    pr r[]
  .
  if ind < len cd[]
    cnt = -1
  .
.
# 1848 low
call run -1
# 
input_data
#ip 3
seti 123 0 1      r1 =    1111011
bani 1 456 1  l1: r1 &= 111001000 
eqri 1 72 1       if r1 = 72 
addr 1 3 3          jmp over
seti 0 0 3        jmp l1
seti 0 7 1        r1 = 0
bori 1 65536 4 l6: r4 = r1 | 10000000000000000 
seti 3798839 3 1  r1 = 3798839
bani 4 255 5  l8: r5 = r4 & 11111111
addr 1 5 1        r1 += r5
bani 1 16777215 1 r1 &= 1(24)
muli 1 65899 1    r1 *= 65899
bani 1 16777215 1 r1 &= 1(24)
gtir 256 4 5      if 256 > r4
addr 5 3 3          jmp over
addi 3 1 3        jmp over
seti 27 6 3       jmp l28
seti 0 2 5        r5 = 0
addi 5 1 2    l18:r2 = r5 + 1
muli 2 256 2      r2 *= 256
gtrr 2 4 2        r2 > r4
addr 2 3 3          jmp over
addi 3 1 3        jmp over
seti 25 3 3       jmp l26
addi 5 1 5        r5 += 1
seti 17 1 3       jmp l18
setr 5 6 4   l26: r4 = r5
seti 7 8 3        jmp l8
eqrr 1 0 5   l28: r1 =? r0
addr 5 3 3          jmp over
seti 5 6 3        jmp l6


