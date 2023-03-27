# AoC-22 - Day 12: Hill Climbing Algorithm
# 
# reverse: from end to start(s) 
# 
s$ = input
nc = len s$ + 1
# border
for i = 1 to nc
   m[] &= -1
.
while s$ <> ""
   m[] &= -1
   for c$ in strchars s$
      if c$ = "S"
         c$ = "a"
         start = len m[] + 1
      elif c$ = "E"
         c$ = "z"
         ende = len m[] + 1
      .
      m[] &= strcode c$ - strcode "a" + 1
   .
   s$ = input
.
for i = 1 to nc
   m[] &= -1
.
len seen[] len m[]
todo[] = [ ende ]
seen[ende] = 1
cnt = 0
while len todo[] > 0
   todon[] = [ ]
   for p in todo[]
      if m[p] = 1 and min = 0
         min = cnt
      .
      if p = start
         print cnt
         break 2
      .
      for pn in [ p - nc p + 1 p + nc p - 1 ]
         if m[pn] >= m[p] - 1 and seen[pn] = 0
            todon[] &= pn
            seen[pn] = 1
         .
      .
   .
   cnt += 1
   swap todo[] todon[]
.
print min
# 
input_data
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi

