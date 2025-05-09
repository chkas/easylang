# AoC-15 - Day 7: Some Assembly Required
#
global name$[] r[] .
proc getid n$ &id .
   for id to len name$[]
      if name$[id] = n$
         break 2
      .
   .
   name$[] &= n$
   r[] &= -1
.
proc gval s$ &r .
   r = number s$
   if error = 1
      getid s$ h
      r = r[h]
   .
.
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
for part to 2
   for i to len r[]
      r[i] = -1
   .
   repeat
      done = 1
      for s$ in inp$[]
         r = -1
         s$[] = strsplit s$ " "
         if len s$[] = 3
            getid s$[3] di
            gval s$[1] r
            if part = 2 and s$[3] = "b"
               r = av
            .
         elif s$[1] = "NOT"
            getid s$[4] di
            gval s$[2] h
            if h <> -1
               r = bitnot h
            .
         else
            gval s$[1] a
            gval s$[3] b
            getid s$[5] di
            if a <> -1 and b <> -1
               if s$[2] = "AND"
                  r = bitand a b
               elif s$[2] = "OR"
                  r = bitor a b
               elif s$[2] = "LSHIFT"
                  r = bitshift a b
               elif s$[2] = "RSHIFT"
                  r = bitshift a -b
               else
                  print "error"
               .
            .
         .
         if r <> -1
            r[di] = r mod 65536
         else
            done = 0
         .
      .
      until done = 1
   .
   getid "a" h
   print r[h]
   av = r[h]
.
#
input_data
123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> a
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i

