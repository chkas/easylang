# AoC-21 - Day 12: Passage Pathing
# 
# Convert names to indices and note small
# caves. DFS recursive. With a field where
# it is noted how often a cave was visited.   
# 
global m[][] name$[] small[] start ende .
proc add n$ . id .
   for id = 1 to len name$[]
      if name$[id] = n$
         break 2
      .
   .
   name$[] &= n$
   m[][] &= [ ]
   small[] &= if strcode substr n$ 1 1 >= strcode "a"
   if n$ = "start"
      start = id
   elif n$ = "end"
      ende = id
   .
.
repeat
   s$ = input
   until s$ = ""
   a$[] = strsplit s$ "-"
   add a$[1] a
   add a$[2] b
   m[a][] &= b
   m[b][] &= a
.
# 
global n_found .
proc find pos seen[] twice . .
   if pos = ende
      n_found += 1
   else
      seen[pos] += 1
      for d in m[pos][]
         if small[d] = 0 or seen[d] = 0
            find d seen[] twice
         elif twice = 0 and seen[d] = 1 and d <> start
            find d seen[] 1
         .
      .
   .
.
len seen[] len small[]
find start seen[] 1
print n_found
n_found = 0
find start seen[] 0
print n_found
# 
input_data
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW

