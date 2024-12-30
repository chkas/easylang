# AoC-24 - Day 24: : Crossed Wires
#
global na$[] op[][] v[] mapz[] nin nop .
func n2id n$ .
   for id to len na$[] : if na$[id] = n$ : return id
   na$[] &= n$
   return id
.
proc sort . d$[] .
   for i = len d$[] - 1 downto 1
      for j = 1 to i
         if strcmp d$[j] d$[j + 1] > 0 : swap d$[j] d$[j + 1]
      .
   .
.
proc init . .
   repeat
      s$ = input
      until s$ = ""
      v[] &= number substr s$ 6 2
      s$ = n2id substr s$ 1 3
   .
   nin = len v[] div 2
   repeat
      s$ = input
      until s$ = ""
      h$ = substr s$ 5 3
      h = 1
      if h$ = "AND"
         op = 1
      elif h$ = "OR "
         op = 2
         h = 0
      else
         op = 3
      .
      op[][] &= [ ]
      op[$][] &= n2id substr s$ 1 3
      op[$][] &= n2id substr s$ (8 + h) 3
      op[$][] &= n2id substr s$ (15 + h) 3
      if op[$][1] > op[$][2] : swap op[$][1] op[$][2]
      op[$][] &= op
   .
   n = len na$[]
   nop = len op[][]
   len v[] n
   for i to n
      if substr na$[i] 1 1 = "z"
         id = number substr na$[i] 2 3 + 1
         if id > len mapz[] : len mapz[] id
         mapz[id] = i
      .
   .
.
init
#
func run .
   for cnt to nin
      vn[] = v[]
      for i to nop
         op[] = op[i][]
         if op[4] = 1
            vn[op[3]] = if v[op[1]] = 1 and v[op[2]] = 1
         elif op[4] = 2
            vn[op[3]] = if v[op[1]] = 1 or v[op[2]] = 1
         else
            vn[op[3]] = if v[op[1]] <> v[op[2]]
         .
      .
      swap v[] vn[]
   .
   for i = len mapz[] downto 1 : r = r * 2 + v[mapz[i]]
   return r
.
proc part1 . .
   print run
.
part1
#
global fixlist$[] .
proc fixit op out . .
   for i to nop : if op[i][3] = out : break 1
   fixlist$[] &= na$[op[op][3]]
   fixlist$[] &= na$[op[i][3]]
   swap op[op][3] op[i][3]
.
func conop a b op .
   if a > b : swap a b
   for i to nop
      if op[i][1] = a and op[i][2] = b and op[i][4] = op : return i
   .
.
func conop1 a op .
   for i to nop
      if (op[i][1] = a or op[i][2] = a) and op[i][4] = op : return i
   .
.
proc checkit in . carry .
   xor1 = conop in (in + nin) 3
   if xor1 = 0 : print "** error xor1 **"
   xor2 = conop op[xor1][3] carry 3
   if xor2 = 0
      xor2 = conop1 carry 3
      h = op[xor2][1]
      if h = carry
         h = op[xor2][2]
      .
      fixit xor1 h
      checkit in carry
      return
   .
   if op[xor2][3] <> mapz[in]
      fixit xor2 mapz[in]
      checkit in carry
      return
   .
   and1 = conop in (in + nin) 1
   and2 = conop op[xor1][3] carry 1
   if and2 = 0 or and1 = 0 : print "** error and2, and1 **"
   or1 = conop op[and1][3] op[and2][3] 2
   if or1 = 0 : print "** error or1 **"
   carry = op[or1][3]
.
proc testfix . .
   for i = nin downto 1
      a = a * 2 + v[i]
      b = b * 2 + v[i + nin]
   .
   r = run
   if a + b <> r : print "fix failed"
.
proc part2 . .
   and1 = conop 1 (1 + nin) 1
   carry = op[and1][3]
   for in = 2 to nin : checkit in carry
   sort fixlist$[]
   print strjoin fixlist$[] ","
   testfix
.
part2
#
input_data
x00: 1
x01: 1
x02: 0
y00: 0
y01: 1
y02: 0

x00 XOR y00 -> z00
x00 AND y00 -> c01
x01 XOR y01 -> xo1
c01 XOR xo1 -> z02
x01 AND y01 -> an1
c01 AND xo1 -> am1
an1 OR am1 -> c02
x02 XOR y02 -> xo2
c02 XOR xo2 -> z01
x02 AND y02 -> an2
c02 AND xo2 -> am2
an2 OR am2 -> c03

