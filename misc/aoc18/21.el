# AoC-18 - Day 21: Chronal Conversion
# 
for i range 9
  s$ = input
.
s$[] = strsplit s$ " "
init = number s$[1]
# 
r1 = 0
repeat
  r4 = r1
  if r1 div 65536 mod 2 = 0
    r4 += 65536
  .
  r1 = init
  repeat
    r5 = r4 mod 256
    r1 += r5
    r1 = r1 mod 16777216
    r1 *= 65899
    r1 = r1 mod 16777216
    until r4 < 256
    r5 = 0
    repeat
      r2 = r5 + 1
      r2 *= 256
      until r2 > r4
      r5 += 1
    .
    r4 = r5
  .
  for i range len tbl[]
    if tbl[i] = r1
      found = 1
    .
  .
  until found = 1
  tbl[] &= r1
.
print tbl[0]
print tbl[len tbl[] - 1]
# 
input_data
#ip 3
seti 123 0 1      r1 =    1111011
bani 1 456 1  l1: r1 &= 111001000 
eqri 1 72 1       if r1 = 72 
addr 1 3 3          jmp over
seti 0 0 3        jmp l1
seti 0 7 1        r1 = 0
bori 1 65536 4 l6: r4 = r1 | 65536 
seti 3798839 3 1  r1 = 3798839
bani 4 255 5  l8: r5 = r4 & 1(8)
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


