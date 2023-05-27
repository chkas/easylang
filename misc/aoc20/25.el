# AoC-20 - Day 25: Combo Breaker
# 
publ1 = number input
publ2 = number input
# 
proc crack_priv publ . res .
   prod = 1
   res = 0
   while prod <> publ
      prod *= 7
      prod = prod mod 20201227
      res += 1
   .
.
proc get_shared_secr priv publ . res .
   res = 1
   for _ to priv
      res *= publ
      res = res mod 20201227
   .
.
call crack_priv publ1 priv1
call get_shared_secr priv1 publ2 secr
print secr
# 
input_data
5764801
17807724

