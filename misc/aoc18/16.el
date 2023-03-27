# AoC-18 - Day 16: Chronal Classification
# 
global b[][] o[][] a[][] .
# 
func read . .
   len b[] 4
   len o[] 4
   len a[] 4
   repeat
      s$ = input
      until s$ = ""
      b[1] = number substr s$ 10 1
      b[2] = number substr s$ 13 1
      b[3] = number substr s$ 16 1
      b[4] = number substr s$ 19 1
      o[] = number strsplit input " "
      s$ = input
      a[1] = number substr s$ 10 1
      a[2] = number substr s$ 13 1
      a[3] = number substr s$ 16 1
      a[4] = number substr s$ 19 1
      b[][] &= b[]
      o[][] &= o[]
      a[][] &= a[]
      _$ = input
   .
.
call read
# 
len r[] 4
# 
func opf op a b c . .
   if op = 0
      r[c] = r[a] + r[b]
   elif op = 1
      r[c] = r[a] + b
   elif op = 2
      r[c] = r[a] * r[b]
   elif op = 3
      r[c] = r[a] * b
      # 
   elif op = 4
      h = bitand r[a] r[b]
      r[c] = h
   elif op = 5
      h = bitand r[a] b
      r[c] = h
   elif op = 6
      h = bitor r[a] r[b]
      r[c] = h
   elif op = 7
      h = bitor r[a] b
      r[c] = h
      # 
   elif op = 8
      r[c] = r[a]
   elif op = 9
      r[c] = a
      # 
   elif op = 10
      if a > r[b]
         r[c] = 1
      else
         r[c] = 0
      .
   elif op = 11
      if r[a] > b
         r[c] = 1
      else
         r[c] = 0
      .
   elif op = 12
      if r[a] > r[b]
         r[c] = 1
      else
         r[c] = 0
      .
      # 
   elif op = 13
      if a = r[b]
         r[c] = 1
      else
         r[c] = 0
      .
   elif op = 14
      if r[a] = b
         r[c] = 1
      else
         r[c] = 0
      .
   elif op = 15
      if r[a] = r[b]
         r[c] = 1
      else
         r[c] = 0
      .
   .
.
func part1 . .
   for tst = 1 to len b[][]
      ok = 0
      for op range0 16
         r[] = b[tst][]
         arrbase r[] 0
         call opf op o[tst][2] o[tst][3] o[tst][4]
         for i range0 4
            if r[i] <> a[tst][i + 1]
               break 1
            .
         .
         if i = 4
            ok += 1
         .
      .
      if ok >= 3
         part1 += 1
      .
   .
   print part1
.
call part1
# 
func part2 . .
   len op[] 16
   len op_match[] 16
   arrbase op[] 0
   arrbase op_match[] 0
   # 
   for i range0 16
      op[i] = -1
   .
   for _ range0 16
      for tst_op range0 16
         if op[tst_op] = -1
            n_match = 0
            for op range0 16
               if op_match[op] = 0
                  for tst = 1 to len b[][]
                     if o[tst][1] = tst_op
                        r[] = b[tst][]
                        arrbase r[] 0
                        call opf op o[tst][2] o[tst][3] o[tst][4]
                        for i range0 4
                           if r[i] <> a[tst][i + 1]
                              break 2
                           .
                        .
                     .
                  .
                  if tst > len b[][]
                     n_match += 1
                     op_match = op
                  .
               .
            .
            if n_match = 1
               op[tst_op] = op_match
               op_match[op_match] = 1
               break 1
            .
         .
      .
   .
   s$ = input
   r[] = [ 0 0 0 0 ]
   arrbase r[] 0
   repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ " "
      call opf op[number s$[1]] number s$[2] number s$[3] number s$[4]
   .
   print r[0]
.
call part2
# 
input_data
Before: [3, 2, 1, 1]
9 2 1 2
After:  [3, 2, 2, 1]



