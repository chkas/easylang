# AoC-21 - Day 14: Extended Polymerization
#
# The string is irrelevant. Only the pairs
# count. And these multiply, as in the
# lanternfish example.
#
f$ = input
s$ = input
global pair$[] let$[] cnt[] .
proc get p$ . id .
   for id = 1 to len pair$[]
      if pair$[id] = p$ : return
   .
   print "error"
.
func code s$ i .
   return strcode substr s$ i 1 - 64
.
proc output . .
   len cntl[] 26
   for i = 1 to len cnt[]
      cntl[code pair$[i] 1] += cnt[i]
   .
   cntl[code f$ len f$] += 1
   min = 1 / 0
   for c in cntl[]
      max = higher c max
      if c > 0 and c < min : min = c
   .
   print max - min
.
repeat
   s$ = input
   until s$ = ""
   h$[] = strsplit s$ " "
   pair$[] &= h$[1]
   let$[] &= h$[3]
   cnt[] &= 0
.
for i = 1 to len f$ - 1
   h$ = substr f$ i 2
   get h$ id
   cnt[id] += 1
.
len cntn[] len cnt[]
#
for round = 1 to 40
   for i = 1 to len cnt[]
      p$ = substr pair$[i] 1 1 & let$[i]
      get p$ id
      cntn[id] += cnt[i]
      p$ = let$[i] & substr pair$[i] 2 1
      get p$ id
      cntn[id] += cnt[i]
      cnt[i] = 0
   .
   swap cntn[] cnt[]
   if round = 10 : output
.
output
#
input_data
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
