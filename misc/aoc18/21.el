# AoC-18 - Day 21: Chronal Conversion
# 
for i = 1 to 9
   s$ = input
.
s$[] = strsplit s$ " "
init = number s$[2]
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
   for i = 1 to len tbl[]
      if tbl[i] = r1
         found = 1
      .
   .
   until found = 1
   tbl[] &= r1
.
print tbl[1]
print tbl[len tbl[]]
#  
input_data
1
2
3
4
5
6
7
8
9 4


    r1 =    1111011
l1: r1 &= 111001000 
    if r1 = 72 
    jmp over
    jmp l1
    r1 = 0
l6: r4 = r1 | 65536 
    r1 = 3798839
l8: r5 = r4 & 1(8)
    r1 += r5
    r1 &= 1(24)
    r1 *= 65899
    r1 &= 1(24)
    if 256 > r4
      jmp over
    jmp over
    jmp l28
    r5 = 0
l18:r2 = r5 + 1
    r2 *= 256
    r2 > r4
      jmp over
    jmp over
    jmp l26
    r5 += 1
    jmp l18
l26: r4 = r5
    jmp l8
l28: r1 =? r0
      jmp over
    jmp l6


