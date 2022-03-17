# AoC-17 - Day 13: Packet Scanners
# 
len fw[] 100
# 
repeat
  s$ = input
  until s$ = ""
  h[] = number strsplit s$ " "
  fw[h[0]] = h[1] * 2 - 2
.
for i range 100
  if fw[i] > 0 and (i + d) mod fw[i] = 0
    sum += i * (fw[i] + 2) div 2
  .
.
print sum
for d range 10000000
  for i range 100
    if fw[i] > 0 and (i + d) mod fw[i] = 0
      break 1
    .
  .
  if i = 100
    print d
    break 1
  .
.
# 
input_data
0: 3
1: 2
2: 5
4: 4
6: 4
8: 6
10: 6
12: 6
14: 8
16: 6
18: 8
20: 8
22: 8
24: 12
26: 8
28: 12
30: 8
32: 12
34: 12
36: 14
38: 10
40: 12
42: 14
44: 10
46: 14
48: 12
50: 14
52: 12
54: 9
56: 14
58: 12
60: 12
64: 14
66: 12
70: 14
76: 20
78: 17
80: 14
84: 14
86: 14
88: 18
90: 20
92: 14
98: 18


