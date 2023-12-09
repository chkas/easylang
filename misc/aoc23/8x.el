# part2
name$[] = [ ]
global l[] r[] stop[] .
# 
func n2id n$ .
   for id to len name$[]
      if name$[id] = n$
         return id
      .
   .
   name$[] &= n$
   l[] &= 0
   r[] &= 0
   stop[] &= 0
   return id
.
# #
dir$[] = strchars input
s$ = input
# 
aaa = n2id "AAA"
zzz = n2id "ZZZ"
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ ", ()"
   id = n2id s$[1]
   if substr s$[1] 3 1 = "A"
      pos[] &= id
   elif substr s$[1] 3 1 = "Z"
      stop[id] = 1
   .
   l[id] = n2id s$[4]
   r[id] = n2id s$[6]
.
proc part1 . .
   pos = aaa
   repeat
      cnt += 1
      d = (d + 1) mod1 len dir$[]
      d$ = dir$[d]
      if d$ = "L"
         pos = l[pos]
      else
         pos = r[pos]
      .
      until pos = zzz
   .
   print cnt
.
part1
# 
func gcd a b .
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   return a
.
func lcm a b .
   return a / gcd a b * b
.
global xstop[] period[] .
proc part2 . .
   for pos in pos[]
      hpos[] = [ ]
      hdir[] = [ ]
      cnt = 0
      d = 0
      stop = -1
      repeat
         cnt += 1
         d = (d + 1) mod1 len dir$[]
         d$ = dir$[d]
         if d$ = "L"
            pos = l[pos]
         else
            pos = r[pos]
         .
         if stop[pos] = 1
            if stop <> -1
               print "double stop"
            .
            stop = cnt
         .
         for i to len hpos[]
            if hpos[i] = pos and hdir[i] = d
               break 1
            .
         .
         until i <= len hpos[]
         hpos[] &= pos
         hdir[] &= d
      .
      xstop[] &= stop
      period[] &= len hpos[] - i + 1
      print period[]
   .
   print xstop[]
   print period[]
   h = 1
   for i to len period[]
      h = lcm h period[i]
   .
   print h
.
part2
# 
proc runx . .
   for i to len pos[]
      cnt[] &= xstop[i]
      max = higher max cnt[i]
   .
   repeat
      done = 1
      for i to len pos[]
         if cnt[i] < max
            cnt[i] += period[i]
            max = higher max cnt[i]
            done = 0
         .
      .
      until done = 1
   .
   print max
.
#   
# 
input_data
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)

#
# #
# 
