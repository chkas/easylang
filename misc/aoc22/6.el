# AoC-22 - Day 6: Tuning Trouble
# 
for c$ in strchars input
   in[] &= strcode c$ - strcode "a" + 1
.
proc tune n . .
   len a[] 26
   for i = 1 to len in[]
      if i > n
         a[in[i - n]] -= 1
         if a[in[i - n]] = 0
            cnt -= 1
         .
      .
      a[in[i]] += 1
      if a[in[i]] = 1
         cnt += 1
      .
      if cnt = n
         print i
         break 1
      .
   .
.
call tune 4
call tune 14
# 
input_data
nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg

