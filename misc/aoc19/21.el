# AoC-19 - Day 21: Springdroid Adventure
#
proc arr0init &a[] .
   h = a[1]
   for i = 1 to len a[] - 1 : a[i] = a[i + 1]
   a[0] = h
.
proc ic_arr0len &a[] l .
   h = a[0]
   a[0] = 0
   len a[] l
   a[0] = h
.
#
ic_code[] = number strsplit input ","
arr0init ic_code[]
ic_in = -1
proc ic_outpf out .
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
.
proc mem_ind mo ind &rind .
   rind = ind
   if mo = 0
      rind = mem[ind]
   elif mo = 2
      rind = base + mem[ind]
   .
   if rind >= len mem[]
      arr0len mem[] rind + 8
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
prefix
# --------  --------
#
proc ic_put h .
   ic_in = h
   ic_run
.
in$[][] &= [ "OR A J" "AND B J" "AND C J" "NOT J J" "AND D J" "WALK" ]
in$[][] &= [ "OR A J" "AND B J" "AND C J" "NOT J J" "AND D J" "OR E T" "OR H T" "AND T J" "RUN" ]
proc run .
   for k = 1 to 2
      ic_reset
      ic_run
      for s$ in in$[k][]
         print s$
         a$[] = strchars s$
         for i = 1 to len a$[]
            ic_put strcode a$[i]
         .
         ic_put 10
      .
      print ""
   .
.
if len ic_code[] > 1
   run
else
   print "No input"
.
#
input_data
1
