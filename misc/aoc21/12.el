# AoC-21 - Day 12: Passage Pathing
# 
# Convert names to indices and note small
# caves. DFS recursive. With a field where
# it is noted how often a cave was visited.   
# 
global m[][] name$[] small[] start ende .
func add n$ . id .
  for id range len name$[]
    if name$[id] = n$
      break 2
    .
  .
  name$[] &= n$
  m[][] &= [ ]
  small[] &= if strcode substr n$ 0 1 >= strcode "a"
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
  call add a$[0] a
  call add a$[1] b
  m[a][] &= b
  m[b][] &= a
.
# 
global n_found .
func find pos seen[] twice . .
  if pos = ende
    n_found += 1
  else
    seen[pos] += 1
    for d in m[pos][]
      if small[d] = 0 or seen[d] = 0
        call find d seen[] twice
      elif twice = 0 and seen[d] = 1 and d <> start
        call find d seen[] 1
      .
    .
  .
.
len seen[] len small[]
call find start seen[] 1
print n_found
n_found = 0
call find start seen[] 0
print n_found
# 
input_data
xx-end
EG-xx
iy-FP
iy-qc
AB-end
yi-KG
KG-xx
start-LS
qe-FP
qc-AB
yi-start
AB-iy
FP-start
iy-LS
yi-LS
xx-AB
end-KG
iy-KG
qc-KG
FP-xx
LS-qc
FP-yi


