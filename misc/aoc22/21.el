# AoC-22 - Day 21: Monkey Math
#
global name$[] o[] a[] b[] .
proc name2id n$ &id .
   for id = 1 to len name$[]
      if name$[id] = n$ : return
   .
   name$[] &= n$
   o[] &= 0
   a[] &= 0
   b[] &= 0
.
repeat
   s$ = input
   until s$ = ""
   h$ = substr s$ 1 4
   name2id h$ id
   if h$ = "root"
      root = id
   elif h$ = "humn"
      humn = id
   .
   if len s$ = 17
      h$ = substr s$ 7 4
      name2id h$ h
      a[id] = h
      h$ = substr s$ 14 4
      name2id h$ h
      b[id] = h
      h$ = substr s$ 12 1
      if h$ = "+"
         o[id] = 1
      elif h$ = "-"
         o[id] = 2
      elif h$ = "*"
         o[id] = 3
      else
         o[id] = 4
      .
   else
      o[id] = 0
      a[id] = number substr s$ 7 9
   .
.
proc solv id &v .
   if o[id] = 0
      v = a[id]
      break 1
   .
   solv a[id] a
   solv b[id] b
   if o[id] = 1
      v = a + b
   elif o[id] = 2
      v = a - b
   elif o[id] = 3
      v = a * b
   else
      v = a / b
   .
.
solv root v
print v
o[root] = 2
#
low = -10000000000000
high = 10000000000000
a[humn] = low
solv root v
if v > 0 : swap low high
repeat
   in = low + (high - low) div 2
   a[humn] = in
   solv root v
   until v = 0
   if v < 0
      low = in
   else
      high = in
   .
.
print in
#
input_data
root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32

