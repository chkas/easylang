# AoC-20 - Day 25: Combo Breaker
# 
publ1 = number input
publ2 = number input
# 
func crack_priv publ . res .
  prod = 1
  res = 0
  while prod <> publ
    prod *= 7
    prod = prod mod 20201227
    res += 1
  .
.
func get_shared_secr priv publ . res .
  res = 1
  for _ range priv
    res *= publ
    res = res mod 20201227
  .
.
call crack_priv publ1 priv1
call get_shared_secr priv1 publ2 secr
print secr
# 
# 
input_data
10441485
1004920

