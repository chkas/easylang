# AoC-23 - Day 8: Haunted Wasteland
#
name$[] = [ ]
global l[] r[] pos[] stop[] dir$[] aaa zzz .
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
proc read . .
   dir$[] = strchars input
   s$ = input
   aaa = n2id "AAA"
   zzz = n2id "ZZZ"
   repeat
      s$ = input
      until s$ = ""
      s$[] = strtok s$ ", ()"
      id = n2id s$[1]
      if substr s$[1] 3 1 = "A"
         pos[] &= id
      elif substr s$[1] 3 1 = "Z"
         stop[id] = 1
      .
      l[id] = n2id s$[3]
      r[id] = n2id s$[4]
   .
.
read
#
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
proc gperiod pos . period stopcnt .
   len seen[] len dir$[] * len l[]
   stopcnt = 0
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
         if stopcnt <> 0
            print "double stop"
         .
         stopcnt = cnt
      .
      h = (pos - 1) * len dir$[] + d
      until seen[h] > 0
      seen[h] = cnt
   .
   period = cnt - seen[h]
.
#
func getstop cnt1 per1 cnt2 per2 .
   repeat
      if cnt1 < cnt2
         cnt1 += per1
      .
      cnt2 += (cnt1 - cnt2) div per2 * per2
      if cnt2 < cnt1
         cnt2 += per2
      .
      until cnt1 = cnt2
   .
   return cnt1
.
proc part2 . .
   gperiod pos[1] period stopcnt
   for k = 2 to len pos[]
      gperiod pos[k] per stop
      stopcnt = getstop stopcnt period stop per
      period = lcm period per
   .
   print stopcnt
.
part2
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
AAA = (CCC, BBB)
BBB = (EEE, DDD)
CCC = (GGG, ZZZ)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
