# AoC-25 - 12: Christmas Tree Farm
#
len pre[] 6
for i to 6
   s$ = input
   for j to 3 : for c$ in strchars input
      pre[i] += if c$ = "#"
   .
   s$ = input
   s$ = s$
.
repeat
   s$ = input
   until s$ = ""
   n[] = number strtok s$ "x: "
   sz = n[1] * n[2]
   s = 0
   for i = 1 to 6 : s += pre[i] * n[i + 2]
   if s <= sz : cnt += 1
.
print cnt
#
input_data
