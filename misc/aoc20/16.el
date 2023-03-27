# AoC-20 - Day 16: Ticket Translation
# 
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ ":"
   names$[] &= s$[1]
   s$[] = strsplit s$[2] " "
   h$[] = strsplit s$[2] "-"
   ami[] &= number h$[1]
   ama[] &= number h$[2]
   h$[] = strsplit s$[4] "-"
   bmi[] &= number h$[1]
   bma[] &= number h$[2]
.
s$ = input
myticket[] = number strsplit input ","
n = len myticket[]
s$ = input
s$ = input
repeat
   s$ = input
   until s$ = ""
   x[] = number strsplit s$ ","
   for i to n
      x = x[i]
      for j to n
         if x >= ami[j] and x <= ama[j] or x >= bmi[j] and x <= bma[j]
            break 1
         .
      .
      if j > n
         sum += x
         break 1
      .
   .
   if i > n
      tickets[][] &= [ ]
      for k to n
         tickets[len tickets[][]][] &= x[k]
      .
   .
.
print sum
# 
for c to n
   val[][] &= [ ]
   for cat to n
      for r to len tickets[][]
         x = tickets[r][c]
         if x < ami[cat] or x > ama[cat] and x < bmi[cat] or x > bma[cat]
            break 1
         .
      .
      if r > len tickets[][]
         val[c][] &= cat
      .
   .
.
len cnt[] n
len used[] n
i = 1
while i <= n and i >= 1
   h = cnt[i]
   oldp = 0
   if h > 0
      oldp = val[i][h]
   .
   repeat
      h += 1
      until h > len val[i][] or used[val[i][h]] = 0
   .
   if oldp > 0
      used[oldp] = 0
   .
   if h <= len val[i][]
      used[val[i][h]] = 1
      cnt[i] = h
      i += 1
   else
      cnt[i] = 0
      i -= 1
   .
.
# 
if i > n
   prod = 1
   for j to n
      s$[] = strsplit names$[val[j][cnt[j]]] " "
      if s$[1] = "departure"
         prod *= myticket[j]
      .
   .
   print prod
.
# 
input_data
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12


