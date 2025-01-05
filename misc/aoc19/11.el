# AoC-19 - Day 11: Space Police
#
sysconf topleft
#
ic_mem[] = number strsplit input ","
#
nc = 100
len painted[] nc * nc
len hull[] len painted[]
arrbase painted[] 0
arrbase hull[] 0
#
pos = nc * nc div 2 + nc div 2
global n_painted out_ind .
#
proc init_part2 . .
   for i range0 len hull[]
      hull[i] = 0
   .
   pos = nc * nc div 2 + nc div 2
   hull[pos] = 1
.
proc ic_inpf . in .
   in = hull[pos]
.
mpos[] = [ 1 nc -1 (-nc) ]
dir = 1
proc ic_outpf out . .
   if out_ind = 0
      hull[pos] = out
      if painted[pos] = 0
         painted[pos] = 1
         n_painted += 1
      .
   else
      dir = (dir + 2 - 2 * out) mod 4 + 1
      pos += mpos[dir]
      if pos < 0 or pos >= nc * nc or pos mod nc = 0
         print "error hull size"
      .
   .
   out_ind = (out_ind + 1) mod 2
.
proc make_pic . .
   f = 100 / nc
   background 000
   clear
   color 772
   for y range0 nc
      for x range0 nc
         if hull[y * nc + x] = 1
            move x * f y * f
            rect f f
         .
      .
   .
.
#
prefix ic_
# -------- intcode --------
arrbase mem[] 0
base = 0
proc mem_ind mo ind . rind .
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
   print n_painted
   init_part2
   ic_run
   make_pic
else
   print "No input"
.
#
input_data
