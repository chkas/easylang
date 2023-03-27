# AoC-20 - Day 2: Password Philosophy
# 
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ " "
   a[] = number strsplit s$[1] "-"
   c$ = substr s$[2] 1 1
   h$[] = strchars s$[3]
   n = 0
   for h$ in h$[]
      n += if h$ = c$
   .
   cnt1 += if n >= a[1] and n <= a[2]
   n = if h$[a[1]] = c$
   n += if h$[a[2]] = c$
   cnt2 += if n = 1
.
print cnt1
print cnt2
# 
input_data
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc

