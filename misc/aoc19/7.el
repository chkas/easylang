# AoC-19 - Day 7: Amplification Circuit
# 
code[] = number strsplit input ","
# 
prefix ic_
global out pc mem[] fin .
in = -1
# 
func run . .
  fin = 0
  repeat
    oc = mem[pc] mod 100
    ma = mem[pc] div 100 mod 10
    mb = mem[pc] div 1000 mod 10
    until oc = 99 or oc = 3 and in = -1
    a = mem[pc + 1]
    if ma = 0
      a = mem[a]
    .
    if oc <= 2 or oc >= 5
      b = mem[pc + 2]
      if mb = 0
        b = mem[b]
      .
    .
    if oc <= 2 or oc >= 7 and oc <= 8
      h = 0
      if oc = 1
        h = a + b
      elif oc = 2
        h = a * b
      elif oc = 7 and a < b or oc = 8 and a = b
        h = 1
      .
      mem[mem[pc + 3]] = h
      pc += 4
    elif oc = 5 or oc = 6
      pc += 3
      if oc = 5 and a <> 0 or oc = 6 and a = 0
        pc = b
      .
    else
      if oc = 3
        mem[mem[pc + 1]] = in
        in = -1
      else
        out = a
      .
      pc += 2
    .
  .
  if oc = 99
    fin = 1
  .
.
prefix
# 
func run0 inp . .
  ic_mem[] = code[]
  ic_in = inp
  ic_pc = 0
  call ic_run
.
arr[] = [ 0 1 2 3 4 ]
func runall . .
  ic_out = 0
  for i range 5
    call run0 arr[i]
    while ic_fin = 0
      ic_in = ic_out
      call ic_run
    .
  .
.
# 
max = 0
func permute k . .
  for i = k to len arr[] - 1
    swap arr[i] arr[k]
    call permute k + 1
    swap arr[k] arr[i]
  .
  if k = len arr[] - 1
    call runall
    if ic_out > max
      max = ic_out
    .
  .
.
func part1 . .
  call permute 0
  print max
.
call part1
# 
# ---------------------------------------
# 
len mem[][] 5
len pc[] 5
func init . .
  for i range 5
    mem[i][] = code[]
    pc[i] = 0
  .
.
func runid id . .
  swap mem[id][] ic_mem[]
  ic_pc = pc[id]
  call ic_run
  swap mem[id][] ic_mem[]
  pc[id] = ic_pc
.
# 
arr[] = [ 5 6 7 8 9 ]
func runall2 . .
  call init
  for id range 5
    ic_in = arr[id]
    call runid id
  .
  ic_out = 0
  repeat
    for id range 5
      ic_in = ic_out
      call runid id
    .
    until ic_fin = 1
  .
.
max = 0
func permute2 k . .
  for i = k to len arr[] - 1
    swap arr[i] arr[k]
    call permute2 k + 1
    swap arr[i] arr[k]
  .
  if k = len arr[] - 1
    call runall2
    if ic_out > max
      max = ic_out
    .
  .
.
func part2 . .
  call permute2 0
  print max
.
call part2
# 
input_data
3,8,1001,8,10,8,105,1,0,0,21,34,51,76,101,126,207,288,369,450,99999,3,9,102,4,9,9,1001,9,2,9,4,9,99,3,9,1001,9,2,9,1002,9,3,9,101,3,9,9,4,9,99,3,9,102,5,9,9,1001,9,2,9,102,2,9,9,101,3,9,9,1002,9,2,9,4,9,99,3,9,101,5,9,9,102,5,9,9,1001,9,2,9,102,3,9,9,1001,9,3,9,4,9,99,3,9,101,2,9,9,1002,9,5,9,1001,9,5,9,1002,9,4,9,101,5,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99


