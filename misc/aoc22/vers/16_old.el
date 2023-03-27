# AoC-22 - Day 16: Proboscidea Volcanium
# 
# Part 1 - DFS
# Part 2 - BFS - cut todo list to 1000
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
func hashinit . .
   len hashkey[] 0
   len hashval[] 0
   len hashkey[] hashsz
   len hashval[] hashsz
.
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
# Part 1 
# 
func test time pos press . ok .
   for i = 1 to npos
      if valv[i] > 0
         cod = cod * 2 + open[i]
      .
   .
   cod = cod * npos + pos - 1
   call hashget cod v
   while v <> -1
      t = v mod 30
      p = v div 30
      if time <= t and press <= p
         ok = 0
         break 2
      .
      if time >= t and press >= p
         break 1
      .
      call hashnext v
   .
   call hashset 30 * press + time
   ok = 1
.
global max .
func search time pos pospr press restvalv . .
   if press + restvalv * time <= max
      break 1
   .
   if time = 0
      max = higher max press
      break 1
   .
   call test time pos press ok
   if ok = 0
      break 1
   .
   if valv[pos] > 0 and open[pos] = 0
      # always open valve - ok?
      open[pos] = 1
      h = press + valv[pos] * time
      call search time - 1 pos pos h restvalv - valv[pos]
      open[pos] = 0
   else
      for i = 1 to len conn[pos][]
         h = conn[pos][i]
         if h <> pospr
            call search time - 1 h pos press restvalv
         .
      .
   .
.
for v in valv[]
   allvalv += v
.
call search 29 startpos -1 0 allvalv
print max
# 
# Part 2
# 
# 
pos = startpos
posp = 1
time = 30
press = 0
pos2 = pos
pos2p = 1
# 
func tocod . cod .
   for i = 1 to npos
      if valv[i] > 0
         cod = cod * 2 + open[i]
      .
   .
   if pos > pos2
      cod = cod * npos + pos - 1
      cod = cod * npos + pos2 - 1
      cod = cod * npos + posp - 1
      cod = cod * npos + pos2p - 1
   else
      cod = cod * npos + pos2 - 1
      cod = cod * npos + pos - 1
      cod = cod * npos + pos2p - 1
      cod = cod * npos + posp - 1
   .
.
func tostat cod . .
   pos2p = cod mod npos + 1
   cod = cod div npos
   posp = cod mod npos + 1
   cod = cod div npos
   pos2 = cod mod npos + 1
   cod = cod div npos
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
global todon[] todovn[] max .
# 
func addtodo . .
   call tocod cod
   call hashget cod div (npos * npos) v
   if v = -1 or press > v
      call hashset press
      todon[] &= cod
      todovn[] &= press
   .
.
func addways2 pos2pp . .
   if valv[pos2p] > 0 and open[pos2p] = 0
      pos2 = pos2p
      open[pos2] = 1
      press += valv[pos2] * time
      call addtodo
      press -= valv[pos2] * time
      open[pos2] = 0
   .
   for i = 1 to len conn[pos2p][]
      pos2 = conn[pos2p][i]
      if pos2 <> pos2pp
         call addtodo
      .
   .
.
func addways . .
   pospp = posp
   pos2pp = pos2p
   posp = pos
   pos2p = pos2
   if valv[pos] > 0 and open[pos] = 0
      open[pos] = 1
      press += valv[pos] * time
      call addways2 pos2pp
      press -= valv[pos] * time
      open[pos] = 0
   .
   p = pos
   for i = 1 to len conn[p][]
      pos = conn[p][i]
      if pos <> pospp
         call addways2 pos2pp
      .
   .
.
maxtodo = 1000
func sorttodo . .
   for i = 1 to maxtodo
      for j = i + 1 to len todon[]
         if todovn[j] > todovn[i]
            swap todovn[j] todovn[i]
            swap todon[j] todon[i]
         .
      .
   .
.
#      
func run . .
   call tocod startcod
   todo[] = [ startcod ]
   todov[] = [ 0 ]
   for time = 25 downto 1
      todon[] = [ ]
      todovn[] = [ ]
      m = lower maxtodo len todo[]
      # print m
      for i = 1 to m
         curcod = todo[i]
         call tostat curcod
         press = todov[i]
         max = higher max press
         call addways
      .
      call sorttodo
      swap todon[] todo[]
      swap todovn[] todov[]
   .
   print max
.
call hashinit
call run
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

