# AoC-20 - Day 9: Encoding Error
# 
npr = 26
repeat
   s$ = input
   until s$ = ""
   inp[] &= number s$
.
if len inp[] < 100
   npr = 5
.
for i = npr + 1 to len inp[]
   is_sum = 0
   for k = i - npr + 1 to i - 1
      for l = i - npr to k - 1
         if inp[i] = inp[k] + inp[l]
            is_sum = 1
         .
      .
   .
   if is_sum = 0
      nr = inp[i]
   .
.
print nr
for i = 2 to len inp[]
   s = 0
   for j = i downto 1
      s += inp[j]
      if s = nr
         min = inp[j]
         max = min
         for k = j + 1 to i - 1
            max = higher inp[k] max
            min = lower inp[k] min
         .
         print max + min
         break 2
      .
   .
.
# 
input_data
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
