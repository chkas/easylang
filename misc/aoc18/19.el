# AoC-18 - Day 19: Go With The Flow
# 
global ipr cd[] .
# 
memn$[] = [ "addr" "addi" "mulr" "muli" "banr" "bani" "borr" "bori" "setr" "seti" "gtir" "gtri" "gtrr" "eqir" "eqri" "eqrr" ]
proc read . .
   ipr = number substr input 5 1
   repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ " "
      for i = 1 to 16
         if memn$[i] = s$[1]
            break 1
         .
      .
      cd[] &= i - 1
      cd[] &= number s$[2]
      cd[] &= number s$[3]
      cd[] &= number s$[4]
   .
.
call read
# 
len r[] 6
arrbase r[] 0
# 
proc opf op a b c . .
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
proc part1 . .
   ip = 0
   repeat
      ind = ip * 4 + 1
      until ind > len cd[]
      r[ipr] = ip
      call opf cd[ind] cd[ind + 1] cd[ind + 2] cd[ind + 3]
      ip = r[ipr]
      ip += 1
   .
   print r[0]
.
call part1
# 
proc part2 . .
   r[] = [ 1 0 0 0 0 0 ]
   arrbase r[] 0
   ip = 0
   repeat
      ind = ip * 4 + 1
      r[ipr] = ip
      call opf cd[ind] cd[ind + 1] cd[ind + 2] cd[ind + 3]
      ip = r[ipr]
      until ip = 0
      ip += 1
   .
   # 
   for i range0 6
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
#ip 0
seti 5 0 1
seti 6 0 2
addi 0 1 0
addr 1 2 3
setr 1 0 0
seti 8 0 4
seti 9 0 5

    jmp l17
     r3 = 1    
l2: r2 = 1
l3: r4 = r3 * r2 
    if r4 = r1
l5: then jmp over
    jmp over
    r0 += r3  
    r2 += 1
    if r2 > r1
    then jmp over 
    jmp l3
    r3 += 1
    if r3 > r1
    then jmp over
    jmp l2
    r5 *= r5
l17:



