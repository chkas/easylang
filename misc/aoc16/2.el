# AoC-16 - Day 2: Bathroom Security
#
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
subr key
   for s$ in inp$[]
      for b$ in strchars s$
         if b$ = "U"
            d = -nc
         elif b$ = "R"
            d = 1
         elif b$ = "D"
            d = nc
         else
            d = -1
         .
         if pad[p + d] <> 0
            p += d
         .
      .
      h = pad[p]
      if h <= 9
         write h
      else
         write strchar (h + 55)
      .
   .
   print ""
.
pad[] = [ 0 0 0 0 0 0 1 2 3 0 0 4 5 6 0 0 7 8 9 0 0 0 0 0 0 ]
nc = 5
p = 13
key
#
pad[] = [ 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 2 3 4 0 0 0 5 6 7 8 9 0 0 0 10 11 12 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 ]
nc = 7
p = 23
key
#
input_data
ULL
RRDDD
LURDL
UUUUD

