# AoC-20 - Day 2: Password Philosophy
#
repeat
   s$ = input
   until s$ = ""
   s$[] = strtok s$ "- :"
   a = number s$[1]
   b = number s$[2]
   c$ = s$[3]
   h$[] = strchars s$[4]
   n = 0
   for h$ in h$[]
      n += if h$ = c$
   .
   cnt1 += if n >= a and n <= b
   n = if h$[a] = c$
   n += if h$[b] = c$
   cnt2 += if n = 1
.
print cnt1
print cnt2
#
input_data
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
