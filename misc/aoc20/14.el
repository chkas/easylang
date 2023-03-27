# AoC-20 - Day 14: Docking Data
# 
repeat
   s$ = input
   inp$[] &= s$
   until s$ = ""
.
# 
global memi$[] mem[] .
func mem_wr1 ind$ val . .
   for i to len mem[]
      if memi$[i] = ind$
         mem[i] = val
         break 2
      .
   .
   memi$[] &= ind$
   mem[] &= val
.
func part1 . .
   ii = 1
   while substr inp$[ii] 1 4 = "mask"
      s$[] = strsplit inp$[ii] " "
      ii += 1
      msk$[] = strchars s$[3]
      while substr inp$[ii] 1 3 = "mem"
         s$[] = strsplit inp$[ii] " "
         ii += 1
         ind$ = substr s$[1] 5 len s$[1] - 5
         val = number s$[3]
         v = val
         bitv = 1
         for i = 0 to 35
            if v mod 2 = 1 and msk$[36 - i] = "0"
               val -= bitv
            elif v mod 2 = 0 and msk$[36 - i] = "1"
               val += bitv
            .
            v = v div 2
            bitv *= 2
         .
         call mem_wr1 ind$ val
      .
   .
   for i to len mem[]
      sum += mem[i]
   .
   print sum
.
call part1
# 
# 
func mem_wr ind$ val . .
   ind$[] = strchars ind$
   for k to len mem[]
      m$[] = strchars memi$[k]
      match = 1
      comb = 0
      n_comb = 1
      len pos[] 0
      for i to 36
         if m$[i] <> ind$[i]
            if m$[i] = "X"
               pos[] &= i
               comb *= 2
               if ind$[i] = "1"
                  comb += 1
               .
               n_comb *= 2
            elif ind$[i] <> "X"
               match = 0
               break 1
            .
         .
      .
      if match = 1
         del[] &= k
         for i = 0 to n_comb - 1
            if i <> comb
               v = i
               for j to len pos[]
                  m$[pos[j]] = v mod 2
                  v = v div 2
               .
               memi$[] &= strjoin m$[]
               mem[] &= mem[k]
            .
         .
      .
   .
   memi$[] &= ind$
   mem[] &= val
   # 
   for i to len del[]
      mem[del[i]] = mem[len mem[] - i + 1]
      memi$[del[i]] = memi$[len mem[] - i + 1]
   .
   len mem[] len mem[] - len del[]
   len memi$[] len memi$[] - len del[]
.
func part2 . .
   ii = 1
   while substr inp$[ii] 1 4 = "mask"
      s$[] = strsplit inp$[ii] " "
      ii += 1
      msk$[] = strchars s$[3]
      while substr inp$[ii] 1 3 = "mem"
         s$[] = strsplit inp$[ii] " "
         ii += 1
         ind = number substr s$[1] 5 len s$[1] - 5
         val = number s$[3]
         v = ind
         ind$ = ""
         for i = 0 to 35
            if msk$[36 - i] = "0"
               ind$ &= v mod 2
            else
               ind$ &= msk$[36 - i]
            .
            v = v div 2
         .
         call mem_wr ind$ val
      .
   .
   for k to len mem[]
      val = mem[k]
      ind$[] = strchars memi$[k]
      for i to 36
         if ind$[i] = "X"
            val *= 2
         .
      .
      sum += val
   .
   print sum
.
len mem[] 0
len memi$[] 0
call part2
# 
input_data
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1

mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0

