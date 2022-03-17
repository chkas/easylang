# AoC-19 - Day 22: Slam Shuffle
# 
global instr[] param[] .
# 
func parse . .
  repeat
    s$ = input
    until s$ = ""
    a$[] = strsplit s$ " "
    if a$[0] = "cut"
      instr[] &= 0
      param[] &= number a$[1]
    elif a$[1] = "into"
      instr[] &= 1
      param[] &= 0
    elif a$[1] = "with"
      instr[] &= 2
      param[] &= number a$[3]
    .
  .
.
call parse
# 
func part1 . .
  m = 10007
  pos = 2019
  for i range len instr[]
    if instr[i] = 0
      pos = (m + pos - param[i]) mod m
    elif instr[i] = 1
      pos = m - 1 - pos
    elif instr[i] = 2
      pos = (m + pos * param[i]) mod m
    else
      print "error"
    .
  .
  print pos
.
call part1
# 
# 
func multm a b m . r .
  r = 0
  while b > 0
    if b mod 2 = 1
      r = (r + a) mod m
    .
    b = b div 2
    a = (a + a) mod m
  .
.
# 
func powm a e m . r .
  r = 1
  while e > 0
    if e mod 2 = 1
      call multm r a m r
    .
    e = e div 2
    call multm a a m a
  .
.
# 
func part2 . .
  m = 119315717514047
  a = 1
  b = 0
  for i = len instr[] - 1 downto 0
    if instr[i] = 0
      b = (m + b + param[i]) mod m
    elif instr[i] = 1
      b += 1
      a = m - a
      b = m - b
    elif instr[i] = 2
      call powm param[i] m - 2 m p
      call multm a p m a
      call multm b p m b
    else
      print "error"
    .
  .
  times = 101741582076661
  call powm a times m powa
  call multm powa 2020 m h1
  call multm b powa + m - 1 m h
  call powm a - 1 m - 2 m h2
  call multm h h2 m h
  print (h1 + h) mod m
.
call part2
# 
input_data
deal into new stack
deal with increment 32
cut 5214
deal with increment 50
cut -7078
deal with increment 3
cut 5720
deal with increment 18
cut -6750
deal with increment 74
cut -6007
deal with increment 16
cut -3885
deal with increment 40
deal into new stack
cut -2142
deal with increment 25
deal into new stack
cut -1348
deal with increment 40
cut 3943
deal with increment 14
cut 7093
deal with increment 67
cut 1217
deal with increment 75
cut 597
deal with increment 60
cut -1078
deal with increment 68
cut -8345
deal with increment 25
cut 6856
deal into new stack
cut -4152
deal with increment 59
deal into new stack
cut -80
deal with increment 3
deal into new stack
deal with increment 44
cut 1498
deal with increment 18
cut -7149
deal with increment 58
deal into new stack
deal with increment 71
cut -323
deal into new stack
deal with increment 58
cut 1793
deal with increment 45
deal into new stack
cut 7187
deal with increment 48
cut 2664
deal into new stack
cut 8943
deal with increment 32
deal into new stack
deal with increment 62
cut -9436
deal with increment 67
deal into new stack
cut -1898
deal with increment 61
deal into new stack
deal with increment 14
cut 1287
deal with increment 8
cut 560
deal with increment 6
cut -2110
deal with increment 8
cut 9501
deal with increment 25
cut 4791
deal with increment 70
deal into new stack
deal with increment 5
cut 2320
deal with increment 47
cut -467
deal into new stack
deal with increment 19
cut -1920
deal with increment 16
cut -8920
deal with increment 65
cut -3986
deal with increment 3
cut -2690
deal with increment 35
cut -757
deal with increment 37
cut -1280
deal with increment 71
cut 3765
deal with increment 26
deal into new stack

