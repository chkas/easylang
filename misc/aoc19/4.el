# AoC-19 - Day 4: Secure Container
# 
inp[] = number strsplit input "-"
proc part1 . .
   for i = inp[1] to inp[2]
      ok = 1
      ok2 = 0
      h = i
      m = 10
      while h > 0
         if h mod 10 > m
            ok = 0
         elif h mod 10 = m
            ok2 = 1
         .
         m = h mod 10
         h = h div 10
      .
      ans += (ok + ok2) div 2
   .
   print ans
.
part1
# 
proc part2 . .
   for i = inp[1] to inp[2]
      ok = 1
      ok2 = 0
      h = i
      m = 10
      cnt = 0
      while h > 0
         if h mod 10 > m
            ok = 0
         .
         if h mod 10 = m
            cnt += 1
         else
            if cnt = 1
               ok2 = 1
            .
            cnt = 0
         .
         m = h mod 10
         h = h div 10
      .
      if cnt = 1
         ok2 = 1
      .
      ans += (ok + ok2) div 2
   .
   print ans
.
part2
# 
input_data
10000-20000



