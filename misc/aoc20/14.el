# AoC-20 - Day 14: Docking Data
#
repeat
   inp$ = input
   until inp$ = ""
   inp$[] &= inp$
.
inp$[] &= "end"
#
proc mkmask s$ &mbin &mmsk .
   mbin = 0
   mmsk = 0
   for c$ in strchars s$
      mbin *= 2
      mmsk *= 2
      if c$ = "X"
         mmsk += 1
      elif c$ = "1"
         mbin += 1
      .
   .
.
proc wrmem addr val &mema[] &mem[] .
   for i to len mem[] : if mema[i] = addr
      mem[i] = val
      return
   .
   mema[] &= addr
   mem[] &= val
.
proc part1 .
   ii = 1
   while substr inp$[ii] 1 4 = "mask"
      mkmask substr inp$[ii] 8 99 mbin mmsk
      ii += 1
      while substr inp$[ii] 1 3 = "mem"
         s$[] = strtok inp$[ii] " []="
         ii += 1
         addr = number s$[2]
         val = number s$[3]
         val = bitand val mmsk
         val = bitor val mbin
         #
         wrmem addr val mema[] mem[]
      .
   .
   for i to len mem[] : sum += mem[i]
   print sum
.
part1
#
proc wrmem2 addr$ val &mema$[] &mem[] .
   addr$[] = strchars addr$
   nmem = len mem[]
   for k to nmem : if mema$[k] <> ""
      mem$[] = strchars mema$[k]
      comb = 0
      n_comb = 1
      len pos[] 0
      for i to 36 : if mem$[i] <> addr$[i]
         if mem$[i] = "X"
            pos[] &= i
            comb *= 2
            if addr$[i] = "1" : comb += 1
            n_comb *= 2
         elif addr$[i] <> "X"
            break 1
         .
      .
      if i > 36
         for co = 0 to n_comb - 1 : if co <> comb
            v = co
            for j = len pos[] downto 1
               mem$[pos[j]] = v mod 2
               v = v div 2
            .
            mema$[] &= strjoin mem$[] ""
            mem[] &= mem[k]
         .
         mema$[k] = ""
      .
   .
   mema$[] &= addr$
   mem[] &= val
.
#
proc part2 .
   ii = 1
   while ii <= len inp$[]
      msk$[] = strchars substr inp$[ii] 8 99
      ii += 1
      while ii <= len inp$[] and substr inp$[ii] 1 3 = "mem"
         s$[] = strtok inp$[ii] " []="
         ii += 1
         addr = number s$[2]
         addr$ = ""
         for i = 0 to 35
            if msk$[36 - i] = "0"
               addr$ &= addr mod 2
            else
               addr$ &= msk$[36 - i]
            .
            addr = addr div 2
         .
         wrmem2 addr$ number s$[3] mema$[] mem[]
      .
   .
   for k to len mem[] : if mema$[k] <> ""
      val = mem[k]
      for c$ in strchars mema$[k]
         if c$ = "X" : val *= 2
      .
      sum += val
   .
   print sum
.
part2
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

