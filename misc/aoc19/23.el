# AoC-19 - Day 23: Category Six
# 
code[] = number strsplit input ","
# 
n = 50
len ic_pc[] n
len ic_base[] n
len ic_mem[][] n
len ic_in[][] n
proc init . .
   arrbase code[] 0
   for i = 1 to n
      ic_pc[i] = 0
      ic_base[i] = 0
      ic_mem[i][] = code[]
      ic_in[i][] = [ i - 1 ]
   .
.
# 
oind = 1
oid = 0
len nat[] 2
proc ic_outf h . .
   if oind = 1
      oid = h
   else
      if oid < 50
         ic_in[oid + 1][] &= h
      elif oid = 255
         nat[oind - 1] = h
      .
   .
   oind = oind mod 3 + 1
.
# -------- intcode --------
prefix ic_
global pc base in[] mem[] .
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
proc run id . .
   pc = pc[id]
   base = base[id]
   swap mem[id][] mem[]
   swap in[id][] in[]
   repeat
      oc0 = mem[pc]
      oc = oc0 mod 100
      until oc = 99 or oc = 3 and len in[] = 0
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
            mem[ind] = in[1]
            for i = 1 to len in[] - 1
               in[i] = in[i + 1]
            .
            len in[] len in[] - 1
         elif oc = 4
            call outf a
         elif oc = 9
            base += a
         else
            print "illegal opcode"
         .
         pc += 2
      .
   .
   pc[id] = pc
   base[id] = base
   swap mem[id][] mem[]
   swap in[id][] in[]
.
# --------  --------
prefix
# 
proc part1 . .
   call init
   repeat
      for id = 1 to n
         ic_in[id][] &= -1
         call ic_run id
      .
      until nat[2] <> 0
   .
   print nat[2]
.
# 
proc part2 . .
   call init
   repeat
      repeat
         idle = 1
         for id = 1 to n
            if len ic_in[id][] <> 0
               idle = 0
            .
            ic_in[id][] &= -1
            call ic_run id
         .
         until idle = 1
      .
      until y = nat[2]
      y = nat[2]
      ic_in[1][] &= nat[1]
      ic_in[1][] &= nat[2]
   .
   print nat[2]
.
if len code[] > 1
   call part1
   call part2
else
   print "No input"
.
# 
input_data



