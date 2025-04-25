# AoC-19 - Day 13: Care Package
#
sysconf topleft
visual = 1
#
ic_mem[] = number strsplit input ","
#
global ball_x pad_x .
#
proc ic_inpf &in ..
   if ball_x > pad_x
      in = 1
   elif ball_x < pad_x
      in = -1
   else
      in = 0
   .
   if visual = 1 : sleep 0.01
.
textsize 4
background 000
clear
#
proc draw_score v . .
   if visual = 0 : return
   move 4 15
   color 000
   rect 30 4
   color 666
   text "Score: " & v
.
proc draw x y v . .
   if visual = 0 : return
   col[] = [ 000 444 753 777 933 ]
   color col[v + 1]
   move 2.5 * x + 3 2.5 * y + 20
   if v = 0
      rect 2.4 2.4
   else
      rect 2.3 2.3
   .
.
global x y out_ind n_blocks n_points .
#
proc ic_outpf out . .
   if out_ind = 0
      x = out
   elif out_ind = 1
      y = out
   else
      if x = -1 and y = 0
         draw_score out
         n_points = out
      else
         if out = 2
            n_blocks += 1
         elif out = 3
            pad_x = x
         elif out = 4
            ball_x = x
         .
         draw x y out
      .
   .
   out_ind = (out_ind + 1) mod 3
.
#
prefix ic_
# -------- intcode --------
base = 0
arrbase mem[] 0
proc mem_ind mo ind &rind ..
   if mo = 1
      rind = ind
   elif mo = 0
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
      until oc = 99
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
            inpf h
            mem[ind] = h
         elif oc = 4
            outpf a
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
if len ic_mem[] > 1
   ic_run
   print n_blocks
   #
   ic_mem[0] = 2
   ic_run
   print n_points
else
   print "No input"
.
#
input_data






