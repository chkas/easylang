# AoC-16 - Day 19: An Elephant Named Joseph
# 
n = number input
# 
a = n
sk = 1
repeat
  d = a mod 2
  a = a div 2
  until a = 0
  sk *= 2
  elf = (elf + sk * d) mod n
.
print elf + 1
# 
# Part 2
# 
for i range n
  nxt[] &= (i + 1) mod n
.
mid = n div 2 - 1
jmp = n mod 2
while nxt[mid] <> mid
  nxt[mid] = nxt[nxt[mid]]
  if jmp = 1
    mid = nxt[mid]
  .
  jmp = 1 - jmp
.
pr mid + 1
#  
# 
input_data
3005290

