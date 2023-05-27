# AoC-21 - Day 3: Binary Diagnostic
# 
# The only tricky part is the "find"
# function, which works for both oxygen
# and CO2 by passing 0 or 1.
# 
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
nbits = len inp$[1]
# 
proc binval s$ . v .
   v = 0
   for b$ in strchars s$
      v = v * 2 + number b$
   .
.
# 
proc part_1 . .
   len cnt[] nbits
   for ln$ in inp$[]
      for i = 1 to nbits
         cnt[i] += number substr ln$ i 1
      .
   .
   for cnt in cnt[]
      h = if cnt >= len inp$[] / 2
      gam$ &= h
      eps$ &= 1 - h
   .
   call binval gam$ gam
   call binval eps$ eps
   print gam * eps
.
call part_1
# 
proc find bit ln$[] . val .
   for i = 1 to nbits
      cnt = 0
      for ln$ in ln$[]
         cnt += number substr ln$ i 1
      .
      b$ = bit
      if cnt < len ln$[] / 2
         b$ = 1 - bit
      .
      for ln = 1 to len ln$[]
         if substr ln$[ln] i 1 = b$
            ln_nxt$[] &= ln$[ln]
         .
      .
      if len ln_nxt$[] = 1
         call binval ln_nxt$[1] val
         break 2
      .
      swap ln_nxt$[] ln$[]
      len ln_nxt$[] 0
   .
   print "error"
.
call find 1 inp$[] oxy
call find 0 inp$[] co2
print oxy * co2
# 
# 
input_data
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010

