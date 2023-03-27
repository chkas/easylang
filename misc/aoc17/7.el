# AoC-17 - Day 7: Recursive Circus
# 
global name$[] childs[][] parent[] w[] root .
func name2id n$ . id .
   for id to len name$[]
      if name$[id] = n$
         break 2
      .
   .
   name$[] &= n$
   childs[][] &= [ ]
   parent[] &= 0
   w[] &= 0
.
# 
func read . .
   repeat
      in$ = input
      until in$ = ""
      h$[] = strsplit in$ " "
      call name2id h$[1] id0
      w[id0] = number substr h$[2] 2 len h$[2] - 2
      for i = 4 to len h$[]
         s$ = h$[i]
         if i < len h$[]
            s$ = substr s$ 1 len s$ - 1
         .
         call name2id s$ id
         childs[id0][] &= id
         parent[id] = id0
      .
   .
   n = len name$[]
   for i to n
      if parent[i] = 0
         root = i
      .
   .
.
call read
# 
print name$[root]
# 
done = 0
func bala node . wr .
   for i to len childs[node][]
      nd = childs[node][i]
      call bala nd w
      wsum += w
      if i >= 3 and (wp <> w or wpp <> w or wp <> wpp) and done = 0
         done = 1
         if wp = w
            ind = 1
            w = wpp
         elif wpp = w
            ind = 2
            wp = wpp
         else
            ind = 3
         .
         nd = childs[node][ind]
         print w[nd] + (wp - w)
      .
      wpp = wp
      wp = w
   .
   wr = wsum + w[node]
.
call bala root w
# 
input_data
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)


