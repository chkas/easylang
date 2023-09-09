# AoC-22 - Day 16: Proboscidea Volcanium
# 
len hash[] 32768 * 16
proc hashinit . .
   for i to len hash[]
      hash[i] = -1
   .
.
global name$[] .
proc name2id n$ . id .
   for id to len name$[]
      if name$[id] = n$
         break 2
      .
   .
   name$[] &= n$
.
global valv[] con[][] npos .
proc read . .
   name2id "AA" aa
   repeat
      s$ = input
      until s$ = ""
      n$ = substr s$ 7 2
      if substr s$ 24 1 <> "0"
         name2id n$ id
      .
      s$[] &= s$
      conn[][] &= [ ]
      valv[] &= 0
   .
   npos = len name$[]
   for s$ in s$[]
      a$[] = strsplit s$ "= ,"
      name2id a$[2] id
      valv[id] = number a$[6]
      for i = 11 step 2 to len a$[]
         name2id a$[i] h
         conn[id][] &= h
      .
   .
   # 
   # Floyd-Warshall 
   n = len conn[][]
   for i to n
      con[][] &= [ ]
      for j to n
         con[i][] &= 1 / 0
      .
      for j to len conn[i][]
         con[i][conn[i][j]] = 1
      .
   .
   for k to n
      for i to n
         for j to n
            con[i][j] = lower con[i][j] (con[i][k] + con[k][j])
         .
      .
   .
.
read
# 
subr init
   hashinit
   len todo[][] 0
   len todo[][] 20
   itodo = 1
.
proc addways cod press time . .
   h = cod - 1
   pos = h mod npos + 1
   open = h div npos
   for p = 2 to npos
      d = con[pos][p]
      c = time - d
      b = bitshift 1 (p - 2)
      if bitand open b = 0 and c > 0
         cod = (bitor open b) * npos + p
         h = (itodo + d + 1) mod1 len todo[][]
         todo[h][] &= cod * 10000 + press + valv[p] * c
      .
   .
.
proc run nwrks time0 . .
   init
   todo[itodo][] = [ 1 * 10000 ]
   repeat
      for time = time0 downto 1
         do[] = [ ]
         for e in todo[itodo][]
            cod = e div 10000
            press = e mod 10000
            if press > hash[cod]
               hash[cod] = press
               do[] &= e
            .
         .
         for e in do[]
            cod = e div 10000
            press = e mod 10000
            if press = hash[cod]
               addways cod press time
            .
         .
         todo[itodo][] = [ ]
         itodo = (itodo + 1) mod1 len todo[][]
      .
      nwrks -= 1
      until nwrks = 0
      # 
      len todo[][] 0
      len todo[][] 20
      for i to len hash[]
         if hash[i] >= 0
            cod = (i - 1) div npos * npos + 1
            todo[itodo][] &= cod * 10000 + hash[i]
         .
      .
      hashinit
   .
   for p in hash[]
      max = higher max p
   .
   print max
.
run 1 29
run 2 25
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

