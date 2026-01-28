# AoC-15 - Day 16: Aunt Sue
#
name$[] = [ "children" "cats" "samoyeds" "pomeranians" "akitas" "vizslas" "goldfish" "trees" "cars" "perfumes" ]
cnt[] = [ 3 7 2 3 0 0 5 3 2 1 ]
#
proc getid n$ &id .
   for id to len name$[]
      if name$[id] = n$
         return
      .
   .
.
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
if len inp$[] = 0
   print "missing input"
.
for part to 2
   for s$ in inp$[]
      s$[] = strsplit s$ " "
      for i = 3 step 2 to 7
         n$ = substr s$[i] 1 (len s$[i] - 1)
         cnt = number s$[i + 1]
         getid n$ id
         if part = 2 and (n$ = "cat" or n$ = "trees")
            if cnt[id] >= cnt
               break 1
            .
         elif part = 2 and (n$ = "pomeranians" or n$ = "goldfish")
            if cnt[id] <= cnt
               break 1
            .
         elif cnt[id] <> number s$[i + 1]
            break 1
         .
      .
      if i > 7
         print substr s$[2] 1 (len s$[2] - 1)
      .
   .
.
#
input_data




