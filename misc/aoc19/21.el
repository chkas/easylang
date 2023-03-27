# AoC-19 - Day 21: Springdroid Adventure
# 
ic_code[] = number strsplit input ","
ic_in = -1
func ic_outpf out . .
   if out > 127
      print out
   else
      write strchar out
   .
.
# 
# -------- intcode --------
prefix ic_
subr reset
   pc = 0
   base = 0
   mem[] = code[]
   arrbase mem[] 0
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
            mem[ind] = in
            in = -1
         elif oc = 4
            call outpf a
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
func ic_put h . .
   ic_in = h
   call ic_run
.
func run . .
   s$ = input
   for _ = 1 to 2
      call ic_reset
      call ic_run
      repeat
         s$ = input
         until s$ = ""
         print s$
         a$[] = strchars s$
         for i = 1 to len a$[]
            call ic_put strcode a$[i]
         .
         call ic_put 10
      .
      print ""
   .
.
if len ic_code[] > 1
   call run
else
   print "No input"
.
# 
input_data




