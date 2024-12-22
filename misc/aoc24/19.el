# AoC-24 - Day 19: Linen Layout
#
global hashw$[] hashw[] .
proc hset s$ v . .
   hashw$[] &= s$
   hashw[] &= v
.
func hget s$ .
   for i to len hashw$[]
      if hashw$[i] = s$ : return hashw[i]
   .
   return -1
.
proc hclear . .
   hashw$[] = [ ]
   hashw[] = [ ]
.
#
tw$[] = strsplit input ", "
s$ = input
#
func reduce s$ .
   h = hget s$
   if h <> -1 : return h
   if s$ = "" : return 1
   for tw$ in tw$[]
      l = len tw$
      if substr s$ 1 l = tw$
         s += reduce substr s$ (l + 1) 999
      .
   .
   hset s$ s
   return s
.
repeat
   s$ = input
   until s$ = ""
   hclear
   h = reduce s$
   sum1 += if h > 0
   sum2 += h
.
print sum1
print sum2
#
input_data
r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb
