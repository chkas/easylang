# AoC-19 - Day 19: Tractor Beam
# 
visual = 1
# 
ic_code[] = number strsplit input ","
ic_out = -1
ic_in = -1
# 
prefix ic_
# -------- intcode --------
subr reset
  pc = 0
  base = 0
  mem[] = code[]
.
func mem_ind mo ind . rind .
  rind = ind
  if mo = 0
    rind = mem[ind]
  elif mo = 2
    rind = base + mem[ind]
  .
  if rind >= len mem[]
    len mem[] rind + 8
  .
.
func run . .
  repeat
    oc0 = mem[pc]
    oc = oc0 mod 100
    until oc = 99 or oc = 3 and in = -1
    call mem_ind oc0 div 100 mod 10 pc + 1 ind
    a = mem[ind]
    if oc = 1 or oc = 2 or oc >= 5 and oc <= 8
      call mem_ind oc0 div 1000 mod 10 pc + 2 ind
      b = mem[ind]
      if oc = 1 or oc = 2 or oc = 7 or oc = 8
        h = 0
        if oc = 1
          h = a + b
        elif oc = 2
          h = a * b
        elif oc = 7 and a < b or oc = 8 and a = b
          h = 1
        .
        call mem_ind oc0 div 10000 mod 10 pc + 3 ind
        mem[ind] = h
        pc += 4
      else
        pc += 3
        if oc = 5 and a <> 0 or oc = 6 and a = 0
          pc = b
        .
      .
    else
      if oc = 3
        if in = -1
          print "error in"
        .
        mem[ind] = in
        in = -1
      elif oc = 4
        out = a
      elif oc = 9
        base += a
      else
        print "error opcode"
      .
      pc += 2
    .
  .
.
# --------  --------
prefix
# 
func in_beam in1 in2 . out .
  call ic_reset
  ic_in = in1
  call ic_run
  ic_in = in2
  call ic_run
  out = ic_out
.
background 222
clear
func draw_light x y h . .
  if visual = 0
    break 1
  .
  if h = 1
    color 884
  else
    color 000
  .
  move x * 2 y * 2
  rect 1.8 1.8
  sleep 0
.
# 
func part1 . .
  cnt = 0
  for y range 50
    for x range 50
      call in_beam x y h
      call draw_light x y h
      cnt += h
    .
  .
  print "Part 1: " & cnt
.
call part1
# 
func test x . y res .
  x += 99
  repeat
    call in_beam x y h
    until h = 1
    y += 1
  .
  call in_beam x - 99 y + 99 res
.
func part2 . .
  y = 0
  x = 100
  repeat
    call test x y res
    until res = 1
    x += 1
  .
  print "Part 2: " & x * 10000 + y
.
call part2
# 
input_data
109,424,203,1,21101,0,11,0,1105,1,282,21101,18,0,0,1105,1,259,2101,0,1,221,203,1,21102,1,31,0,1105,1,282,21101,0,38,0,1106,0,259,21002,23,1,2,22101,0,1,3,21101,0,1,1,21102,1,57,0,1106,0,303,2102,1,1,222,21001,221,0,3,20102,1,221,2,21101,0,259,1,21101,80,0,0,1106,0,225,21101,0,23,2,21102,91,1,0,1106,0,303,1201,1,0,223,20101,0,222,4,21101,0,259,3,21102,1,225,2,21102,1,225,1,21102,1,118,0,1105,1,225,20102,1,222,3,21101,0,87,2,21101,133,0,0,1106,0,303,21202,1,-1,1,22001,223,1,1,21101,0,148,0,1105,1,259,2101,0,1,223,20102,1,221,4,21002,222,1,3,21101,0,9,2,1001,132,-2,224,1002,224,2,224,1001,224,3,224,1002,132,-1,132,1,224,132,224,21001,224,1,1,21102,1,195,0,106,0,109,20207,1,223,2,21001,23,0,1,21102,1,-1,3,21101,0,214,0,1106,0,303,22101,1,1,1,204,1,99,0,0,0,0,109,5,2102,1,-4,249,21201,-3,0,1,22101,0,-2,2,21202,-1,1,3,21102,250,1,0,1106,0,225,21202,1,1,-4,109,-5,2106,0,0,109,3,22107,0,-2,-1,21202,-1,2,-1,21201,-1,-1,-1,22202,-1,-2,-2,109,-3,2105,1,0,109,3,21207,-2,0,-1,1206,-1,294,104,0,99,21202,-2,1,-2,109,-3,2105,1,0,109,5,22207,-3,-4,-1,1206,-1,346,22201,-4,-3,-4,21202,-3,-1,-1,22201,-4,-1,2,21202,2,-1,-1,22201,-4,-1,1,22102,1,-2,3,21102,1,343,0,1106,0,303,1106,0,415,22207,-2,-3,-1,1206,-1,387,22201,-3,-2,-3,21202,-2,-1,-1,22201,-3,-1,3,21202,3,-1,-1,22201,-3,-1,2,21201,-4,0,1,21102,384,1,0,1105,1,303,1106,0,415,21202,-4,-1,-4,22201,-4,-3,-4,22202,-3,-2,-2,22202,-2,-4,-4,22202,-3,-2,-3,21202,-4,-1,-2,22201,-3,-2,1,21202,1,1,-4,109,-5,2106,0,0

