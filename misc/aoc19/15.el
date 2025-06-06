# AoC-19 - Day 15: Oxygen System
#
sysconf topleft
visual = 1
#
ic_mem[] = number strsplit input ","
#
ic_out = -1
ic_in = -1
#
prefix ic_
# -------- intcode --------
global base pc .
arrbase mem[] 0
#
proc mem_ind mo ind &rind .
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
proc run .
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
proc go_dir d &out .
   ic_in = d
   ic_run
   out = ic_out
.
len map[] 100 * 100
gbackground 000
gclear
ox_pos = 1
proc draw pos col .
   if visual = 0 : return
   pos -= 1
   x = pos mod 100
   y = pos div 100
   gcolor col
   grect x * 2 - 50 y * 2 - 50 2 2
   sleep 0.001
.
offs[] = [ -100 100 1 -1 ]
rev[] = [ 2 1 4 3 ]
#
proc maze dir0 pos &min .
   map[pos] = 1
   draw pos 888
   min = 1 / 0
   for dir = 1 to 4
      if dir <> dir0
         go_dir dir out
         if out = 1 or out = 2
            posn = pos + offs[dir]
            if out = 1
               maze rev[dir] posn h
               if h + 1 < min
                  min = h + 1
               .
            else
               ox_pos = posn
               min = 1
            .
            go_dir rev[dir] h
         .
      .
   .
.
#
proc oxygen .
   todon[] = [ ox_pos ]
   repeat
      swap todo[] todon[]
      len todon[] 0
      for ind = 1 to len todo[]
         pos = todo[ind]
         map[pos] = 0
         for dir = 1 to 4
            posn = pos + offs[dir]
            if map[posn] = 1
               draw posn 338
               todon[] &= posn
            .
         .
      .
      until len todon[] = 0
      if visual = 1 : sleep 0.01
      minutes += 1
   .
   print minutes
.
if len ic_mem[] <= 1
   print "no input data"
   return
.
maze -1 5051 res
draw ox_pos 900
print res
#
oxygen
#
input_data
