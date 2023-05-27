# AoC-19 - Day 22: Slam Shuffle
# 
global instr[] param[] .
# 
proc parse . .
   repeat
      s$ = input
      until s$ = ""
      a$[] = strsplit s$ " "
      if a$[1] = "cut"
         instr[] &= 0
         param[] &= number a$[2]
      elif a$[2] = "into"
         instr[] &= 1
         param[] &= 0
      elif a$[2] = "with"
         instr[] &= 2
         param[] &= number a$[4]
      .
   .
.
call parse
# 
proc part1 . .
   m = 10007
   pos = 2019
   for i = 1 to len instr[]
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
proc multm a b m . r .
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
proc powm a e m . r .
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
proc part2 . .
   m = 119315717514047
   a = 1
   b = 0
   for i = len instr[] downto 1
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
cut -2
deal with increment 7
cut 8
cut -4
deal with increment 7
cut 3
deal with increment 9
deal with increment 3
cut -1

