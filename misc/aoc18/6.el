# AoC-18 - Day 6: Chronal Coordinates
# 
repeat
  s$ = input
  until s$ = ""
  a$[] = strsplit s$ ","
  x = number a$[0]
  y = number a$[1]
  max = higher max x
  max = higher max y
  x[] &= x
  y[] &= y
  col = 0
  for i range 3
    col = col * 10 + random 4 + 3
  .
  col[] &= col
  n[] &= 0
.
# 
max += 10
f = 100 / max
f1 = f * 1.3
f2 = f / 2
# 
func part1 . .
  background 000
  clear
  for y range max
    for x range max
      minmd = 9999
      for i range len x[]
        md = abs (x[i] - x) + abs (y[i] - y)
        if md <= minmd
          mini = i
          if md = minmd
            mini = -1
          .
          minmd = md
        .
      .
      if mini = -1
        color 000
      else
        if n[mini] <> -1
          n[mini] += 1
          if x = 0 or x = max - 1 or y = 0 or y = max - 1
            n[mini] = -1
          .
        .
        color col[mini]
      .
      move x * f y * f
      rect f1 f1
    .
  .
  color 000
  for i range len x[]
    move f * x[i] - f2 f * y[i] - f2
    rect 2 * f 2 * f
    if n[i] > mx
      mx = n[i]
      mi = i
    .
  .
  color 900
  move x[mi] * f - f y[mi] * f - f
  rect 3 * f 3 * f
  # 
  print mx
.
call part1
sleep 3
# 
# 
func part2 . .
  background 543
  clear
  color 242
  for y range max
    for x range max
      md = 0
      for i range len x[]
        md += abs (x[i] - x) + abs (y[i] - y)
      .
      if md < 10000
        save += 1
        move x * f y * f
        rect f1 f1
      .
    .
  .
  color 000
  for i range len x[]
    move f * x[i] - f2 f * y[i] - f2
    rect 2 * f 2 * f
  .
  print save
.
call part2
# 
input_data
137, 282
229, 214
289, 292
249, 305
90, 289
259, 316
134, 103
96, 219
92, 308
269, 59
141, 132
71, 200
337, 350
40, 256
236, 105
314, 219
295, 332
114, 217
43, 202
160, 164
245, 303
339, 277
310, 316
164, 44
196, 335
228, 345
41, 49
84, 298
43, 51
158, 347
121, 51
176, 187
213, 120
174, 133
259, 263
210, 205
303, 233
265, 98
359, 332
186, 340
132, 99
174, 153
206, 142
341, 162
180, 166
152, 249
221, 118
95, 227
152, 186
72, 330


