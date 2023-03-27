# aoc 16
global name$[] valv[] conn[][] .
func name2id n$ . id .
   for id = 1 to len name$[]
      if name$[id] = n$
         break 2
      .
   .
   name$[] &= n$
   valv[] &= 0
   conn[][] &= [ ]
.
hashsz = 1999993
# hashsz = 19999999
len hashkey[] hashsz
len hashval[] hashsz
# 
global hashind hashkey .
func hashget key . val .
   hashkey = key
   hashind = key mod hashsz + 1
   repeat
      if hashkey[hashind] = key
         val = hashval[hashind]
         break 2
      .
      until hashkey[hashind] = 0
      hashind = hashind mod hashsz + 1
   .
   val = -1
.
func hashnext . val .
   repeat
      hashind = hashind mod hashsz + 1
      if hashkey[hashind] = hashkey
         val = hashval[hashind]
         break 2
      .
      until hashkey[hashind] = 0
   .
   val = -1
.
func hashset val . .
   hashval[hashind] = val
   hashkey[hashind] = hashkey
.
func hashclear . .
   hashval[hashind] = 0
   hashkey[hashind] = 0
.
func read . .
   repeat
      s$ = input
      until s$ = ""
      a$[] = strsplit s$ "= ,"
      call name2id a$[2] id
      valv[id] = number a$[6]
      for i = 11 step 2 to len a$[]
         call name2id a$[i] h
         conn[id][] &= h
      .
   .
.
call read
# 
npos = len valv[]
len open[] npos
call name2id "AA" pos
print pos
time = 30
press = 0
# 
func tocod . cod .
   cod = 0
   for i = 1 to npos
      if valv[i] > 0
         cod = cod * 2 + open[i]
      .
   .
   cod = cod * npos + pos - 1
.
func tostat cod . .
   pos = cod mod npos + 1
   cod = cod div npos
   for i = npos downto 1
      if valv[i] > 0
         open[i] = cod mod 2
         cod = cod div 2
      .
   .
.
# 
global todon[] todovn[] prev[] curcod .
func addtodo . .
   call tocod cod
   call hashget cod v
   if v = -1
      call hashset 30 * press + time
   else
      repeat
         call hashnext v
         until v = -1
         t = v mod 30
         p = v div 30
         if time <= t and press <= p
            dontadd = 1
            break 1
         .
         if time >= t and press >= p
            call hashset 30 * press + time
            break 1
         .
      .
      if v = -1
         call hashset 30 * press + time
      .
   .
   if dontadd = 0
      todon[] &= cod
      todovn[] &= press
      prev[] &= cod * 31 + time - 1
      prev[] &= curcod * 31 + time
   .
.
func addways . .
   h = pos
   for i = 1 to len conn[h][]
      pos = conn[h][i]
      call addtodo
   .
   pos = h
   if valv[pos] > 0 and open[pos] = 0
      open[pos] = 1
      press += valv[pos] * time
      call addtodo
   .
.
global maxcod .
func run . .
   call tocod startcod
   todo[] = [ startcod ]
   todov[] = [ 0 ]
   for time = 29 downto 1
      #      pr "time: " & time
      todon[] = [ ]
      todovn[] = [ ]
      for i = 1 to len todo[]
         curcod = todo[i]
         call tostat curcod
         press = todov[i]
         if press > max
            maxcod = curcod * 31 + time
            max = press
            pr max
         .
         call addways
      .
      swap todon[] todo[]
      swap todovn[] todov[]
      #      pr len todo[]
   .
   print max
.
call run
pr sysfunc "time"
# 
cod = maxcod
for t = 1 to 29
   for i = 1 step 2 to len prev[]
      if prev[i] = cod
         cod = prev[i + 1]
         codl[] &= cod
         break 1
      .
   .
.
func show . .
   for i = len codl[] downto 1
      time = codl[i] mod 31
      cod = codl[i] div 31
      call tostat cod
      pr name$[pos]
   .
.
call show
# 
# 2473 2093 high 
# 
# 
input_data
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II

Valve TB has flow rate=20; tunnel leads to valve DN
Valve SY has flow rate=0; tunnels lead to valves OJ, RZ
Valve EH has flow rate=0; tunnels lead to valves OL, GH
Valve ZE has flow rate=0; tunnels lead to valves WZ, WE
Valve RZ has flow rate=0; tunnels lead to valves GM, SY
Valve FN has flow rate=0; tunnels lead to valves YP, DN
Valve GH has flow rate=12; tunnels lead to valves EH, PV, BH, WY, DW
Valve YL has flow rate=0; tunnels lead to valves GM, YZ
Valve IA has flow rate=0; tunnels lead to valves AA, GM
Valve WK has flow rate=0; tunnels lead to valves HJ, AA
Valve HK has flow rate=0; tunnels lead to valves AA, OJ
Valve WG has flow rate=0; tunnels lead to valves YP, EK
Valve XU has flow rate=0; tunnels lead to valves EX, SK
Valve BH has flow rate=0; tunnels lead to valves GH, DL
Valve OI has flow rate=0; tunnels lead to valves EZ, OV
Valve WE has flow rate=5; tunnels lead to valves ZE, YZ, BF, EZ, HJ
Valve AC has flow rate=0; tunnels lead to valves OJ, OV
Valve EI has flow rate=18; tunnels lead to valves OD, GS, XZ, WY, QU
Valve CP has flow rate=0; tunnels lead to valves GS, AA
Valve WZ has flow rate=0; tunnels lead to valves ZE, OJ
Valve EZ has flow rate=0; tunnels lead to valves OI, WE
Valve LI has flow rate=0; tunnels lead to valves WJ, OV
Valve WJ has flow rate=0; tunnels lead to valves LI, YP
Valve AQ has flow rate=0; tunnels lead to valves PF, EX
Valve DW has flow rate=0; tunnels lead to valves EK, GH
Valve OA has flow rate=25; tunnels lead to valves OL, PN, OD
Valve ZV has flow rate=0; tunnels lead to valves GM, OV
Valve CH has flow rate=0; tunnels lead to valves QU, EX
Valve CG has flow rate=0; tunnels lead to valves PN, EK
Valve EX has flow rate=19; tunnels lead to valves AQ, XU, CH, BF
Valve DN has flow rate=0; tunnels lead to valves TB, FN
Valve QU has flow rate=0; tunnels lead to valves EI, CH
Valve QA has flow rate=0; tunnels lead to valves ZO, PU
Valve DL has flow rate=0; tunnels lead to valves OJ, BH
Valve BF has flow rate=0; tunnels lead to valves WE, EX
Valve OJ has flow rate=4; tunnels lead to valves SY, WZ, AC, DL, HK
Valve MN has flow rate=0; tunnels lead to valves AA, OV
Valve WY has flow rate=0; tunnels lead to valves EI, GH
Valve PF has flow rate=21; tunnel leads to valve AQ
Valve EK has flow rate=10; tunnels lead to valves DW, WG, CG, XZ
Valve GA has flow rate=0; tunnels lead to valves KB, YP
Valve BW has flow rate=0; tunnels lead to valves AL, GD
Valve YZ has flow rate=0; tunnels lead to valves WE, YL
Valve VG has flow rate=0; tunnels lead to valves PV, GD
Valve OD has flow rate=0; tunnels lead to valves OA, EI
Valve GM has flow rate=13; tunnels lead to valves YL, RZ, SK, ZV, IA
Valve YP has flow rate=22; tunnels lead to valves GA, AL, WJ, WG, FN
Valve SK has flow rate=0; tunnels lead to valves GM, XU
Valve PN has flow rate=0; tunnels lead to valves OA, CG
Valve AA has flow rate=0; tunnels lead to valves CP, WK, MN, HK, IA
Valve AL has flow rate=0; tunnels lead to valves BW, YP
Valve OV has flow rate=7; tunnels lead to valves AC, OI, LI, ZV, MN
Valve ZO has flow rate=23; tunnel leads to valve QA
Valve HJ has flow rate=0; tunnels lead to valves WE, WK
Valve KB has flow rate=0; tunnels lead to valves GA, PU
Valve OL has flow rate=0; tunnels lead to valves OA, EH
Valve PV has flow rate=0; tunnels lead to valves GH, VG
Valve PU has flow rate=24; tunnels lead to valves KB, QA
Valve GD has flow rate=17; tunnels lead to valves VG, BW
Valve GS has flow rate=0; tunnels lead to valves CP, EI
Valve XZ has flow rate=0; tunnels lead to valves EI, EK

#

