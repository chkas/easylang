# AoC-17 - Day 8: I Heard You Like Registers
#
global name$[] v[] .
proc getid n$ &id .
   for id to len name$[]
      if name$[id] = n$
         break 2
      .
   .
   name$[] &= n$
   v[] &= 0
.
repeat
   inp$[] = strsplit input " "
   until len inp$[] < 7
   getid inp$[1] id
   v = number inp$[3]
   if inp$[2] = "dec"
      v = -v
   .
   getid inp$[5] id2
   op$ = inp$[6]
   v2 = number inp$[7]
   inc = 0
   if op$ = ">" and v[id2] > v2
      inc = v
   elif op$ = "<" and v[id2] < v2
      inc = v
   elif op$ = ">=" and v[id2] >= v2
      inc = v
   elif op$ = "<=" and v[id2] <= v2
      inc = v
   elif op$ = "==" and v[id2] = v2
      inc = v
   elif op$ = "!=" and v[id2] <> v2
      inc = v
   .
   v[id] += inc
   for v in v[]
      max2 = higher v max2
   .
.
for v in v[]
   max = higher v max
.
print max
print max2
#
input_data
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10


