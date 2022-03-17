# AoC-17 - Day 15: Dueling Generators
# 
a = number substr input 24 9
b = number substr input 24 9
a2 = a
b2 = b
# 
for i range 40000000
  a = (a * 16807) mod 2147483647
  b = (b * 48271) mod 2147483647
  if a mod 65536 = b mod 65536
    match += 1
  .
.
print match
a = a2
b = b2
match = 0
for i range 5000000
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
# 
input_data
Generator A starts with 783
Generator B starts with 325


