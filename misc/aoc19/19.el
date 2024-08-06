# AoC-19 - Day 19: Tractor Beam
#
sysconf topleft
visual = 1
#
ic_code[] = number strsplit input ","
ic_out = -1
ic_in = -1
#
# -------- intcode --------
prefix ic_
subr reset
   pc = 0
   base = 0
   mem[] = code[]
   arrbase mem[] 0
.
proc mem_ind mo ind . rind .
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
proc run . .
   repeat
      oc0 = mem[pc]
      oc = oc0 mod 100
      until oc = 99 or oc = 3 and in = -1
      mem_ind oc0 div 100 mod 10 pc + 1 ind
      a = mem[ind]
      if oc = 1 or oc = 2 or oc >= 5 and oc <= 8
         mem_ind oc0 div 1000 mod 10 pc + 2 ind
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
            mem_ind oc0 div 10000 mod 10 pc + 3 ind
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
prefix
# --------  --------
#
proc in_beam in1 in2 . out .
   ic_reset
   ic_in = in1
   ic_run
   ic_in = in2
   ic_run
   out = ic_out
.
background 222
clear
proc draw_light x y h . .
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
proc part1 . .
   cnt = 0
   for y range0 50
      for x range0 50
         in_beam x y h
         draw_light x y h
         cnt += h
      .
   .
   print cnt
.
#
proc test x . y res .
   x += 99
   repeat
      in_beam x y h
      until h = 1
      y += 1
   .
   in_beam x - 99 y + 99 res
.
proc part2 . .
   y = 0
   x = 100
   repeat
      test x y res
      until res = 1
      x += 1
   .
   print x * 10000 + y
.
if len ic_code[] > 1
   part1
   part2
else
   print "No input"
.
#
input_data


