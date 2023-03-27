# AoC-19 - Day 25: Cryostasis
# 
verbose = 0
# 
ic_mem[] = number strsplit input ","
# 
# -------- intcode --------
# 
prefix ic_
# 
arrbase mem[] 0
in = -1
base = 0
pc = 0
# 
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
funcdecl outf out . .
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
            call outf a
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
len door[] 4
global room$ item$ stat weight_fb out$ last_out$ .
# 
func ic_outf out . .
   c$ = strchar out
   if out = 10
      a$[] = strchars out$
      if len a$[] > 0
         if a$[1] = "="
            room$ = substr out$ 4 4
            stat = 0
            item$ = ""
            for i = 1 to 4
               door[i] = 0
            .
         elif a$[1] = "D"
            stat = 1
         elif a$[1] = "I"
            stat = 2
         elif a$[1] = "C"
            # command
            stat = 3
         else
            if stat = 1 and a$[1] = "-"
               if a$[3] = "n"
                  door[1] = 1
               elif a$[3] = "e"
                  door[2] = 1
               elif a$[3] = "s"
                  door[3] = 1
               elif a$[3] = "w"
                  door[4] = 1
               .
            elif stat = 2 and a$[1] = "-"
               for i = 3 to len a$[]
                  item$ &= a$[i]
               .
            elif stat = 1 and a$[1] = "A"
               weight_fb = 0
               if a$[60] = "l"
                  weight_fb = 1
               elif a$[60] = "h"
                  weight_fb = -1
               .
            .
         .
      .
      if verbose = 1
         print out$
         sleep 0.01
      .
      last_out$ = out$
      out$ = ""
   else
      out$ &= c$
   .
.
# 
func put h . .
   ic_in = h
   call ic_run
.
func say s$ . .
   if verbose = 1
      print "-> " & s$
   .
   a$[] = strchars s$
   for i = 1 to len a$[]
      h = strcode a$[i]
      call put h
   .
   call put 10
.
# 
dir$[] = [ "north" "east" "south" "west" ]
func go d . .
   call say dir$[d]
.
avoid$[] = [ "escape pod" "photons" "molten lava" "giant electromagnet" "infinite loop" ]
item$[] = [ ]
func take_items . .
   if item$ <> ""
      for i = 1 to len avoid$[]
         if item$ = avoid$[i]
            item$ = ""
         .
      .
      if item$ <> ""
         call say "take " & item$
         item$[] &= item$
      .
   .
.
func collect_items dir0 . .
   if room$ <> "Secu"
      for dir = 1 to 4
         if dir <> dir0 and door[dir] = 1
            call go dir
            call take_items
            rdir = (dir + 1) mod 4 + 1
            call collect_items rdir
            call go rdir
         .
      .
   .
.
pressure_floor = -1
func to_checkpoint rev_dir . .
   if room$ = "Secu"
      # found
      for dir = 1 to 4
         if dir <> rev_dir and door[dir] = 1
            pressure_floor = dir
         .
      .
   else
      for dir = 1 to 4
         if dir <> rev_dir and door[dir] = 1
            call go dir
            rdir = (dir + 1) mod 4 + 1
            call to_checkpoint rdir
            if pressure_floor <> -1
               # found
               break 1
            .
            call go rdir
         .
      .
   .
.
item[] = [ ]
n_item = 0
func combine_items . .
   for i = 1 to n_item
      if item[i] = 0
         item[i] = 1
         call say "take " & item$[i]
         call go pressure_floor
         if weight_fb = -1
            # still too low
            call combine_items
         .
         if weight_fb = 0
            # done
            break 1
         .
         # too high
         item[i] = 0
         call say "drop " & item$[i]
      .
   .
.
func run . .
   call ic_run
   call collect_items -1
   call to_checkpoint -1
   n_item = len item$[]
   len item[] n_item
   for i = 1 to n_item
      call say "drop " & item$[i]
   .
   call combine_items
   if verbose = 0
      print last_out$
   .
.
if len ic_mem[] > 1
   call run
else
   print "No input"
.
# 
input_data


