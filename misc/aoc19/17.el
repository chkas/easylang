# AoC-19 - Day 17: Set and Forget
# 
ic_code[] = number strsplit input ","
# 
len scaf[] 100
arrbase scaf[] 0
global width height out$ .
global start_pos .
# 
func ic_outpf out . .
   c$ = strchar out
   out$ &= c$
   if out = 10
      write out$
      out$ = ""
   .
   if c$ = "."
      scaf[] &= 0
   elif c$ = "#"
      scaf[] &= 1
   elif c$ = "^"
      start_pos = len scaf[]
      scaf[] &= 1
   .
   if out = 10
      scaf[] &= 0
      if width = 0
         width = len scaf[] - 100
      .
      height += 1
   .
.
# -------- intcode --------
prefix ic_
in = -1
subr init
   pc = 0
   base = 0
   mem[] = code[]
   arrbase mem[] 0
.
func mem_ind mo ind . rind .
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
            if a < 256
               call outpf a
            else
               print a
            .
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
func part1 . .
   call ic_init
   call ic_run
   offs[] = [ -width 1 width -1 ]
   len scaf[] len scaf[] + width
   for y range0 height - 1
      for x range0 width - 1
         ind = y * width + 100 + x
         s = scaf[ind]
         for i = 1 to 4
            s += scaf[ind + offs[i]]
         .
         if s = 5
            al += x * y
         .
      .
   .
   print al
.
# 
global s$[] sf$[] .
# 
func search si lng . matches[] .
   matches[] = [ ]
   for i = si + lng to len s$[] - lng + 1
      found = 1
      for j range0 lng
         if s$[si + j] <> s$[i + j] or strcode s$[si + j] <= 67
            found = 0
         .
      .
      if found = 1
         matches[] &= i
      .
   .
.
len fu$[][] 3
# 
func apply lev start lng . matches[] .
   sn$[] = [ ]
   fu$[lev][] = [ ]
   match = 1
   i = 1
   while i <= len s$[]
      if i = start
         for i = i to i + lng - 1
            fu$[lev][] &= s$[i]
         .
         sn$[] &= strchar (64 + lev)
      elif match <= len matches[] and i = matches[match]
         sn$[] &= strchar (64 + lev)
         i += lng
         match += 1
      else
         sn$[] &= s$[i]
         i += 1
      .
   .
   swap sn$[] s$[]
.
len fuf$[][] 3
# 
func test_found . .
   found = 1
   for i = 1 to len s$[]
      if strcode s$[i] > 67
         found = 0
      .
   .
   if found = 1
      swap fuf$[][] fu$[][]
      swap sf$[] s$[]
   .
.
func search_pat lev . .
   si = 1
   while strcode s$[si] <= 67
      si += 1
   .
   s0$[] = s$[]
   for lng = 2 to 6
      call search si lng matches[]
      if len matches[] > 0
         call apply lev si lng matches[]
         if lev < 3
            call search_pat lev + 1
         else
            call test_found
         .
         s$[] = s0$[]
      .
   .
.
func make_pat . .
   dir = 1
   done = 0
   pos = start_pos
   offs[] = [ -width 1 width -1 ]
   repeat
      dirp = (dir - 2) mod 4 + 1
      dirn = dir mod 4 + 1
      if scaf[pos + offs[dirp]] = 1
         s$ = "L"
         dir = dirp
      elif scaf[pos + offs[dirn]] = 1
         s$ = "R"
         dir = dirn
      else
         done = 1
      .
      until done = 1
      i = 0
      while scaf[pos + offs[dir]] = 1
         i += 1
         pos += offs[dir]
      .
      s$ &= i
      s$[] &= s$
   .
.
func prog_rob . .
   for i = 1 to len sf$[]
      if i > 1
         ic_in = strcode ","
         call ic_run
      .
      ic_in = strcode sf$[i]
      call ic_run
   .
   print ""
   ic_in = 10
   call ic_run
   for fu = 1 to 3
      for i = 1 to len fuf$[fu][]
         h$[] = strchars fuf$[fu][i]
         if i > 1
            ic_in = strcode ","
            call ic_run
         .
         for j = 1 to len h$[]
            if j = 2
               ic_in = strcode ","
               call ic_run
            .
            ic_in = strcode h$[j]
            call ic_run
         .
      .
      ic_in = 10
      call ic_run
   .
   ic_in = strcode "n"
   call ic_run
   ic_in = 10
   call ic_run
.
func part2 . .
   call ic_init
   ic_mem[0] = 2
   call ic_run
   call make_pat
   # 
   call search_pat 1
   call prog_rob
.
if len ic_code[] > 1
   call part1
   call part2
else
   print "No input"
.
# 
input_data




