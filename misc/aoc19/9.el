# AoC-19 - Day 9: Sensor Boost
# 
code[] = number strsplit input ","
arrbase code[] 0
# 
global base mem[] .
# 
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
proc run inp . .
   mem[] = code[]
   base = 0
   pc = 0
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
            mem[ind] = inp
         elif oc = 4
            print a
         elif oc = 9
            base += a
         else
            print "error opcode"
         .
         pc += 2
      .
   .
.
run 1
run 2
# 
input_data
1102,34915192,34915192,7,4,7,99,0


