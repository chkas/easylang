# AoC-20 - Day 25: Combo Breaker
# 
publ1 = number input
publ2 = number input
# 
func crack_priv a .
   # 7 ^ x mod 20201227 = publ
   p = 1
   while p <> a
      p *= 7
      p = p mod 20201227
      x += 1
   .
   return x
.
func expmod a b .
   # a ^ b mod 20201227
   r = 1
   while b >= 1
      if b mod 2 = 1
         r = r * a mod 20201227
      .
      b = b div 2
      a = a * a mod 20201227
   .
   return r
.
priv1 = crack_priv publ1
print expmod publ2 priv1
# 
input_data
5764801
17807724

