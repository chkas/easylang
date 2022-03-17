# AoC-19 - Day 2: 1202 Program Alarm
# 
mem0[] = number strsplit input ","
global mem[] .
# 
func run . .
  pc = 0
  repeat
    oc = mem[pc]
    until oc = 99
    a = mem[pc + 1]
    b = mem[pc + 2]
    c = mem[pc + 3]
    if oc = 1
      mem[c] = mem[a] + mem[b]
    elif oc = 2
      mem[c] = mem[a] * mem[b]
    else
      print "error"
    .
    pc += 4
  .
.
# 
func part1 . .
  mem[] = mem0[]
  mem[1] = 12
  mem[2] = 2
  call run
  print mem[0]
.
call part1
# 
func part2 . .
  for noun range 100
    for verb range 100
      mem[] = mem0[]
      mem[1] = noun
      mem[2] = verb
      call run
      if mem[0] = 19690720
        print 100 * noun + verb
        break 2
      .
    .
  .
.
call part2
# 
input_data
1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,2,19,9,23,1,23,5,27,2,6,27,31,1,31,5,35,1,35,5,39,2,39,6,43,2,43,10,47,1,47,6,51,1,51,6,55,2,55,6,59,1,10,59,63,1,5,63,67,2,10,67,71,1,6,71,75,1,5,75,79,1,10,79,83,2,83,10,87,1,87,9,91,1,91,10,95,2,6,95,99,1,5,99,103,1,103,13,107,1,107,10,111,2,9,111,115,1,115,6,119,2,13,119,123,1,123,6,127,1,5,127,131,2,6,131,135,2,6,135,139,1,139,5,143,1,143,10,147,1,147,2,151,1,151,13,0,99,2,0,14,0


