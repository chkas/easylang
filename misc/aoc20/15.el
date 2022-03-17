# AoC-20 - Day 15: Rambunctious Recitation
# 
inp[] = number strsplit input ","
# 
func run n_turn . .
  len a[] n_turn
  for turn = 1 to len inp[]
    n = inp[turn - 1]
    a[n] = turn
  .
  for turn = turn to n_turn - 1
    nn = turn - a[n]
    if a[n] = 0
      nn = 0
    .
    a[n] = turn
    n = nn
  .
  print n
.
call run 2020
call run 30000000
# 
input_data
1,2,16,19,18,0



