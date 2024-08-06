# AoC-18 - Day 20: A Regular Map
#
sysconf topleft
visual = 1
#
inp$[] = strchars input
ind = 2
global c$ .
proc nextc . .
   c$ = inp$[ind]
   ind += 1
.
len f[] 1000 * 1000
arrbase f[] 0
#
procdecl parse . pos[] .
#
proc parse_opt . pos[] .
   while 1 = 1
      d = 0
      if c$ = "W"
         d = -1
      elif c$ = "N"
         d = -1000
      elif c$ = "E"
         d = 1
      elif c$ = "S"
         d = 1000
      elif c$ = "("
         nextc
         parse pos[]
         if c$ <> ")"
            print "')' expected"
         .
      else
         break 1
      .
      if d <> 0
         for i = 1 to len pos[]
            f[pos[i] + d] = 1
            pos[i] += 2 * d
            f[pos[i]] = 1
         .
      .
      nextc
   .
.
#
proc parse . pos0[] .
   pos[] = pos0[]
   parse_opt pos[]
   pos_res[] = pos[]
   while c$ = "|"
      nextc
      pos[] = pos0[]
      parse_opt pos[]
      for i = 1 to len pos[]
         for j = 1 to len pos_res[]
            if pos[i] = pos_res[j]
               break 1
            .
         .
         if j > len pos_res[]
            pos_res[] &= pos[i]
         .
      .
   .
   pos0[] = pos_res[]
.
#
min = 0
max = 0
proc show solve . .
   if visual = 0
      break 1
   .
   x0 = min mod 1000 - 1
   y0 = min div 1000 - 1
   x1 = max mod 1000 + 2
   y1 = max div 1000 + 2
   dx = x1 - x0
   dy = y1 - y0
   sz = 100 / dx
   if solve = 0
      background 000
      clear
      color 555
      for y range0 dy
         for x range0 dx
            if f[x0 + x + 1000 * (y + y0)] = 1
               move x * sz y * sz
               rect sz * 1.02 sz * 1.02
            .
         .
      .
   else
      color 050
      for y range0 dy
         for x range0 dx
            if f[x0 + x + 1000 * (y + y0)] = 2
               f[x0 + x + 1000 * (y + y0)] = 3
               move x * sz y * sz
               rect sz * 1.02 sz * 1.02
            .
         .
      .
   .
   sleep 0
.
proc build . .
   nextc
   pos[] &= 500500
   f[pos[1]] = 1
   parse_opt pos[]
   for i range0 len f[]
      if f[i] = 1
         if min = 0
            min = i
         .
         max = i
      .
   .
   show 0
.
build
#
dir[] = [ -1 -1000 1 1000 ]
todon[] = [ 500500 ]
while len todon[] > 0
   doors += 1
   len todo[] 0
   swap todo[] todon[]
   for it = 1 to len todo[]
      pos = todo[it]
      for i = 1 to 4
         if f[pos + dir[i]] = 1
            p = pos + 2 * dir[i]
            if f[p] = 1
               f[pos + dir[i]] = 2
               f[p] = 2
               todon[] &= p
               if doors >= 1000
                  rooms += 1
               .
            .
         .
      .
   .
   show 1
.
print doors - 1
print rooms
#
input_data
^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$



