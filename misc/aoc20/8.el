# AoC-20 - Day 8: Handheld Halting
# 
global cod$[] arg[] .
# 
proc read_input .
   repeat
      inp$ = input
      until inp$ = ""
      h$[] = strsplit inp$ " "
      cod$[] &= h$[1]
      arg[] &= number h$[2]
   .
.
read_input
# 
global acc err .
proc run .
   pc = 1
   len vis[] len cod$[]
   err = 0
   acc = 0
   while pc <= len cod$[]
      if vis[pc] = 1
         err = 1
         break 1
      .
      vis[pc] = 1
      if cod$[pc] = "acc"
         acc += arg[pc]
         pc += 1
      elif cod$[pc] = "jmp"
         pc += arg[pc]
      elif cod$[pc] = "nop"
         pc += 1
      else
         print "error"
      .
   .
.
# 
proc part1 .
   run
   print acc
.
part1
# 
proc part2 .
   fix = 1
   repeat
      while cod$[fix] = "acc" or cod$[fix] = "nop"
         fix += 1
      .
      cod$[fix] = "nop"
      run
      until err = 0
      cod$[fix] = "jmp"
      fix += 1
   .
   print acc
.
part2
# 
input_data
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6



