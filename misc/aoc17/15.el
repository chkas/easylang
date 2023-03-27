# AoC-17 - Day 15: Dueling Generators
# 
a0 = number substr input 25 9
b0 = number substr input 25 9
# 
func part1 a b . .
   for i to 40000000
      a = (a * 16807) mod 2147483647
      b = (b * 48271) mod 2147483647
      if a mod 65536 = b mod 65536
         match += 1
      .
   .
   print match
.
call part1 a0 b0
# 
func part2 a b . .
   for i to 5000000
      repeat
         a = (a * 16807) mod 2147483647
         until a mod 4 = 0
      .
      repeat
         b = (b * 48271) mod 2147483647
         until b mod 8 = 0
      .
      if a mod 65536 = b mod 65536
         match += 1
      .
   .
   print match
.
call part2 a0 b0
# 
input_data
Generator A starts with 65
Generator B starts with 8921



