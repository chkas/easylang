# AoC-20 - Day 15: Rambunctious Recitation
# 
inp[] = number strsplit input ","
# 
proc run n_turn .
   len a[] n_turn
   for turn to len inp[]
      n = inp[turn]
      a[n + 1] = turn
   .
   for turn = turn - 1 to n_turn - 1
      nn = turn - a[n + 1]
      if a[n + 1] = 0
         nn = 0
      .
      a[n + 1] = turn
      n = nn
   .
   print n
.
run 2020
run 30000000
# 
input_data
0,3,6


