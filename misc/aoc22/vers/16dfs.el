# aoc 16 part1 dfs
# 
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
call name2id "AA" startpos
# 
func tocod pos . cod .
   cod = 0
   for i = 1 to npos
      if valv[i] > 0
         cod = cod * 2 + open[i]
      .
   .
   cod = cod * npos + pos - 1
.
# 
func test time pos press . ok .
   ok = 0
   call tocod pos cod
   call hashget cod v
   if v = -1
      call hashset 30 * press + time
      ok = 1
   else
      repeat
         call hashnext v
         until v = -1
         t = v mod 30
         p = v div 30
         if time <= t and press <= p
            break 1
         .
         if time >= t and press >= p
            call hashset 30 * press + time
            ok = 1
            break 1
         .
      .
      if v = -1
         call hashset 30 * press + time
         ok = 1
      .
   .
.
global max .
func search time pos press restvalv . .
   if press + restvalv * time < max
      break 1
   .
   if time = 0
      if press > max
         max = press
         print max
      .
      break 1
   .
   for i = 1 to len conn[pos][]
      h = conn[pos][i]
      call test time h press ok
      if ok = 1
         call search time - 1 h press restvalv
      .
   .
   if valv[pos] > 0 and open[pos] = 0
      open[pos] = 1
      h = press + valv[pos] * time
      call test time pos h ok
      if ok = 1
         call search time - 1 pos h restvalv - valv[pos]
      .
      open[pos] = 0
   .
.
for v in valv[]
   allvalv += v
.
call search 29 startpos 0 allvalv
# 
pr sysfunc "time"
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


