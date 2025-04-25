# AoC-24 - Day 23: LAN Party
#
global cons[][] na$[] co[][] n .
func n2id n$ .
   for id to len na$[] : if na$[id] = n$ : return id
   na$[] &= n$
   cons[][] &= [ ]
   return id
.
proc init .
   repeat
      s$ = input
      until s$ = ""
      a$[] = strsplit s$ "-"
      a = n2id a$[1]
      b = n2id a$[2]
      cons[a][] &= b
      cons[b][] &= a
   .
   n = len cons[][]
   len co[][] n
   for i to n : len co[i][] n
   len co[][] n
   for a to n
      for h in cons[a][] : co[a][h] = 1
   .
.
init
#
func isat a .
   return if substr na$[a] 1 1 = "t"
.
proc part1 .
   for a to n
      for b = a + 1 to n : if co[a][b] = 1
         for c = b + 1 to n : if co[b][c] = 1 and co[c][a] = 1
            if isat a + isat b + isat c >= 1 : sum += 1
         .
      .
   .
   print sum
.
part1
#
proc sort &d$[] .
   for i = len d$[] - 1 downto 1
      for j = 1 to i
         if strcmp d$[j] d$[j + 1] > 0 : swap d$[j] d$[j + 1]
      .
   .
.
global maxcol[] maxsize .
len cluster[] n
len col[] n
#
proc collect .
   mincons = n
   for i to n : if col[i] = 1
      mincons = lower mincons len cons[i][]
      size += 1
   .
   if size > maxsize
      maxsize = size
      maxcol[] = col[]
   .
   for a to n : if col[a] = 0 and cluster[a] = 0
      for h to n
         if col[h] = 1 and co[a][h] = 0 : break 1
      .
      if h > n
         col[a] = 1
         collect
         col[a] = 0
      .
   .
   #
   if size * 2 > mincons
      for i to n : if col[i] = 1
         col[i] = 0
         cluster[i] = 1
      .
   .
.
collect
for i to n : if maxcol[i] = 1 : col$[] &= na$[i]
sort col$[]
print strjoin col$[] ","
#
input_data
kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
