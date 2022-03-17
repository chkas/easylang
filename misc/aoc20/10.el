# AoC-20 - Day 10: Adapter Array
# 
d[] &= 0
repeat
  s$ = input
  until s$ = ""
  d[] &= number s$
.
# sort
for i = 0 to len d[] - 2
  for j = i + 1 to len d[] - 1
    if d[j] < d[i]
      swap d[i] d[j]
    .
  .
.
# 
func part1 . .
  d = d[1]
  for i = 2 to len d[] - 1
    if d[i] - d = 1
      s1 += 1
    elif d[i] - d = 3
      s3 += 1
    .
    d = d[i]
  .
  s1 += 1
  s3 += 1
  print s1 * s3
.
call part1
# 
len cache[] d[len d[] - 1]
# 
func find_ways ind0 . n0 .
  if ind0 = len d[] - 1
    n0 = 1
    break 1
  .
  if cache[ind0] > 0
    n0 = cache[ind0]
    break 1
  .
  n0 = 0
  ind = ind0 + 1
  while ind < len d[] and d[ind] - d[ind0] <= 3
    call find_ways ind n
    n0 += n
    ind += 1
  .
  cache[ind0] = n0
.
call find_ways 0 n
print n
# 
input_data
133
157
39
74
108
136
92
55
86
46
111
58
80
115
84
67
98
30
40
61
71
114
17
9
123
142
49
158
107
139
104
132
155
96
91
15
11
23
54
6
63
126
3
10
116
87
68
72
109
62
134
103
1
16
101
117
35
120
151
102
85
145
135
79
2
147
33
41
93
52
48
64
81
29
20
110
129
43
148
36
53
26
42
156
154
77
88
73
27
34
12
146
78
47
28
97


