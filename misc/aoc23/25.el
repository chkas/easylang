# AoC-23 - Day 25: Snowverload
#
global name$[] r[][] con[][] n .
#
proc mkcons . .
   len con[][] n
   for i to n : len con[i][] n
   for i to n : for e in r[i][]
      con[i][e] = 1
      con[e][i] = 1
   .
.
func n2id n$ .
   for id to len name$[]
      if name$[id] = n$ : return id
   .
   name$[] &= n$
   r[][] &= [ ]
   return id
.
proc read . .
   repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ " "
      id = n2id substr s$[1] 1 3
      for i = 2 to len s$[]
         id2 = n2id s$[i]
         r[id][] &= id2
         r[id2][] &= id
      .
      n = len r[][]
   .
.
read
#
proc discon a b . .
   con[a][b] = 0
   con[b][a] = 0
.
func gcon src dest .
   len seen[] n
   len prev[] n
   todo[] &= src
   while len todo[] > 0
      for nd in todo[]
         for e in r[nd][]
            if seen[e] = 0 and con[nd][e] = 1
               seen[e] = 1
               prev[e] = nd
               if e = dest
                  repeat
                     discon e prev[e]
                     until prev[e] = src
                     e = prev[e]
                  .
                  return 1
               .
               todon[] &= e
            .
         .
      .
      swap todo[] todon[]
      todon[] = [ ]
   .
   return 0
.
#
proc go . .
   s = 1
   sum = 1
   for d = 2 to n
      mkcons
      cnt = 0
      while gcon s d = 1
         cnt += 1
      .
      sum += if cnt = 4
   .
   print sum * (n - sum)
.
go
#
input_data
jqt: rhn xhk nvd
rsh: frs pzl lsr
xhk: hfx
cmg: qnr nvd lhk bvb
rhn: xhk bvb hfx
bvb: xhk hfx
pzl: lsr hfx nvd
qnr: nvd
ntq: jqt hfx bvb xhk
nvd: lhk
lsr: lhk
rzs: qnr cmg lsr rsh
frs: qnr lhk lsr


