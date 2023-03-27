# AoC-19 - Day 7: Amplification Circuit
# 
code[] = number strsplit input ","
# 
prefix ic_
global out pc fin mem[] .
in = -1
# 
func run . .
   arrbase mem[] 0
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
   for i = 1 to 5
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
   for i = k to len arr[]
      swap arr[i] arr[k]
      call permute k + 1
      swap arr[k] arr[i]
   .
   if k = len arr[]
      call runall
      if ic_out > max
         max = ic_out
      .
   .
.
func part1 . .
   call permute 1
   print max
.
call part1
# 
# ---------------------------------------
# 
len mem[][] 5
len pc[] 5
func init . .
   for i = 1 to 5
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
   for id = 1 to 5
      ic_in = arr[id]
      call runid id
   .
   ic_out = 0
   repeat
      for id = 1 to 5
         ic_in = ic_out
         call runid id
      .
      until ic_fin = 1
   .
.
max = 0
func permute2 k . .
   for i = k to len arr[]
      swap arr[i] arr[k]
      call permute2 k + 1
      swap arr[i] arr[k]
   .
   if k = len arr[]
      call runall2
      if ic_out > max
         max = ic_out
      .
   .
.
func part2 . .
   call permute2 1
   print max
.
call part2
# 
input_data
3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0


