# AoC-22 - Day 20: Grove Positioning System
# 
global v[] nxt[] n .
proc out . .
   ind = 1
   for k = 1 to n
      write v[ind] & " "
      ind = nxt[ind]
   .
   print ""
.
proc read . .
   repeat
      s$ = input
      until s$ = ""
      v[] &= number s$
      nxt[] &= len v[] + 1
   .
   n = len v[]
   nxt[n] = 1
.
proc init_part2 . .
   for i = 1 to len v[]
      v[i] *= 811589153
      nxt[i] = i + 1
   .
   nxt[n] = 1
.
read
# 
proc mix . .
   for k = 1 to n
      ind = k
      v = v[ind]
      for i = 1 to n
         if nxt[i] = ind
            prv = i
         .
      .
      nxt[prv] = nxt[ind]
      for i = 1 to v mod1 (n - 1)
         ind = nxt[ind]
      .
      nxt = nxt[ind]
      nxt[ind] = k
      nxt[k] = nxt
   .
.
proc nmix h . .
   for i = 1 to h
      mix
   .
.
proc find sk . r .
   sk = sk mod n
   for ind = 1 to n
      if v[ind] = 0
         break 1
      .
   .
   for i = 1 to sk
      ind = nxt[ind]
   .
   r = v[ind]
.
proc run nm . .
   nmix nm
   for h in [ 1000 2000 3000 ]
      find h r
      sum += r
   .
   print sum
.
run 1
init_part2
run 10
# 
input_data
1
2
-3
3
-2
0
4


