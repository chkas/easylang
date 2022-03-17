# AoC-18 - Day 16: Chronal Classification
# 
global b[][] o[][] a[][] .
# 
func read . .
  len b[] 4
  len o[] 4
  len a[] 4
  repeat
    s$ = input
    until s$ = ""
    b[0] = number substr s$ 9 1
    b[1] = number substr s$ 12 1
    b[2] = number substr s$ 15 1
    b[3] = number substr s$ 18 1
    s$[] = strsplit input " "
    o[0] = number s$[0]
    o[1] = number s$[1]
    o[2] = number s$[2]
    o[3] = number s$[3]
    s$ = input
    a[0] = number substr s$ 9 1
    a[1] = number substr s$ 12 1
    a[2] = number substr s$ 15 1
    a[3] = number substr s$ 18 1
    b[][] &= b[]
    o[][] &= o[]
    a[][] &= a[]
    _$ = input
  .
.
call read
# 
len r[] 4
# 
func opf op a b c . .
  if op = 0
    r[c] = r[a] + r[b]
  elif op = 1
    r[c] = r[a] + b
  elif op = 2
    r[c] = r[a] * r[b]
  elif op = 3
    r[c] = r[a] * b
    # 
  elif op = 4
    h = bitand r[a] r[b]
    r[c] = h
  elif op = 5
    h = bitand r[a] b
    r[c] = h
  elif op = 6
    h = bitor r[a] r[b]
    r[c] = h
  elif op = 7
    h = bitor r[a] b
    r[c] = h
    # 
  elif op = 8
    r[c] = r[a]
  elif op = 9
    r[c] = a
    # 
  elif op = 10
    if a > r[b]
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 11
    if r[a] > b
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 12
    if r[a] > r[b]
      r[c] = 1
    else
      r[c] = 0
    .
    # 
  elif op = 13
    if a = r[b]
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 14
    if r[a] = b
      r[c] = 1
    else
      r[c] = 0
    .
  elif op = 15
    if r[a] = r[b]
      r[c] = 1
    else
      r[c] = 0
    .
  .
.
func part1 . .
  for tst range len b[][]
    ok = 0
    for op range 16
      r[] = b[tst][]
      call opf op o[tst][1] o[tst][2] o[tst][3]
      for i range 4
        if r[i] <> a[tst][i]
          break 1
        .
      .
      if i = 4
        ok += 1
      .
    .
    if ok >= 3
      part1 += 1
    .
  .
  pr part1
.
call part1
# 
func part2 . .
  len op[] 16
  len op_match[] 16
  # 
  for i range 16
    op[i] = -1
  .
  for _ range 16
    for tst_op range 16
      if op[tst_op] = -1
        n_match = 0
        for op range 16
          if op_match[op] = 0
            for tst range len b[][]
              if o[tst][0] = tst_op
                r[] = b[tst][]
                call opf op o[tst][1] o[tst][2] o[tst][3]
                for i range 4
                  if r[i] <> a[tst][i]
                    break 2
                  .
                .
              .
            .
            if tst = len b[][]
              n_match += 1
              op_match = op
            .
          .
        .
        if n_match = 1
          op[tst_op] = op_match
          op_match[op_match] = 1
          break 1
        .
      .
    .
  .
  s$ = input
  r[] = [ 0 0 0 0 ]
  repeat
    s$ = input
    until s$ = ""
    s$[] = strsplit s$ " "
    call opf op[number s$[0]] number s$[1] number s$[2] number s$[3]
  .
  print r[0]
.
call part2
# 
input_data
Before: [3, 0, 0, 1]
0 3 0 2
After:  [3, 0, 1, 1]

Before: [2, 0, 0, 2]
4 0 3 1
After:  [2, 1, 0, 2]

Before: [0, 1, 1, 1]
14 0 0 2
After:  [0, 1, 0, 1]

Before: [3, 0, 1, 1]
11 0 0 3
After:  [3, 0, 1, 1]

Before: [1, 2, 2, 0]
9 0 2 1
After:  [1, 0, 2, 0]

Before: [0, 2, 3, 3]
11 2 2 3
After:  [0, 2, 3, 1]

Before: [2, 0, 1, 2]
4 0 3 2
After:  [2, 0, 1, 2]

Before: [2, 0, 2, 2]
6 3 3 3
After:  [2, 0, 2, 0]

Before: [0, 1, 2, 2]
1 1 2 3
After:  [0, 1, 2, 0]

Before: [0, 3, 0, 0]
14 0 0 0
After:  [0, 3, 0, 0]

Before: [2, 2, 0, 2]
4 0 3 3
After:  [2, 2, 0, 1]

Before: [2, 3, 2, 1]
13 2 2 0
After:  [1, 3, 2, 1]

Before: [2, 1, 1, 2]
4 0 3 1
After:  [2, 1, 1, 2]

Before: [1, 2, 2, 1]
9 0 2 0
After:  [0, 2, 2, 1]

Before: [2, 2, 0, 2]
4 0 3 1
After:  [2, 1, 0, 2]

Before: [1, 0, 2, 3]
9 0 2 1
After:  [1, 0, 2, 3]

Before: [1, 1, 3, 2]
10 1 3 1
After:  [1, 0, 3, 2]

Before: [0, 2, 1, 3]
14 0 0 1
After:  [0, 0, 1, 3]

Before: [2, 1, 2, 1]
11 0 0 1
After:  [2, 1, 2, 1]

Before: [1, 1, 2, 2]
3 2 3 1
After:  [1, 2, 2, 2]

Before: [3, 0, 2, 3]
8 1 0 1
After:  [3, 0, 2, 3]

Before: [1, 3, 2, 2]
9 0 2 2
After:  [1, 3, 0, 2]

Before: [2, 0, 3, 2]
4 0 3 2
After:  [2, 0, 1, 2]

Before: [2, 1, 1, 2]
10 1 3 1
After:  [2, 0, 1, 2]

Before: [2, 1, 2, 3]
1 1 2 2
After:  [2, 1, 0, 3]

Before: [3, 1, 2, 1]
1 1 2 3
After:  [3, 1, 2, 0]

Before: [2, 2, 2, 3]
5 2 2 1
After:  [2, 2, 2, 3]

Before: [2, 0, 2, 2]
4 0 3 2
After:  [2, 0, 1, 2]

Before: [2, 3, 1, 1]
11 0 0 0
After:  [1, 3, 1, 1]

Before: [2, 3, 2, 2]
4 0 3 1
After:  [2, 1, 2, 2]

Before: [3, 1, 3, 0]
0 1 0 1
After:  [3, 1, 3, 0]

Before: [3, 1, 2, 3]
12 3 0 3
After:  [3, 1, 2, 1]

Before: [1, 0, 3, 1]
6 3 3 1
After:  [1, 0, 3, 1]

Before: [0, 1, 2, 3]
1 1 2 3
After:  [0, 1, 2, 0]

Before: [1, 2, 1, 3]
2 1 3 1
After:  [1, 0, 1, 3]

Before: [1, 2, 2, 3]
9 0 2 2
After:  [1, 2, 0, 3]

Before: [3, 3, 3, 2]
11 0 2 1
After:  [3, 1, 3, 2]

Before: [2, 1, 0, 2]
10 1 3 3
After:  [2, 1, 0, 0]

Before: [3, 3, 3, 3]
5 3 3 0
After:  [3, 3, 3, 3]

Before: [0, 3, 2, 0]
13 0 0 0
After:  [1, 3, 2, 0]

Before: [3, 0, 2, 2]
3 2 3 3
After:  [3, 0, 2, 2]

Before: [1, 3, 2, 1]
9 0 2 1
After:  [1, 0, 2, 1]

Before: [1, 1, 2, 3]
1 1 2 0
After:  [0, 1, 2, 3]

Before: [1, 1, 0, 2]
15 1 0 1
After:  [1, 1, 0, 2]

Before: [0, 1, 1, 3]
2 2 3 3
After:  [0, 1, 1, 0]

Before: [3, 1, 3, 3]
0 3 0 3
After:  [3, 1, 3, 3]

Before: [0, 0, 3, 3]
14 0 0 3
After:  [0, 0, 3, 0]

Before: [2, 1, 2, 2]
1 1 2 2
After:  [2, 1, 0, 2]

Before: [2, 1, 0, 2]
4 0 3 0
After:  [1, 1, 0, 2]

Before: [2, 1, 2, 1]
7 3 2 0
After:  [1, 1, 2, 1]

Before: [3, 1, 2, 2]
10 1 3 2
After:  [3, 1, 0, 2]

Before: [3, 1, 1, 3]
0 1 0 2
After:  [3, 1, 1, 3]

Before: [3, 0, 2, 1]
7 3 2 0
After:  [1, 0, 2, 1]

Before: [2, 2, 0, 2]
4 0 3 0
After:  [1, 2, 0, 2]

Before: [0, 3, 3, 3]
13 3 3 0
After:  [1, 3, 3, 3]

Before: [2, 1, 2, 3]
5 3 3 3
After:  [2, 1, 2, 3]

Before: [1, 1, 2, 1]
7 3 2 0
After:  [1, 1, 2, 1]

Before: [3, 0, 1, 3]
2 2 3 2
After:  [3, 0, 0, 3]

Before: [0, 2, 2, 1]
14 0 0 2
After:  [0, 2, 0, 1]

Before: [0, 3, 3, 1]
14 0 0 2
After:  [0, 3, 0, 1]

Before: [0, 1, 2, 2]
3 2 3 0
After:  [2, 1, 2, 2]

Before: [0, 3, 2, 0]
14 0 0 1
After:  [0, 0, 2, 0]

Before: [0, 1, 2, 2]
10 1 3 0
After:  [0, 1, 2, 2]

Before: [1, 3, 2, 1]
7 3 2 1
After:  [1, 1, 2, 1]

Before: [1, 0, 2, 3]
9 0 2 3
After:  [1, 0, 2, 0]

Before: [0, 3, 2, 2]
6 3 3 0
After:  [0, 3, 2, 2]

Before: [0, 0, 0, 3]
13 3 3 0
After:  [1, 0, 0, 3]

Before: [2, 0, 2, 2]
3 2 3 0
After:  [2, 0, 2, 2]

Before: [0, 0, 2, 2]
3 2 3 3
After:  [0, 0, 2, 2]

Before: [2, 2, 2, 1]
7 3 2 0
After:  [1, 2, 2, 1]

Before: [3, 3, 1, 3]
0 3 0 2
After:  [3, 3, 3, 3]

Before: [1, 1, 1, 1]
15 1 0 3
After:  [1, 1, 1, 1]

Before: [1, 2, 2, 0]
9 0 2 3
After:  [1, 2, 2, 0]

Before: [2, 2, 2, 1]
12 2 0 2
After:  [2, 2, 1, 1]

Before: [2, 1, 2, 2]
1 1 2 0
After:  [0, 1, 2, 2]

Before: [1, 0, 2, 2]
5 2 2 2
After:  [1, 0, 2, 2]

Before: [0, 0, 2, 2]
3 2 3 1
After:  [0, 2, 2, 2]

Before: [0, 1, 0, 2]
10 1 3 1
After:  [0, 0, 0, 2]

Before: [3, 1, 1, 3]
2 2 3 1
After:  [3, 0, 1, 3]

Before: [0, 2, 1, 0]
8 0 1 3
After:  [0, 2, 1, 0]

Before: [1, 1, 3, 3]
2 1 3 0
After:  [0, 1, 3, 3]

Before: [0, 0, 2, 2]
14 0 0 0
After:  [0, 0, 2, 2]

Before: [1, 2, 2, 3]
9 0 2 3
After:  [1, 2, 2, 0]

Before: [2, 2, 1, 3]
5 3 3 1
After:  [2, 3, 1, 3]

Before: [2, 2, 2, 2]
4 0 3 0
After:  [1, 2, 2, 2]

Before: [0, 0, 3, 0]
14 0 0 3
After:  [0, 0, 3, 0]

Before: [3, 2, 2, 0]
12 2 1 1
After:  [3, 1, 2, 0]

Before: [2, 1, 1, 2]
4 0 3 2
After:  [2, 1, 1, 2]

Before: [3, 2, 2, 3]
5 3 3 3
After:  [3, 2, 2, 3]

Before: [3, 2, 2, 2]
3 2 3 0
After:  [2, 2, 2, 2]

Before: [0, 0, 0, 1]
6 3 3 0
After:  [0, 0, 0, 1]

Before: [1, 1, 0, 0]
15 1 0 1
After:  [1, 1, 0, 0]

Before: [0, 0, 1, 1]
14 0 0 2
After:  [0, 0, 0, 1]

Before: [1, 3, 0, 3]
13 3 3 1
After:  [1, 1, 0, 3]

Before: [1, 1, 3, 1]
15 1 0 3
After:  [1, 1, 3, 1]

Before: [1, 1, 2, 1]
5 2 2 2
After:  [1, 1, 2, 1]

Before: [3, 2, 2, 1]
7 3 2 1
After:  [3, 1, 2, 1]

Before: [1, 1, 2, 0]
15 1 0 2
After:  [1, 1, 1, 0]

Before: [0, 0, 3, 0]
11 2 2 0
After:  [1, 0, 3, 0]

Before: [0, 2, 2, 3]
12 2 1 2
After:  [0, 2, 1, 3]

Before: [0, 0, 3, 2]
14 0 0 3
After:  [0, 0, 3, 0]

Before: [1, 3, 2, 3]
13 2 2 2
After:  [1, 3, 1, 3]

Before: [1, 1, 2, 1]
7 3 2 3
After:  [1, 1, 2, 1]

Before: [0, 1, 3, 0]
8 0 1 1
After:  [0, 0, 3, 0]

Before: [1, 0, 2, 2]
9 0 2 0
After:  [0, 0, 2, 2]

Before: [0, 1, 0, 3]
8 0 1 3
After:  [0, 1, 0, 0]

Before: [0, 2, 1, 3]
2 1 3 3
After:  [0, 2, 1, 0]

Before: [2, 3, 2, 3]
11 0 0 0
After:  [1, 3, 2, 3]

Before: [0, 0, 2, 1]
6 3 3 3
After:  [0, 0, 2, 0]

Before: [2, 2, 3, 2]
11 0 0 0
After:  [1, 2, 3, 2]

Before: [3, 1, 2, 1]
7 3 2 1
After:  [3, 1, 2, 1]

Before: [0, 2, 2, 1]
7 3 2 1
After:  [0, 1, 2, 1]

Before: [0, 1, 0, 3]
14 0 0 1
After:  [0, 0, 0, 3]

Before: [1, 1, 2, 1]
9 0 2 3
After:  [1, 1, 2, 0]

Before: [0, 3, 3, 3]
8 0 1 3
After:  [0, 3, 3, 0]

Before: [0, 3, 0, 3]
13 3 3 3
After:  [0, 3, 0, 1]

Before: [0, 2, 2, 3]
8 0 3 0
After:  [0, 2, 2, 3]

Before: [2, 3, 2, 1]
12 2 0 0
After:  [1, 3, 2, 1]

Before: [0, 3, 3, 0]
8 0 1 0
After:  [0, 3, 3, 0]

Before: [1, 1, 1, 2]
10 1 3 3
After:  [1, 1, 1, 0]

Before: [0, 3, 1, 1]
8 0 3 0
After:  [0, 3, 1, 1]

Before: [2, 1, 3, 3]
2 1 3 0
After:  [0, 1, 3, 3]

Before: [1, 1, 2, 3]
1 1 2 2
After:  [1, 1, 0, 3]

Before: [3, 3, 2, 3]
2 2 3 3
After:  [3, 3, 2, 0]

Before: [0, 1, 1, 3]
13 3 2 0
After:  [0, 1, 1, 3]

Before: [0, 2, 0, 2]
13 0 0 1
After:  [0, 1, 0, 2]

Before: [3, 1, 2, 3]
1 1 2 0
After:  [0, 1, 2, 3]

Before: [0, 3, 3, 3]
11 2 2 1
After:  [0, 1, 3, 3]

Before: [0, 2, 3, 2]
8 0 2 3
After:  [0, 2, 3, 0]

Before: [3, 1, 1, 0]
0 1 0 0
After:  [1, 1, 1, 0]

Before: [2, 1, 2, 1]
0 2 0 3
After:  [2, 1, 2, 2]

Before: [0, 1, 2, 3]
13 3 3 1
After:  [0, 1, 2, 3]

Before: [1, 0, 2, 0]
9 0 2 3
After:  [1, 0, 2, 0]

Before: [3, 1, 2, 0]
11 0 0 0
After:  [1, 1, 2, 0]

Before: [0, 2, 1, 0]
14 0 0 1
After:  [0, 0, 1, 0]

Before: [2, 1, 3, 2]
4 0 3 3
After:  [2, 1, 3, 1]

Before: [0, 2, 2, 3]
2 1 3 0
After:  [0, 2, 2, 3]

Before: [2, 3, 3, 1]
11 2 2 1
After:  [2, 1, 3, 1]

Before: [0, 2, 2, 1]
12 2 1 2
After:  [0, 2, 1, 1]

Before: [2, 3, 2, 2]
3 2 3 2
After:  [2, 3, 2, 2]

Before: [2, 3, 3, 2]
4 0 3 0
After:  [1, 3, 3, 2]

Before: [3, 1, 3, 3]
0 3 0 0
After:  [3, 1, 3, 3]

Before: [0, 2, 1, 3]
8 0 3 2
After:  [0, 2, 0, 3]

Before: [2, 1, 2, 2]
3 2 3 3
After:  [2, 1, 2, 2]

Before: [2, 2, 2, 2]
12 2 1 1
After:  [2, 1, 2, 2]

Before: [2, 1, 2, 2]
3 2 3 1
After:  [2, 2, 2, 2]

Before: [3, 0, 3, 3]
0 3 0 2
After:  [3, 0, 3, 3]

Before: [1, 0, 3, 0]
11 2 2 3
After:  [1, 0, 3, 1]

Before: [0, 2, 2, 0]
12 2 1 1
After:  [0, 1, 2, 0]

Before: [1, 1, 0, 0]
15 1 0 2
After:  [1, 1, 1, 0]

Before: [2, 1, 0, 2]
4 0 3 1
After:  [2, 1, 0, 2]

Before: [1, 2, 2, 3]
2 2 3 2
After:  [1, 2, 0, 3]

Before: [3, 1, 2, 3]
2 1 3 1
After:  [3, 0, 2, 3]

Before: [1, 1, 1, 3]
15 1 0 2
After:  [1, 1, 1, 3]

Before: [1, 2, 3, 0]
11 2 2 3
After:  [1, 2, 3, 1]

Before: [1, 1, 0, 2]
15 1 0 2
After:  [1, 1, 1, 2]

Before: [3, 1, 3, 2]
10 1 3 3
After:  [3, 1, 3, 0]

Before: [1, 1, 2, 2]
3 2 3 0
After:  [2, 1, 2, 2]

Before: [2, 1, 2, 1]
1 1 2 1
After:  [2, 0, 2, 1]

Before: [3, 1, 3, 1]
0 1 0 2
After:  [3, 1, 1, 1]

Before: [3, 1, 1, 2]
0 1 0 2
After:  [3, 1, 1, 2]

Before: [1, 3, 3, 1]
12 2 3 2
After:  [1, 3, 0, 1]

Before: [3, 1, 1, 2]
10 1 3 3
After:  [3, 1, 1, 0]

Before: [1, 1, 1, 2]
10 1 3 0
After:  [0, 1, 1, 2]

Before: [0, 1, 0, 2]
8 0 3 3
After:  [0, 1, 0, 0]

Before: [3, 0, 0, 3]
5 3 3 1
After:  [3, 3, 0, 3]

Before: [1, 1, 2, 2]
1 1 2 1
After:  [1, 0, 2, 2]

Before: [0, 0, 1, 1]
6 3 3 3
After:  [0, 0, 1, 0]

Before: [1, 2, 2, 2]
6 3 3 3
After:  [1, 2, 2, 0]

Before: [2, 3, 2, 1]
7 3 2 3
After:  [2, 3, 2, 1]

Before: [3, 3, 1, 1]
11 0 0 0
After:  [1, 3, 1, 1]

Before: [3, 0, 2, 1]
7 3 2 2
After:  [3, 0, 1, 1]

Before: [2, 0, 3, 2]
4 0 3 1
After:  [2, 1, 3, 2]

Before: [2, 3, 2, 1]
5 2 2 1
After:  [2, 2, 2, 1]

Before: [1, 1, 0, 2]
10 1 3 3
After:  [1, 1, 0, 0]

Before: [0, 3, 1, 3]
8 0 2 1
After:  [0, 0, 1, 3]

Before: [2, 0, 1, 2]
4 0 3 1
After:  [2, 1, 1, 2]

Before: [1, 3, 3, 3]
5 3 3 0
After:  [3, 3, 3, 3]

Before: [2, 2, 2, 2]
4 0 3 3
After:  [2, 2, 2, 1]

Before: [3, 1, 2, 0]
1 1 2 1
After:  [3, 0, 2, 0]

Before: [1, 3, 3, 1]
6 3 3 3
After:  [1, 3, 3, 0]

Before: [1, 1, 3, 1]
15 1 0 2
After:  [1, 1, 1, 1]

Before: [1, 1, 1, 1]
15 1 0 1
After:  [1, 1, 1, 1]

Before: [1, 3, 2, 3]
5 3 3 0
After:  [3, 3, 2, 3]

Before: [2, 0, 2, 1]
7 3 2 2
After:  [2, 0, 1, 1]

Before: [0, 1, 1, 2]
10 1 3 2
After:  [0, 1, 0, 2]

Before: [0, 2, 1, 3]
2 2 3 2
After:  [0, 2, 0, 3]

Before: [1, 1, 2, 0]
1 1 2 2
After:  [1, 1, 0, 0]

Before: [1, 0, 1, 3]
2 2 3 2
After:  [1, 0, 0, 3]

Before: [3, 1, 0, 3]
0 3 0 3
After:  [3, 1, 0, 3]

Before: [0, 2, 0, 1]
8 0 3 0
After:  [0, 2, 0, 1]

Before: [3, 1, 1, 0]
11 0 0 1
After:  [3, 1, 1, 0]

Before: [1, 2, 2, 2]
6 3 3 1
After:  [1, 0, 2, 2]

Before: [1, 2, 1, 3]
2 2 3 3
After:  [1, 2, 1, 0]

Before: [0, 3, 3, 2]
14 0 0 1
After:  [0, 0, 3, 2]

Before: [2, 2, 2, 1]
7 3 2 2
After:  [2, 2, 1, 1]

Before: [2, 2, 0, 2]
4 0 3 2
After:  [2, 2, 1, 2]

Before: [0, 1, 1, 3]
8 0 2 1
After:  [0, 0, 1, 3]

Before: [2, 1, 1, 2]
10 1 3 3
After:  [2, 1, 1, 0]

Before: [3, 0, 2, 3]
13 3 2 1
After:  [3, 0, 2, 3]

Before: [0, 3, 2, 1]
14 0 0 3
After:  [0, 3, 2, 0]

Before: [2, 3, 2, 1]
5 2 2 0
After:  [2, 3, 2, 1]

Before: [2, 1, 2, 3]
2 2 3 0
After:  [0, 1, 2, 3]

Before: [0, 1, 3, 2]
10 1 3 1
After:  [0, 0, 3, 2]

Before: [1, 1, 2, 0]
9 0 2 2
After:  [1, 1, 0, 0]

Before: [0, 3, 0, 3]
14 0 0 0
After:  [0, 3, 0, 3]

Before: [0, 2, 0, 3]
2 1 3 0
After:  [0, 2, 0, 3]

Before: [0, 0, 2, 1]
13 2 2 3
After:  [0, 0, 2, 1]

Before: [0, 1, 2, 2]
1 1 2 2
After:  [0, 1, 0, 2]

Before: [3, 1, 3, 3]
2 1 3 3
After:  [3, 1, 3, 0]

Before: [0, 3, 2, 0]
5 2 2 0
After:  [2, 3, 2, 0]

Before: [1, 2, 2, 1]
9 0 2 1
After:  [1, 0, 2, 1]

Before: [1, 3, 2, 3]
2 2 3 3
After:  [1, 3, 2, 0]

Before: [2, 3, 0, 2]
4 0 3 3
After:  [2, 3, 0, 1]

Before: [2, 2, 3, 1]
12 2 3 0
After:  [0, 2, 3, 1]

Before: [0, 1, 2, 2]
13 0 0 1
After:  [0, 1, 2, 2]

Before: [1, 0, 2, 1]
7 3 2 2
After:  [1, 0, 1, 1]

Before: [0, 3, 3, 0]
14 0 0 2
After:  [0, 3, 0, 0]

Before: [3, 0, 3, 1]
11 0 2 0
After:  [1, 0, 3, 1]

Before: [1, 2, 0, 1]
6 3 3 0
After:  [0, 2, 0, 1]

Before: [2, 1, 2, 1]
1 1 2 0
After:  [0, 1, 2, 1]

Before: [3, 3, 2, 3]
0 3 0 0
After:  [3, 3, 2, 3]

Before: [0, 3, 2, 3]
5 3 3 0
After:  [3, 3, 2, 3]

Before: [0, 1, 3, 3]
14 0 0 3
After:  [0, 1, 3, 0]

Before: [0, 0, 3, 1]
13 0 0 1
After:  [0, 1, 3, 1]

Before: [0, 3, 2, 2]
3 2 3 2
After:  [0, 3, 2, 2]

Before: [2, 2, 2, 3]
2 1 3 0
After:  [0, 2, 2, 3]

Before: [2, 2, 2, 3]
12 2 1 0
After:  [1, 2, 2, 3]

Before: [0, 0, 1, 0]
14 0 0 3
After:  [0, 0, 1, 0]

Before: [1, 1, 1, 2]
15 1 0 0
After:  [1, 1, 1, 2]

Before: [2, 0, 2, 1]
7 3 2 0
After:  [1, 0, 2, 1]

Before: [3, 0, 2, 1]
11 0 0 3
After:  [3, 0, 2, 1]

Before: [3, 1, 2, 2]
10 1 3 3
After:  [3, 1, 2, 0]

Before: [0, 1, 2, 3]
13 3 1 0
After:  [0, 1, 2, 3]

Before: [0, 1, 0, 3]
14 0 0 3
After:  [0, 1, 0, 0]

Before: [0, 3, 2, 3]
8 0 2 3
After:  [0, 3, 2, 0]

Before: [1, 3, 2, 2]
9 0 2 0
After:  [0, 3, 2, 2]

Before: [1, 0, 2, 1]
9 0 2 1
After:  [1, 0, 2, 1]

Before: [0, 1, 0, 3]
2 1 3 1
After:  [0, 0, 0, 3]

Before: [0, 0, 2, 3]
14 0 0 0
After:  [0, 0, 2, 3]

Before: [2, 2, 2, 1]
12 2 1 0
After:  [1, 2, 2, 1]

Before: [3, 3, 3, 1]
0 3 0 3
After:  [3, 3, 3, 1]

Before: [3, 3, 0, 1]
0 3 0 1
After:  [3, 1, 0, 1]

Before: [0, 1, 2, 3]
1 1 2 0
After:  [0, 1, 2, 3]

Before: [3, 3, 3, 3]
0 3 0 3
After:  [3, 3, 3, 3]

Before: [1, 0, 2, 2]
3 2 3 1
After:  [1, 2, 2, 2]

Before: [1, 2, 2, 2]
12 2 1 3
After:  [1, 2, 2, 1]

Before: [0, 1, 1, 2]
10 1 3 1
After:  [0, 0, 1, 2]

Before: [1, 0, 2, 2]
9 0 2 2
After:  [1, 0, 0, 2]

Before: [1, 1, 2, 2]
10 1 3 1
After:  [1, 0, 2, 2]

Before: [3, 3, 1, 1]
0 3 0 1
After:  [3, 1, 1, 1]

Before: [2, 1, 2, 2]
12 2 0 0
After:  [1, 1, 2, 2]

Before: [2, 0, 3, 2]
4 0 3 0
After:  [1, 0, 3, 2]

Before: [2, 2, 3, 2]
4 0 3 3
After:  [2, 2, 3, 1]

Before: [2, 3, 3, 3]
13 3 3 2
After:  [2, 3, 1, 3]

Before: [3, 3, 2, 1]
7 3 2 1
After:  [3, 1, 2, 1]

Before: [0, 3, 2, 0]
8 0 2 2
After:  [0, 3, 0, 0]

Before: [0, 1, 3, 2]
13 2 1 1
After:  [0, 0, 3, 2]

Before: [0, 1, 2, 2]
13 0 0 0
After:  [1, 1, 2, 2]

Before: [2, 2, 1, 3]
2 1 3 0
After:  [0, 2, 1, 3]

Before: [1, 1, 1, 0]
15 1 0 1
After:  [1, 1, 1, 0]

Before: [2, 2, 2, 2]
3 2 3 2
After:  [2, 2, 2, 2]

Before: [1, 1, 2, 3]
15 1 0 3
After:  [1, 1, 2, 1]

Before: [2, 0, 3, 2]
4 0 3 3
After:  [2, 0, 3, 1]

Before: [3, 0, 3, 3]
0 3 0 3
After:  [3, 0, 3, 3]

Before: [0, 2, 1, 1]
8 0 2 1
After:  [0, 0, 1, 1]

Before: [1, 3, 2, 0]
5 2 2 3
After:  [1, 3, 2, 2]

Before: [0, 2, 2, 1]
6 3 3 1
After:  [0, 0, 2, 1]

Before: [1, 1, 3, 0]
15 1 0 1
After:  [1, 1, 3, 0]

Before: [2, 0, 1, 3]
5 3 3 0
After:  [3, 0, 1, 3]

Before: [1, 1, 2, 1]
15 1 0 1
After:  [1, 1, 2, 1]

Before: [2, 1, 2, 2]
3 2 3 0
After:  [2, 1, 2, 2]

Before: [1, 1, 3, 2]
15 1 0 3
After:  [1, 1, 3, 1]

Before: [0, 2, 1, 1]
14 0 0 0
After:  [0, 2, 1, 1]

Before: [0, 0, 2, 0]
5 2 2 1
After:  [0, 2, 2, 0]

Before: [0, 1, 2, 3]
2 1 3 2
After:  [0, 1, 0, 3]

Before: [3, 1, 2, 2]
3 2 3 0
After:  [2, 1, 2, 2]

Before: [1, 2, 2, 2]
9 0 2 2
After:  [1, 2, 0, 2]

Before: [2, 2, 2, 1]
5 2 2 1
After:  [2, 2, 2, 1]

Before: [1, 1, 2, 1]
7 3 2 1
After:  [1, 1, 2, 1]

Before: [3, 0, 0, 1]
0 3 0 3
After:  [3, 0, 0, 1]

Before: [3, 2, 3, 3]
12 3 0 3
After:  [3, 2, 3, 1]

Before: [3, 1, 2, 2]
10 1 3 1
After:  [3, 0, 2, 2]

Before: [1, 0, 1, 3]
13 3 2 1
After:  [1, 0, 1, 3]

Before: [0, 0, 0, 2]
14 0 0 1
After:  [0, 0, 0, 2]

Before: [3, 0, 3, 1]
0 3 0 1
After:  [3, 1, 3, 1]

Before: [1, 1, 2, 3]
1 1 2 3
After:  [1, 1, 2, 0]

Before: [3, 1, 2, 1]
1 1 2 1
After:  [3, 0, 2, 1]

Before: [3, 3, 0, 3]
13 3 3 2
After:  [3, 3, 1, 3]

Before: [3, 3, 2, 3]
2 2 3 2
After:  [3, 3, 0, 3]

Before: [1, 2, 2, 1]
9 0 2 2
After:  [1, 2, 0, 1]

Before: [3, 1, 0, 1]
0 3 0 1
After:  [3, 1, 0, 1]

Before: [2, 2, 3, 2]
4 0 3 0
After:  [1, 2, 3, 2]

Before: [2, 0, 2, 1]
7 3 2 1
After:  [2, 1, 2, 1]

Before: [1, 1, 2, 2]
9 0 2 2
After:  [1, 1, 0, 2]

Before: [0, 1, 3, 2]
6 3 3 2
After:  [0, 1, 0, 2]

Before: [3, 3, 0, 2]
6 3 3 3
After:  [3, 3, 0, 0]

Before: [3, 1, 3, 1]
11 0 2 2
After:  [3, 1, 1, 1]

Before: [0, 1, 2, 1]
7 3 2 3
After:  [0, 1, 2, 1]

Before: [1, 2, 2, 1]
7 3 2 1
After:  [1, 1, 2, 1]

Before: [3, 1, 0, 2]
10 1 3 2
After:  [3, 1, 0, 2]

Before: [0, 1, 3, 2]
14 0 0 2
After:  [0, 1, 0, 2]

Before: [0, 3, 0, 2]
14 0 0 1
After:  [0, 0, 0, 2]

Before: [0, 1, 2, 1]
1 1 2 3
After:  [0, 1, 2, 0]

Before: [1, 1, 2, 1]
9 0 2 1
After:  [1, 0, 2, 1]

Before: [0, 1, 2, 2]
10 1 3 2
After:  [0, 1, 0, 2]

Before: [1, 0, 2, 2]
3 2 3 2
After:  [1, 0, 2, 2]

Before: [2, 3, 3, 1]
12 2 3 3
After:  [2, 3, 3, 0]

Before: [2, 0, 3, 1]
12 2 3 0
After:  [0, 0, 3, 1]

Before: [2, 1, 2, 1]
7 3 2 2
After:  [2, 1, 1, 1]

Before: [3, 3, 2, 2]
3 2 3 0
After:  [2, 3, 2, 2]

Before: [0, 1, 0, 1]
8 0 1 1
After:  [0, 0, 0, 1]

Before: [1, 1, 2, 1]
6 3 3 2
After:  [1, 1, 0, 1]

Before: [0, 1, 2, 2]
1 1 2 0
After:  [0, 1, 2, 2]

Before: [3, 3, 1, 3]
2 2 3 2
After:  [3, 3, 0, 3]

Before: [3, 2, 1, 3]
5 3 3 1
After:  [3, 3, 1, 3]

Before: [2, 1, 2, 2]
4 0 3 0
After:  [1, 1, 2, 2]

Before: [3, 3, 2, 2]
13 2 2 2
After:  [3, 3, 1, 2]

Before: [2, 1, 3, 2]
4 0 3 2
After:  [2, 1, 1, 2]

Before: [3, 0, 2, 2]
3 2 3 1
After:  [3, 2, 2, 2]

Before: [2, 0, 1, 2]
4 0 3 3
After:  [2, 0, 1, 1]

Before: [3, 2, 2, 0]
5 2 2 3
After:  [3, 2, 2, 2]

Before: [0, 0, 3, 3]
5 3 3 3
After:  [0, 0, 3, 3]

Before: [0, 1, 0, 3]
13 3 1 0
After:  [0, 1, 0, 3]

Before: [2, 2, 3, 2]
4 0 3 2
After:  [2, 2, 1, 2]

Before: [0, 3, 0, 1]
14 0 0 2
After:  [0, 3, 0, 1]

Before: [3, 3, 3, 0]
11 0 0 2
After:  [3, 3, 1, 0]

Before: [0, 3, 3, 3]
14 0 0 1
After:  [0, 0, 3, 3]

Before: [2, 2, 1, 1]
6 3 3 2
After:  [2, 2, 0, 1]

Before: [3, 2, 0, 3]
5 3 3 0
After:  [3, 2, 0, 3]

Before: [2, 2, 2, 3]
2 1 3 1
After:  [2, 0, 2, 3]

Before: [2, 3, 2, 2]
3 2 3 1
After:  [2, 2, 2, 2]

Before: [0, 1, 2, 1]
7 3 2 1
After:  [0, 1, 2, 1]

Before: [0, 1, 2, 2]
3 2 3 1
After:  [0, 2, 2, 2]

Before: [3, 1, 2, 0]
0 1 0 2
After:  [3, 1, 1, 0]

Before: [2, 2, 2, 0]
0 2 0 1
After:  [2, 2, 2, 0]

Before: [1, 1, 3, 0]
15 1 0 0
After:  [1, 1, 3, 0]

Before: [0, 3, 0, 3]
5 3 3 0
After:  [3, 3, 0, 3]

Before: [3, 3, 3, 3]
0 3 0 0
After:  [3, 3, 3, 3]

Before: [3, 0, 2, 0]
5 2 2 2
After:  [3, 0, 2, 0]

Before: [2, 3, 2, 2]
6 3 3 0
After:  [0, 3, 2, 2]

Before: [1, 0, 2, 3]
9 0 2 0
After:  [0, 0, 2, 3]

Before: [2, 3, 2, 0]
5 2 2 1
After:  [2, 2, 2, 0]

Before: [3, 3, 3, 1]
12 2 3 3
After:  [3, 3, 3, 0]

Before: [1, 1, 1, 3]
2 2 3 2
After:  [1, 1, 0, 3]

Before: [3, 1, 1, 2]
11 0 0 2
After:  [3, 1, 1, 2]

Before: [1, 1, 0, 2]
15 1 0 3
After:  [1, 1, 0, 1]

Before: [1, 1, 1, 1]
15 1 0 2
After:  [1, 1, 1, 1]

Before: [0, 1, 0, 3]
2 1 3 2
After:  [0, 1, 0, 3]

Before: [2, 0, 2, 2]
3 2 3 2
After:  [2, 0, 2, 2]

Before: [0, 3, 3, 3]
11 2 2 3
After:  [0, 3, 3, 1]

Before: [0, 1, 2, 2]
3 2 3 3
After:  [0, 1, 2, 2]

Before: [0, 3, 3, 0]
8 0 1 1
After:  [0, 0, 3, 0]

Before: [3, 1, 3, 2]
10 1 3 1
After:  [3, 0, 3, 2]

Before: [3, 2, 2, 3]
12 2 1 2
After:  [3, 2, 1, 3]

Before: [3, 2, 2, 0]
5 2 2 0
After:  [2, 2, 2, 0]

Before: [3, 1, 1, 2]
10 1 3 1
After:  [3, 0, 1, 2]

Before: [3, 0, 3, 1]
11 0 2 2
After:  [3, 0, 1, 1]

Before: [3, 1, 0, 3]
0 1 0 1
After:  [3, 1, 0, 3]

Before: [0, 1, 2, 1]
7 3 2 2
After:  [0, 1, 1, 1]

Before: [2, 1, 2, 0]
12 2 0 1
After:  [2, 1, 2, 0]

Before: [0, 1, 0, 2]
14 0 0 2
After:  [0, 1, 0, 2]

Before: [2, 3, 2, 1]
0 2 0 3
After:  [2, 3, 2, 2]

Before: [1, 1, 0, 2]
10 1 3 1
After:  [1, 0, 0, 2]

Before: [3, 1, 2, 3]
13 3 3 2
After:  [3, 1, 1, 3]

Before: [2, 3, 2, 3]
0 2 0 1
After:  [2, 2, 2, 3]

Before: [3, 1, 2, 3]
1 1 2 3
After:  [3, 1, 2, 0]

Before: [2, 2, 1, 2]
4 0 3 0
After:  [1, 2, 1, 2]

Before: [0, 0, 3, 1]
14 0 0 0
After:  [0, 0, 3, 1]

Before: [3, 2, 3, 0]
11 0 2 3
After:  [3, 2, 3, 1]

Before: [2, 1, 1, 1]
11 0 0 1
After:  [2, 1, 1, 1]

Before: [3, 2, 2, 2]
12 2 1 2
After:  [3, 2, 1, 2]

Before: [0, 1, 3, 2]
10 1 3 2
After:  [0, 1, 0, 2]

Before: [1, 1, 2, 2]
15 1 0 1
After:  [1, 1, 2, 2]

Before: [0, 0, 3, 3]
8 0 2 3
After:  [0, 0, 3, 0]

Before: [2, 0, 0, 0]
11 0 0 1
After:  [2, 1, 0, 0]

Before: [3, 2, 3, 3]
0 3 0 2
After:  [3, 2, 3, 3]

Before: [2, 2, 2, 2]
4 0 3 2
After:  [2, 2, 1, 2]

Before: [1, 1, 1, 3]
15 1 0 0
After:  [1, 1, 1, 3]

Before: [0, 1, 2, 0]
8 0 1 0
After:  [0, 1, 2, 0]

Before: [3, 1, 3, 1]
12 2 3 0
After:  [0, 1, 3, 1]

Before: [1, 1, 2, 2]
3 2 3 2
After:  [1, 1, 2, 2]

Before: [3, 1, 2, 2]
3 2 3 1
After:  [3, 2, 2, 2]

Before: [1, 1, 0, 1]
15 1 0 0
After:  [1, 1, 0, 1]

Before: [2, 3, 1, 3]
2 2 3 3
After:  [2, 3, 1, 0]

Before: [2, 0, 3, 1]
12 2 3 2
After:  [2, 0, 0, 1]

Before: [2, 0, 0, 3]
8 1 0 0
After:  [0, 0, 0, 3]

Before: [1, 1, 2, 0]
15 1 0 0
After:  [1, 1, 2, 0]

Before: [3, 0, 0, 0]
8 2 0 3
After:  [3, 0, 0, 0]

Before: [2, 0, 2, 2]
0 2 0 3
After:  [2, 0, 2, 2]

Before: [2, 0, 2, 2]
4 0 3 3
After:  [2, 0, 2, 1]

Before: [0, 2, 2, 1]
7 3 2 2
After:  [0, 2, 1, 1]

Before: [2, 2, 0, 1]
6 3 3 1
After:  [2, 0, 0, 1]

Before: [2, 1, 1, 2]
10 1 3 2
After:  [2, 1, 0, 2]

Before: [2, 0, 1, 3]
2 2 3 0
After:  [0, 0, 1, 3]

Before: [2, 0, 0, 2]
4 0 3 3
After:  [2, 0, 0, 1]

Before: [1, 2, 2, 2]
3 2 3 0
After:  [2, 2, 2, 2]

Before: [0, 3, 2, 1]
8 0 1 0
After:  [0, 3, 2, 1]

Before: [0, 2, 2, 3]
8 0 3 2
After:  [0, 2, 0, 3]

Before: [0, 2, 2, 0]
5 2 2 3
After:  [0, 2, 2, 2]

Before: [3, 0, 3, 1]
12 2 3 0
After:  [0, 0, 3, 1]

Before: [0, 2, 1, 3]
2 1 3 0
After:  [0, 2, 1, 3]

Before: [1, 1, 2, 2]
1 1 2 0
After:  [0, 1, 2, 2]

Before: [2, 0, 2, 0]
0 2 0 2
After:  [2, 0, 2, 0]

Before: [0, 1, 3, 2]
10 1 3 3
After:  [0, 1, 3, 0]

Before: [1, 1, 2, 0]
15 1 0 3
After:  [1, 1, 2, 1]

Before: [2, 1, 2, 3]
1 1 2 0
After:  [0, 1, 2, 3]

Before: [1, 3, 1, 3]
2 2 3 3
After:  [1, 3, 1, 0]

Before: [2, 3, 2, 0]
12 2 0 1
After:  [2, 1, 2, 0]

Before: [3, 0, 3, 3]
12 3 0 2
After:  [3, 0, 1, 3]

Before: [3, 1, 1, 3]
2 2 3 0
After:  [0, 1, 1, 3]

Before: [3, 2, 2, 3]
2 1 3 3
After:  [3, 2, 2, 0]

Before: [2, 2, 2, 1]
7 3 2 3
After:  [2, 2, 2, 1]

Before: [1, 1, 1, 1]
6 2 3 3
After:  [1, 1, 1, 0]

Before: [2, 3, 2, 3]
5 2 2 2
After:  [2, 3, 2, 3]

Before: [2, 3, 2, 2]
4 0 3 0
After:  [1, 3, 2, 2]

Before: [0, 1, 2, 1]
13 2 2 2
After:  [0, 1, 1, 1]

Before: [1, 3, 2, 2]
9 0 2 3
After:  [1, 3, 2, 0]

Before: [0, 0, 0, 3]
14 0 0 1
After:  [0, 0, 0, 3]

Before: [0, 2, 0, 0]
14 0 0 2
After:  [0, 2, 0, 0]

Before: [1, 3, 2, 1]
9 0 2 3
After:  [1, 3, 2, 0]

Before: [3, 2, 2, 3]
13 3 2 1
After:  [3, 0, 2, 3]

Before: [1, 0, 2, 0]
9 0 2 0
After:  [0, 0, 2, 0]

Before: [0, 3, 2, 1]
5 2 2 1
After:  [0, 2, 2, 1]

Before: [3, 1, 2, 3]
1 1 2 1
After:  [3, 0, 2, 3]

Before: [0, 3, 1, 2]
14 0 0 2
After:  [0, 3, 0, 2]

Before: [2, 1, 1, 3]
13 3 2 1
After:  [2, 0, 1, 3]

Before: [0, 0, 2, 2]
6 3 3 3
After:  [0, 0, 2, 0]

Before: [0, 1, 3, 0]
8 0 2 0
After:  [0, 1, 3, 0]

Before: [1, 1, 1, 2]
15 1 0 2
After:  [1, 1, 1, 2]

Before: [0, 1, 3, 2]
8 0 2 3
After:  [0, 1, 3, 0]

Before: [1, 1, 3, 3]
15 1 0 0
After:  [1, 1, 3, 3]

Before: [2, 2, 1, 2]
11 0 1 0
After:  [1, 2, 1, 2]

Before: [1, 0, 2, 2]
3 2 3 0
After:  [2, 0, 2, 2]

Before: [0, 0, 2, 2]
3 2 3 0
After:  [2, 0, 2, 2]

Before: [2, 2, 2, 2]
3 2 3 0
After:  [2, 2, 2, 2]

Before: [2, 2, 2, 0]
12 2 0 0
After:  [1, 2, 2, 0]

Before: [0, 1, 1, 2]
10 1 3 0
After:  [0, 1, 1, 2]

Before: [0, 0, 0, 2]
14 0 0 3
After:  [0, 0, 0, 0]

Before: [1, 3, 3, 3]
13 3 3 2
After:  [1, 3, 1, 3]

Before: [3, 2, 2, 3]
5 3 3 0
After:  [3, 2, 2, 3]

Before: [1, 1, 3, 1]
15 1 0 1
After:  [1, 1, 3, 1]

Before: [2, 3, 2, 2]
4 0 3 2
After:  [2, 3, 1, 2]

Before: [3, 3, 2, 3]
0 3 0 1
After:  [3, 3, 2, 3]

Before: [1, 1, 2, 0]
9 0 2 3
After:  [1, 1, 2, 0]

Before: [1, 2, 2, 0]
9 0 2 2
After:  [1, 2, 0, 0]

Before: [0, 3, 2, 1]
7 3 2 1
After:  [0, 1, 2, 1]

Before: [2, 0, 2, 3]
5 2 2 0
After:  [2, 0, 2, 3]

Before: [2, 0, 0, 2]
4 0 3 2
After:  [2, 0, 1, 2]

Before: [3, 3, 1, 1]
0 3 0 2
After:  [3, 3, 1, 1]

Before: [0, 3, 3, 0]
14 0 0 1
After:  [0, 0, 3, 0]

Before: [3, 2, 1, 1]
0 3 0 1
After:  [3, 1, 1, 1]

Before: [1, 1, 2, 2]
15 1 0 0
After:  [1, 1, 2, 2]

Before: [2, 2, 1, 2]
6 3 3 0
After:  [0, 2, 1, 2]

Before: [2, 1, 2, 2]
4 0 3 2
After:  [2, 1, 1, 2]

Before: [1, 1, 1, 2]
10 1 3 1
After:  [1, 0, 1, 2]

Before: [1, 1, 0, 0]
15 1 0 0
After:  [1, 1, 0, 0]

Before: [1, 2, 2, 3]
9 0 2 1
After:  [1, 0, 2, 3]

Before: [2, 0, 1, 2]
4 0 3 0
After:  [1, 0, 1, 2]

Before: [1, 3, 3, 3]
12 3 2 3
After:  [1, 3, 3, 1]

Before: [3, 1, 1, 2]
0 1 0 0
After:  [1, 1, 1, 2]

Before: [3, 0, 2, 1]
0 3 0 3
After:  [3, 0, 2, 1]

Before: [3, 3, 0, 1]
0 3 0 0
After:  [1, 3, 0, 1]

Before: [1, 3, 3, 2]
6 3 3 2
After:  [1, 3, 0, 2]

Before: [0, 2, 1, 0]
8 0 2 2
After:  [0, 2, 0, 0]

Before: [2, 2, 2, 0]
12 2 0 2
After:  [2, 2, 1, 0]

Before: [2, 1, 2, 3]
5 2 2 0
After:  [2, 1, 2, 3]

Before: [0, 0, 1, 3]
5 3 3 3
After:  [0, 0, 1, 3]

Before: [1, 0, 2, 3]
13 2 2 2
After:  [1, 0, 1, 3]

Before: [1, 1, 2, 3]
15 1 0 2
After:  [1, 1, 1, 3]

Before: [2, 2, 2, 2]
3 2 3 3
After:  [2, 2, 2, 2]

Before: [1, 1, 0, 1]
15 1 0 2
After:  [1, 1, 1, 1]

Before: [1, 1, 2, 3]
15 1 0 0
After:  [1, 1, 2, 3]

Before: [1, 1, 0, 3]
2 1 3 1
After:  [1, 0, 0, 3]

Before: [2, 0, 2, 1]
12 2 0 1
After:  [2, 1, 2, 1]

Before: [0, 2, 1, 2]
8 0 1 1
After:  [0, 0, 1, 2]

Before: [1, 1, 2, 3]
1 1 2 1
After:  [1, 0, 2, 3]

Before: [0, 3, 2, 3]
2 2 3 0
After:  [0, 3, 2, 3]

Before: [0, 0, 2, 3]
13 3 3 2
After:  [0, 0, 1, 3]

Before: [2, 1, 3, 2]
10 1 3 1
After:  [2, 0, 3, 2]

Before: [1, 1, 2, 3]
2 1 3 3
After:  [1, 1, 2, 0]

Before: [0, 0, 3, 2]
14 0 0 2
After:  [0, 0, 0, 2]

Before: [0, 2, 2, 1]
7 3 2 3
After:  [0, 2, 2, 1]

Before: [1, 0, 3, 2]
11 2 2 3
After:  [1, 0, 3, 1]

Before: [3, 2, 3, 3]
11 0 0 1
After:  [3, 1, 3, 3]

Before: [0, 3, 2, 2]
14 0 0 2
After:  [0, 3, 0, 2]

Before: [3, 2, 1, 1]
6 3 3 2
After:  [3, 2, 0, 1]

Before: [0, 2, 2, 3]
2 2 3 0
After:  [0, 2, 2, 3]

Before: [1, 2, 1, 2]
6 3 3 3
After:  [1, 2, 1, 0]

Before: [2, 1, 2, 1]
7 3 2 1
After:  [2, 1, 2, 1]

Before: [1, 1, 1, 2]
10 1 3 2
After:  [1, 1, 0, 2]

Before: [0, 0, 1, 1]
14 0 0 1
After:  [0, 0, 1, 1]

Before: [3, 3, 3, 1]
11 0 2 1
After:  [3, 1, 3, 1]

Before: [2, 1, 2, 2]
12 2 0 2
After:  [2, 1, 1, 2]

Before: [1, 2, 2, 1]
7 3 2 0
After:  [1, 2, 2, 1]

Before: [1, 2, 2, 2]
9 0 2 1
After:  [1, 0, 2, 2]

Before: [3, 3, 2, 1]
7 3 2 3
After:  [3, 3, 2, 1]

Before: [2, 1, 1, 2]
6 3 3 3
After:  [2, 1, 1, 0]

Before: [2, 2, 1, 3]
2 2 3 2
After:  [2, 2, 0, 3]

Before: [3, 2, 2, 2]
3 2 3 1
After:  [3, 2, 2, 2]

Before: [2, 2, 2, 1]
0 2 0 0
After:  [2, 2, 2, 1]

Before: [0, 1, 3, 1]
14 0 0 1
After:  [0, 0, 3, 1]

Before: [2, 0, 3, 1]
8 1 0 0
After:  [0, 0, 3, 1]

Before: [2, 3, 0, 2]
4 0 3 2
After:  [2, 3, 1, 2]

Before: [2, 0, 2, 2]
3 2 3 1
After:  [2, 2, 2, 2]

Before: [0, 0, 3, 2]
8 0 2 2
After:  [0, 0, 0, 2]

Before: [3, 1, 1, 2]
10 1 3 2
After:  [3, 1, 0, 2]

Before: [3, 2, 2, 1]
7 3 2 2
After:  [3, 2, 1, 1]

Before: [2, 2, 2, 2]
4 0 3 1
After:  [2, 1, 2, 2]

Before: [1, 1, 2, 2]
9 0 2 1
After:  [1, 0, 2, 2]

Before: [3, 0, 2, 2]
5 2 2 1
After:  [3, 2, 2, 2]

Before: [0, 2, 0, 1]
14 0 0 0
After:  [0, 2, 0, 1]

Before: [2, 2, 2, 1]
5 2 2 0
After:  [2, 2, 2, 1]

Before: [2, 1, 2, 3]
1 1 2 1
After:  [2, 0, 2, 3]

Before: [2, 3, 0, 2]
4 0 3 1
After:  [2, 1, 0, 2]

Before: [2, 3, 2, 1]
7 3 2 0
After:  [1, 3, 2, 1]

Before: [2, 0, 2, 2]
12 2 0 0
After:  [1, 0, 2, 2]

Before: [1, 2, 2, 2]
3 2 3 2
After:  [1, 2, 2, 2]

Before: [0, 0, 2, 1]
7 3 2 0
After:  [1, 0, 2, 1]

Before: [2, 2, 3, 3]
11 2 2 3
After:  [2, 2, 3, 1]

Before: [3, 3, 2, 0]
5 2 2 2
After:  [3, 3, 2, 0]

Before: [3, 2, 2, 2]
3 2 3 2
After:  [3, 2, 2, 2]

Before: [2, 3, 2, 2]
4 0 3 3
After:  [2, 3, 2, 1]

Before: [2, 1, 1, 2]
11 0 0 1
After:  [2, 1, 1, 2]

Before: [0, 0, 2, 1]
7 3 2 2
After:  [0, 0, 1, 1]

Before: [0, 2, 1, 0]
14 0 0 3
After:  [0, 2, 1, 0]

Before: [1, 1, 2, 0]
15 1 0 1
After:  [1, 1, 2, 0]

Before: [0, 1, 2, 3]
1 1 2 1
After:  [0, 0, 2, 3]

Before: [0, 3, 1, 0]
14 0 0 3
After:  [0, 3, 1, 0]

Before: [0, 2, 3, 2]
8 0 3 0
After:  [0, 2, 3, 2]

Before: [0, 1, 3, 3]
13 0 0 0
After:  [1, 1, 3, 3]

Before: [2, 1, 2, 0]
1 1 2 0
After:  [0, 1, 2, 0]

Before: [3, 0, 1, 1]
11 0 0 0
After:  [1, 0, 1, 1]

Before: [0, 2, 1, 3]
14 0 0 3
After:  [0, 2, 1, 0]

Before: [0, 2, 2, 1]
14 0 0 0
After:  [0, 2, 2, 1]

Before: [0, 2, 3, 0]
14 0 0 1
After:  [0, 0, 3, 0]

Before: [2, 2, 2, 2]
3 2 3 1
After:  [2, 2, 2, 2]

Before: [3, 0, 2, 1]
7 3 2 3
After:  [3, 0, 2, 1]

Before: [2, 2, 2, 1]
6 3 3 0
After:  [0, 2, 2, 1]

Before: [2, 1, 3, 2]
10 1 3 2
After:  [2, 1, 0, 2]

Before: [2, 1, 2, 2]
5 2 2 3
After:  [2, 1, 2, 2]

Before: [3, 2, 1, 1]
0 3 0 3
After:  [3, 2, 1, 1]

Before: [2, 1, 2, 3]
1 1 2 3
After:  [2, 1, 2, 0]

Before: [2, 3, 2, 0]
0 2 0 1
After:  [2, 2, 2, 0]

Before: [3, 0, 3, 1]
11 0 0 3
After:  [3, 0, 3, 1]

Before: [2, 3, 1, 1]
6 2 3 2
After:  [2, 3, 0, 1]

Before: [2, 0, 3, 2]
11 2 2 0
After:  [1, 0, 3, 2]

Before: [0, 1, 1, 2]
10 1 3 3
After:  [0, 1, 1, 0]

Before: [0, 1, 3, 3]
12 3 2 2
After:  [0, 1, 1, 3]

Before: [0, 1, 1, 2]
14 0 0 1
After:  [0, 0, 1, 2]

Before: [0, 1, 2, 3]
1 1 2 2
After:  [0, 1, 0, 3]

Before: [1, 1, 2, 2]
1 1 2 3
After:  [1, 1, 2, 0]

Before: [0, 1, 0, 1]
14 0 0 3
After:  [0, 1, 0, 0]

Before: [2, 0, 0, 1]
6 3 3 1
After:  [2, 0, 0, 1]

Before: [1, 2, 1, 3]
13 3 2 3
After:  [1, 2, 1, 0]

Before: [2, 1, 2, 1]
6 3 3 3
After:  [2, 1, 2, 0]

Before: [0, 1, 0, 2]
6 3 3 3
After:  [0, 1, 0, 0]

Before: [3, 1, 0, 2]
8 2 0 0
After:  [0, 1, 0, 2]

Before: [1, 1, 3, 3]
12 3 2 0
After:  [1, 1, 3, 3]

Before: [0, 1, 2, 1]
5 2 2 3
After:  [0, 1, 2, 2]

Before: [1, 0, 3, 0]
11 2 2 0
After:  [1, 0, 3, 0]

Before: [3, 3, 2, 1]
5 2 2 0
After:  [2, 3, 2, 1]

Before: [0, 2, 2, 3]
14 0 0 3
After:  [0, 2, 2, 0]

Before: [3, 0, 1, 3]
2 2 3 3
After:  [3, 0, 1, 0]

Before: [2, 3, 3, 2]
4 0 3 3
After:  [2, 3, 3, 1]

Before: [1, 1, 3, 2]
15 1 0 2
After:  [1, 1, 1, 2]

Before: [1, 1, 2, 2]
9 0 2 0
After:  [0, 1, 2, 2]

Before: [2, 1, 2, 2]
10 1 3 0
After:  [0, 1, 2, 2]

Before: [3, 1, 2, 0]
1 1 2 3
After:  [3, 1, 2, 0]

Before: [0, 1, 1, 3]
14 0 0 1
After:  [0, 0, 1, 3]

Before: [1, 1, 2, 3]
13 3 1 0
After:  [0, 1, 2, 3]

Before: [1, 1, 1, 2]
6 3 3 1
After:  [1, 0, 1, 2]

Before: [2, 1, 2, 2]
5 2 2 1
After:  [2, 2, 2, 2]

Before: [0, 2, 2, 0]
14 0 0 0
After:  [0, 2, 2, 0]

Before: [0, 0, 2, 2]
8 0 2 2
After:  [0, 0, 0, 2]

Before: [0, 1, 2, 0]
14 0 0 3
After:  [0, 1, 2, 0]

Before: [1, 3, 2, 2]
9 0 2 1
After:  [1, 0, 2, 2]

Before: [1, 2, 2, 0]
12 2 1 0
After:  [1, 2, 2, 0]

Before: [2, 1, 3, 2]
4 0 3 0
After:  [1, 1, 3, 2]

Before: [0, 1, 2, 1]
1 1 2 1
After:  [0, 0, 2, 1]

Before: [3, 0, 3, 3]
11 0 0 0
After:  [1, 0, 3, 3]

Before: [0, 3, 2, 1]
7 3 2 0
After:  [1, 3, 2, 1]

Before: [3, 1, 1, 3]
12 3 0 0
After:  [1, 1, 1, 3]

Before: [0, 2, 2, 1]
7 3 2 0
After:  [1, 2, 2, 1]

Before: [1, 1, 3, 2]
10 1 3 3
After:  [1, 1, 3, 0]

Before: [1, 1, 2, 1]
1 1 2 1
After:  [1, 0, 2, 1]

Before: [2, 0, 1, 2]
6 3 3 0
After:  [0, 0, 1, 2]

Before: [2, 0, 2, 0]
0 2 0 3
After:  [2, 0, 2, 2]

Before: [0, 2, 3, 3]
13 3 3 0
After:  [1, 2, 3, 3]

Before: [1, 1, 0, 3]
15 1 0 3
After:  [1, 1, 0, 1]

Before: [2, 0, 1, 1]
11 0 0 2
After:  [2, 0, 1, 1]

Before: [2, 3, 0, 2]
6 3 3 2
After:  [2, 3, 0, 2]

Before: [3, 1, 1, 2]
10 1 3 0
After:  [0, 1, 1, 2]

Before: [2, 3, 0, 1]
6 3 3 1
After:  [2, 0, 0, 1]

Before: [3, 1, 2, 1]
1 1 2 0
After:  [0, 1, 2, 1]

Before: [1, 1, 0, 2]
10 1 3 0
After:  [0, 1, 0, 2]

Before: [2, 1, 2, 1]
1 1 2 2
After:  [2, 1, 0, 1]

Before: [2, 1, 0, 2]
10 1 3 2
After:  [2, 1, 0, 2]

Before: [1, 1, 2, 2]
15 1 0 2
After:  [1, 1, 1, 2]

Before: [2, 3, 0, 2]
4 0 3 0
After:  [1, 3, 0, 2]

Before: [1, 1, 2, 1]
1 1 2 0
After:  [0, 1, 2, 1]

Before: [3, 1, 2, 3]
13 3 3 0
After:  [1, 1, 2, 3]

Before: [3, 0, 2, 3]
0 3 0 1
After:  [3, 3, 2, 3]

Before: [0, 1, 2, 1]
1 1 2 0
After:  [0, 1, 2, 1]

Before: [2, 2, 1, 2]
4 0 3 3
After:  [2, 2, 1, 1]

Before: [3, 3, 0, 3]
11 0 0 0
After:  [1, 3, 0, 3]

Before: [3, 3, 2, 2]
3 2 3 1
After:  [3, 2, 2, 2]

Before: [1, 3, 2, 3]
2 2 3 0
After:  [0, 3, 2, 3]

Before: [1, 2, 2, 3]
9 0 2 0
After:  [0, 2, 2, 3]

Before: [2, 1, 2, 0]
1 1 2 2
After:  [2, 1, 0, 0]

Before: [3, 1, 2, 1]
1 1 2 2
After:  [3, 1, 0, 1]

Before: [3, 1, 0, 2]
10 1 3 1
After:  [3, 0, 0, 2]

Before: [3, 0, 3, 1]
12 2 3 2
After:  [3, 0, 0, 1]

Before: [1, 0, 2, 2]
9 0 2 3
After:  [1, 0, 2, 0]

Before: [0, 2, 2, 3]
5 3 3 1
After:  [0, 3, 2, 3]

Before: [2, 0, 2, 1]
12 2 0 2
After:  [2, 0, 1, 1]

Before: [2, 3, 1, 2]
11 0 0 3
After:  [2, 3, 1, 1]

Before: [0, 2, 2, 2]
14 0 0 0
After:  [0, 2, 2, 2]

Before: [1, 0, 3, 0]
11 2 2 2
After:  [1, 0, 1, 0]

Before: [0, 1, 2, 3]
14 0 0 0
After:  [0, 1, 2, 3]

Before: [2, 2, 3, 1]
6 3 3 3
After:  [2, 2, 3, 0]

Before: [1, 1, 2, 2]
10 1 3 0
After:  [0, 1, 2, 2]

Before: [3, 1, 2, 2]
6 3 3 1
After:  [3, 0, 2, 2]

Before: [1, 2, 3, 3]
13 3 1 2
After:  [1, 2, 0, 3]

Before: [1, 2, 1, 3]
2 2 3 2
After:  [1, 2, 0, 3]

Before: [3, 1, 0, 2]
10 1 3 3
After:  [3, 1, 0, 0]

Before: [3, 1, 3, 3]
11 2 2 3
After:  [3, 1, 3, 1]

Before: [2, 2, 1, 2]
11 0 0 2
After:  [2, 2, 1, 2]

Before: [3, 1, 3, 2]
10 1 3 0
After:  [0, 1, 3, 2]

Before: [3, 0, 2, 2]
3 2 3 2
After:  [3, 0, 2, 2]

Before: [1, 1, 0, 3]
2 1 3 0
After:  [0, 1, 0, 3]

Before: [2, 1, 2, 2]
1 1 2 3
After:  [2, 1, 2, 0]

Before: [2, 2, 2, 3]
2 2 3 2
After:  [2, 2, 0, 3]

Before: [3, 0, 2, 1]
7 3 2 1
After:  [3, 1, 2, 1]

Before: [1, 1, 2, 3]
9 0 2 0
After:  [0, 1, 2, 3]

Before: [3, 2, 2, 3]
2 1 3 2
After:  [3, 2, 0, 3]

Before: [2, 1, 2, 2]
4 0 3 1
After:  [2, 1, 2, 2]

Before: [2, 0, 2, 2]
4 0 3 0
After:  [1, 0, 2, 2]

Before: [2, 3, 1, 2]
4 0 3 2
After:  [2, 3, 1, 2]

Before: [0, 2, 1, 0]
8 0 2 3
After:  [0, 2, 1, 0]

Before: [3, 0, 1, 1]
6 2 3 3
After:  [3, 0, 1, 0]

Before: [1, 2, 2, 0]
12 2 1 2
After:  [1, 2, 1, 0]

Before: [1, 3, 2, 1]
9 0 2 2
After:  [1, 3, 0, 1]

Before: [1, 1, 1, 3]
15 1 0 1
After:  [1, 1, 1, 3]

Before: [0, 0, 0, 3]
8 0 3 2
After:  [0, 0, 0, 3]

Before: [3, 1, 2, 0]
1 1 2 2
After:  [3, 1, 0, 0]

Before: [2, 1, 2, 2]
10 1 3 2
After:  [2, 1, 0, 2]

Before: [1, 1, 0, 1]
15 1 0 1
After:  [1, 1, 0, 1]

Before: [1, 1, 3, 0]
13 2 1 0
After:  [0, 1, 3, 0]

Before: [0, 0, 2, 1]
7 3 2 1
After:  [0, 1, 2, 1]

Before: [2, 1, 3, 0]
11 0 0 3
After:  [2, 1, 3, 1]

Before: [3, 1, 3, 0]
0 1 0 3
After:  [3, 1, 3, 1]

Before: [1, 1, 3, 3]
13 2 1 1
After:  [1, 0, 3, 3]

Before: [1, 3, 2, 3]
9 0 2 3
After:  [1, 3, 2, 0]

Before: [0, 3, 1, 3]
8 0 3 1
After:  [0, 0, 1, 3]

Before: [2, 1, 0, 2]
4 0 3 3
After:  [2, 1, 0, 1]

Before: [2, 0, 2, 2]
3 2 3 3
After:  [2, 0, 2, 2]

Before: [2, 3, 1, 0]
11 0 0 0
After:  [1, 3, 1, 0]

Before: [3, 2, 3, 2]
11 0 0 2
After:  [3, 2, 1, 2]

Before: [2, 1, 2, 2]
4 0 3 3
After:  [2, 1, 2, 1]

Before: [3, 0, 3, 3]
5 3 3 1
After:  [3, 3, 3, 3]

Before: [2, 2, 2, 1]
7 3 2 1
After:  [2, 1, 2, 1]

Before: [2, 1, 2, 2]
3 2 3 2
After:  [2, 1, 2, 2]

Before: [1, 1, 2, 1]
7 3 2 2
After:  [1, 1, 1, 1]

Before: [2, 0, 2, 2]
5 2 2 0
After:  [2, 0, 2, 2]

Before: [2, 1, 3, 2]
4 0 3 1
After:  [2, 1, 3, 2]

Before: [0, 2, 2, 2]
3 2 3 3
After:  [0, 2, 2, 2]

Before: [0, 3, 2, 2]
14 0 0 0
After:  [0, 3, 2, 2]

Before: [2, 1, 3, 2]
10 1 3 0
After:  [0, 1, 3, 2]

Before: [3, 1, 2, 1]
7 3 2 0
After:  [1, 1, 2, 1]

Before: [2, 2, 1, 2]
4 0 3 2
After:  [2, 2, 1, 2]

Before: [3, 2, 1, 1]
11 0 0 2
After:  [3, 2, 1, 1]

Before: [0, 3, 3, 1]
13 0 0 1
After:  [0, 1, 3, 1]

Before: [3, 0, 2, 3]
13 3 2 2
After:  [3, 0, 0, 3]

Before: [0, 0, 0, 1]
6 3 3 2
After:  [0, 0, 0, 1]

Before: [2, 3, 1, 2]
4 0 3 1
After:  [2, 1, 1, 2]

Before: [2, 3, 2, 3]
0 2 0 3
After:  [2, 3, 2, 2]

Before: [1, 3, 2, 0]
9 0 2 0
After:  [0, 3, 2, 0]

Before: [0, 1, 0, 2]
6 3 3 0
After:  [0, 1, 0, 2]

Before: [0, 1, 2, 1]
1 1 2 2
After:  [0, 1, 0, 1]

Before: [1, 3, 2, 1]
7 3 2 0
After:  [1, 3, 2, 1]

Before: [0, 3, 2, 1]
8 0 2 1
After:  [0, 0, 2, 1]

Before: [2, 2, 0, 3]
5 3 3 1
After:  [2, 3, 0, 3]

Before: [1, 1, 2, 2]
3 2 3 3
After:  [1, 1, 2, 2]

Before: [0, 0, 3, 2]
11 2 2 1
After:  [0, 1, 3, 2]

Before: [0, 3, 1, 3]
2 2 3 3
After:  [0, 3, 1, 0]

Before: [3, 3, 3, 3]
11 2 0 0
After:  [1, 3, 3, 3]

Before: [2, 0, 0, 2]
4 0 3 0
After:  [1, 0, 0, 2]

Before: [0, 1, 2, 3]
2 2 3 1
After:  [0, 0, 2, 3]

Before: [2, 3, 2, 1]
7 3 2 2
After:  [2, 3, 1, 1]

Before: [3, 1, 2, 2]
10 1 3 0
After:  [0, 1, 2, 2]

Before: [0, 2, 3, 3]
14 0 0 3
After:  [0, 2, 3, 0]

Before: [3, 2, 2, 3]
13 3 1 1
After:  [3, 0, 2, 3]

Before: [1, 1, 2, 2]
9 0 2 3
After:  [1, 1, 2, 0]

Before: [0, 2, 1, 3]
14 0 0 2
After:  [0, 2, 0, 3]

Before: [1, 0, 2, 1]
7 3 2 3
After:  [1, 0, 2, 1]

Before: [0, 3, 2, 1]
7 3 2 3
After:  [0, 3, 2, 1]

Before: [0, 1, 3, 2]
11 2 2 0
After:  [1, 1, 3, 2]

Before: [0, 0, 2, 0]
13 0 0 2
After:  [0, 0, 1, 0]

Before: [3, 1, 1, 3]
11 0 0 2
After:  [3, 1, 1, 3]

Before: [3, 2, 1, 3]
0 3 0 3
After:  [3, 2, 1, 3]

Before: [1, 2, 2, 0]
9 0 2 0
After:  [0, 2, 2, 0]

Before: [3, 0, 0, 3]
0 3 0 0
After:  [3, 0, 0, 3]

Before: [1, 0, 1, 3]
2 2 3 0
After:  [0, 0, 1, 3]

Before: [0, 0, 2, 1]
7 3 2 3
After:  [0, 0, 2, 1]

Before: [1, 1, 2, 2]
15 1 0 3
After:  [1, 1, 2, 1]

Before: [2, 1, 1, 3]
2 1 3 0
After:  [0, 1, 1, 3]

Before: [0, 2, 0, 2]
8 0 3 0
After:  [0, 2, 0, 2]

Before: [3, 1, 0, 3]
0 3 0 0
After:  [3, 1, 0, 3]

Before: [2, 3, 2, 3]
2 2 3 1
After:  [2, 0, 2, 3]

Before: [2, 1, 2, 3]
0 2 0 0
After:  [2, 1, 2, 3]

Before: [2, 0, 2, 3]
8 1 0 3
After:  [2, 0, 2, 0]

Before: [1, 1, 2, 3]
2 2 3 1
After:  [1, 0, 2, 3]

Before: [0, 0, 2, 2]
8 0 3 1
After:  [0, 0, 2, 2]

Before: [1, 0, 2, 1]
7 3 2 0
After:  [1, 0, 2, 1]

Before: [1, 3, 2, 3]
9 0 2 2
After:  [1, 3, 0, 3]

Before: [1, 1, 3, 3]
11 2 2 1
After:  [1, 1, 3, 3]

Before: [1, 1, 0, 3]
15 1 0 1
After:  [1, 1, 0, 3]

Before: [2, 3, 3, 2]
4 0 3 1
After:  [2, 1, 3, 2]

Before: [2, 1, 0, 1]
6 3 3 0
After:  [0, 1, 0, 1]

Before: [1, 1, 2, 2]
10 1 3 2
After:  [1, 1, 0, 2]

Before: [2, 0, 2, 1]
7 3 2 3
After:  [2, 0, 2, 1]

Before: [2, 3, 2, 2]
13 2 2 3
After:  [2, 3, 2, 1]

Before: [0, 1, 1, 0]
14 0 0 0
After:  [0, 1, 1, 0]

Before: [0, 1, 3, 2]
14 0 0 1
After:  [0, 0, 3, 2]

Before: [0, 3, 2, 3]
8 0 1 2
After:  [0, 3, 0, 3]

Before: [2, 3, 1, 3]
2 2 3 0
After:  [0, 3, 1, 3]

Before: [0, 0, 1, 1]
8 0 2 0
After:  [0, 0, 1, 1]

Before: [0, 1, 0, 2]
10 1 3 0
After:  [0, 1, 0, 2]

Before: [2, 3, 3, 3]
5 3 3 3
After:  [2, 3, 3, 3]

Before: [0, 3, 2, 1]
7 3 2 2
After:  [0, 3, 1, 1]

Before: [1, 0, 2, 3]
2 2 3 1
After:  [1, 0, 2, 3]

Before: [2, 1, 2, 1]
7 3 2 3
After:  [2, 1, 2, 1]

Before: [3, 1, 1, 1]
0 1 0 0
After:  [1, 1, 1, 1]

Before: [2, 3, 0, 3]
5 3 3 3
After:  [2, 3, 0, 3]

Before: [2, 0, 2, 0]
13 2 2 0
After:  [1, 0, 2, 0]

Before: [3, 2, 2, 3]
13 3 2 2
After:  [3, 2, 0, 3]

Before: [2, 0, 2, 1]
0 2 0 2
After:  [2, 0, 2, 1]

Before: [3, 1, 2, 0]
1 1 2 0
After:  [0, 1, 2, 0]

Before: [1, 2, 2, 1]
9 0 2 3
After:  [1, 2, 2, 0]

Before: [3, 0, 1, 1]
0 3 0 0
After:  [1, 0, 1, 1]

Before: [3, 1, 3, 3]
0 1 0 2
After:  [3, 1, 1, 3]

Before: [0, 1, 1, 3]
2 1 3 1
After:  [0, 0, 1, 3]

Before: [0, 3, 3, 3]
5 3 3 1
After:  [0, 3, 3, 3]

Before: [3, 3, 2, 2]
13 2 2 3
After:  [3, 3, 2, 1]

Before: [1, 1, 2, 1]
1 1 2 3
After:  [1, 1, 2, 0]

Before: [1, 1, 3, 2]
15 1 0 0
After:  [1, 1, 3, 2]

Before: [1, 0, 2, 2]
5 2 2 1
After:  [1, 2, 2, 2]

Before: [2, 2, 1, 1]
11 0 1 1
After:  [2, 1, 1, 1]

Before: [0, 0, 3, 1]
14 0 0 1
After:  [0, 0, 3, 1]

Before: [2, 1, 2, 2]
10 1 3 1
After:  [2, 0, 2, 2]

Before: [0, 1, 0, 2]
10 1 3 3
After:  [0, 1, 0, 0]

Before: [3, 1, 2, 2]
1 1 2 3
After:  [3, 1, 2, 0]

Before: [1, 0, 2, 1]
9 0 2 3
After:  [1, 0, 2, 0]

Before: [2, 1, 2, 2]
1 1 2 1
After:  [2, 0, 2, 2]

Before: [2, 3, 1, 2]
4 0 3 0
After:  [1, 3, 1, 2]

Before: [2, 1, 3, 3]
5 3 3 3
After:  [2, 1, 3, 3]

Before: [2, 2, 3, 3]
2 1 3 0
After:  [0, 2, 3, 3]

Before: [1, 1, 3, 2]
15 1 0 1
After:  [1, 1, 3, 2]

Before: [2, 3, 2, 1]
7 3 2 1
After:  [2, 1, 2, 1]

Before: [1, 0, 2, 0]
9 0 2 2
After:  [1, 0, 0, 0]

Before: [3, 3, 2, 3]
5 2 2 1
After:  [3, 2, 2, 3]

Before: [3, 1, 2, 2]
1 1 2 1
After:  [3, 0, 2, 2]

Before: [0, 0, 2, 3]
2 2 3 3
After:  [0, 0, 2, 0]

Before: [3, 3, 1, 3]
2 2 3 0
After:  [0, 3, 1, 3]

Before: [2, 2, 2, 3]
0 2 0 1
After:  [2, 2, 2, 3]

Before: [3, 1, 2, 1]
0 1 0 2
After:  [3, 1, 1, 1]

Before: [3, 3, 2, 1]
7 3 2 0
After:  [1, 3, 2, 1]

Before: [0, 1, 2, 0]
1 1 2 2
After:  [0, 1, 0, 0]

Before: [0, 0, 1, 0]
14 0 0 0
After:  [0, 0, 1, 0]

Before: [0, 2, 2, 1]
12 2 1 3
After:  [0, 2, 2, 1]

Before: [3, 2, 3, 1]
6 3 3 3
After:  [3, 2, 3, 0]

Before: [1, 1, 2, 1]
1 1 2 2
After:  [1, 1, 0, 1]

Before: [2, 3, 1, 2]
4 0 3 3
After:  [2, 3, 1, 1]

Before: [2, 2, 1, 2]
4 0 3 1
After:  [2, 1, 1, 2]

Before: [2, 1, 1, 2]
4 0 3 0
After:  [1, 1, 1, 2]



9 2 0 1
9 0 1 0
9 3 0 3
10 3 1 1
8 1 1 1
14 1 2 2
7 2 2 1
9 1 3 3
9 1 2 0
9 3 0 2
8 3 2 3
8 3 1 3
14 3 1 1
7 1 3 2
9 1 2 3
8 0 0 0
0 0 2 0
8 1 0 1
0 1 3 1
15 3 0 0
8 0 3 0
8 0 2 0
14 2 0 2
7 2 1 1
9 1 2 2
8 0 0 0
0 0 3 0
9 0 3 3
1 0 2 2
8 2 1 2
14 2 1 1
7 1 0 2
8 2 0 3
0 3 2 3
9 2 1 0
9 3 3 1
4 0 3 0
8 0 3 0
14 0 2 2
9 1 1 3
9 1 2 1
9 1 0 0
14 1 3 0
8 0 1 0
14 0 2 2
9 2 1 1
9 2 2 0
6 0 3 1
8 1 2 1
8 1 2 1
14 1 2 2
7 2 2 1
9 1 0 0
8 1 0 3
0 3 0 3
9 3 0 2
12 3 2 0
8 0 3 0
8 0 1 0
14 0 1 1
9 1 2 0
8 3 0 3
0 3 1 3
9 0 0 2
8 0 2 2
8 2 2 2
14 1 2 1
9 2 0 0
8 0 0 2
0 2 2 2
6 0 3 0
8 0 1 0
8 0 3 0
14 0 1 1
7 1 0 3
9 2 3 0
9 3 3 2
9 3 0 1
1 1 2 2
8 2 2 2
14 3 2 3
7 3 3 0
9 0 1 2
9 0 1 1
9 3 1 3
1 3 2 2
8 2 3 2
14 0 2 0
7 0 0 3
9 2 2 0
9 1 1 1
9 3 2 2
13 0 2 1
8 1 2 1
8 1 2 1
14 3 1 3
7 3 0 1
9 2 2 3
9 0 1 2
12 2 3 2
8 2 1 2
14 1 2 1
8 1 0 2
0 2 2 2
9 1 2 3
8 2 0 0
0 0 1 0
7 0 2 0
8 0 3 0
8 0 2 0
14 1 0 1
7 1 0 0
8 3 0 2
0 2 1 2
9 1 3 1
14 1 3 3
8 3 1 3
8 3 3 3
14 0 3 0
9 2 1 1
9 0 1 3
9 2 3 3
8 3 2 3
8 3 3 3
14 0 3 0
7 0 2 1
9 1 2 3
9 2 1 0
6 0 3 2
8 2 3 2
14 1 2 1
7 1 2 3
9 1 1 0
9 2 1 2
9 3 1 1
0 0 1 2
8 2 2 2
14 2 3 3
7 3 1 0
9 2 1 3
8 0 0 2
0 2 3 2
9 0 0 1
9 2 1 2
8 2 3 2
8 2 3 2
14 0 2 0
7 0 1 2
9 1 2 3
9 2 3 1
9 3 2 0
10 0 1 0
8 0 2 0
14 2 0 2
7 2 0 3
8 2 0 2
0 2 3 2
9 2 1 0
8 1 0 1
0 1 3 1
10 1 0 1
8 1 2 1
8 1 3 1
14 1 3 3
7 3 2 0
9 1 0 1
9 1 3 3
9 2 3 1
8 1 2 1
14 1 0 0
7 0 3 2
9 2 3 0
9 3 0 3
9 2 1 1
10 3 0 1
8 1 3 1
14 2 1 2
7 2 0 0
9 3 0 2
9 3 0 1
9 2 1 3
10 1 3 3
8 3 2 3
14 3 0 0
7 0 0 2
9 1 3 3
9 2 0 0
9 1 1 1
6 0 3 0
8 0 1 0
14 0 2 2
7 2 0 3
8 2 0 0
0 0 1 0
9 2 0 2
9 2 3 1
7 0 2 0
8 0 2 0
14 0 3 3
9 3 2 1
9 1 0 2
9 1 0 0
0 0 1 0
8 0 2 0
14 3 0 3
7 3 3 1
9 2 2 3
9 2 0 2
9 1 3 0
7 0 2 3
8 3 3 3
8 3 2 3
14 1 3 1
9 0 3 2
9 3 3 3
8 0 2 3
8 3 2 3
8 3 2 3
14 3 1 1
8 1 0 0
0 0 0 0
9 1 3 3
9 3 0 2
8 3 2 2
8 2 2 2
14 1 2 1
7 1 0 2
9 2 0 0
9 0 2 1
9 2 1 3
5 0 3 3
8 3 1 3
8 3 3 3
14 2 3 2
9 1 2 3
9 1 0 1
15 3 0 0
8 0 2 0
14 0 2 2
7 2 0 0
9 1 2 2
9 2 0 3
15 1 3 2
8 2 1 2
14 2 0 0
9 0 0 3
8 3 0 2
0 2 2 2
9 0 1 1
5 2 3 1
8 1 1 1
8 1 3 1
14 0 1 0
9 3 2 2
9 3 0 1
9 2 2 3
1 1 2 2
8 2 3 2
14 2 0 0
7 0 1 3
9 2 3 2
9 2 2 0
11 0 1 2
8 2 1 2
14 3 2 3
7 3 0 1
9 2 3 2
9 1 1 0
9 3 3 3
7 0 2 3
8 3 1 3
14 1 3 1
9 3 3 2
8 1 0 3
0 3 3 3
8 3 0 0
0 0 2 0
13 0 2 2
8 2 2 2
8 2 2 2
14 1 2 1
9 2 2 2
9 1 3 3
6 0 3 2
8 2 3 2
14 1 2 1
7 1 0 2
9 3 3 1
9 1 0 0
0 3 1 1
8 1 3 1
14 2 1 2
7 2 1 1
9 2 1 0
8 3 0 3
0 3 3 3
9 3 3 2
3 0 2 2
8 2 1 2
8 2 1 2
14 2 1 1
7 1 2 2
8 2 0 3
0 3 1 3
9 0 1 1
6 0 3 1
8 1 1 1
14 2 1 2
9 0 3 1
9 3 2 0
9 2 3 3
10 0 3 1
8 1 2 1
8 1 2 1
14 2 1 2
7 2 3 3
9 0 1 2
9 1 0 0
9 3 3 1
8 0 2 1
8 1 1 1
14 3 1 3
7 3 1 2
9 2 0 1
9 0 2 3
9 2 3 0
5 1 3 1
8 1 3 1
8 1 1 1
14 1 2 2
7 2 0 1
9 3 2 0
8 0 0 2
0 2 0 2
9 3 2 3
13 2 0 0
8 0 3 0
14 1 0 1
8 3 0 2
0 2 2 2
8 1 0 0
0 0 1 0
7 0 2 2
8 2 3 2
8 2 1 2
14 1 2 1
7 1 2 2
9 0 0 3
8 2 0 1
0 1 1 1
14 0 0 0
8 0 2 0
14 2 0 2
7 2 3 3
8 2 0 0
0 0 3 0
8 0 0 1
0 1 3 1
9 0 0 2
1 0 2 0
8 0 1 0
14 0 3 3
7 3 2 1
9 1 2 3
9 2 1 0
6 0 3 0
8 0 2 0
8 0 3 0
14 0 1 1
7 1 0 3
9 2 0 2
9 1 1 0
8 2 0 1
0 1 2 1
7 0 2 1
8 1 2 1
8 1 3 1
14 3 1 3
9 1 1 1
7 0 2 1
8 1 1 1
14 1 3 3
7 3 3 2
9 2 0 3
9 3 1 1
0 0 1 0
8 0 1 0
14 2 0 2
7 2 0 3
8 0 0 2
0 2 1 2
9 2 0 0
1 1 2 1
8 1 1 1
14 1 3 3
7 3 1 2
9 1 2 1
9 2 0 3
15 1 3 0
8 0 2 0
14 0 2 2
9 3 2 3
9 2 0 0
9 3 2 1
11 0 1 0
8 0 3 0
14 0 2 2
7 2 3 3
9 3 1 0
9 3 3 2
9 1 2 1
8 1 2 1
8 1 1 1
8 1 3 1
14 3 1 3
7 3 0 0
9 2 2 2
8 1 0 3
0 3 0 3
9 0 2 1
2 3 2 1
8 1 1 1
14 1 0 0
7 0 0 1
9 2 1 0
9 3 2 2
12 3 2 2
8 2 3 2
14 2 1 1
7 1 0 2
8 0 0 1
0 1 3 1
9 2 3 3
10 1 3 1
8 1 2 1
14 1 2 2
7 2 2 1
9 1 0 2
5 0 3 0
8 0 1 0
14 0 1 1
7 1 3 3
9 3 3 2
9 2 0 0
9 3 1 1
13 0 2 2
8 2 3 2
8 2 1 2
14 3 2 3
9 3 3 2
8 2 0 1
0 1 0 1
3 0 2 1
8 1 3 1
8 1 3 1
14 1 3 3
7 3 2 1
9 1 3 3
13 0 2 2
8 2 2 2
14 2 1 1
7 1 2 0
9 2 1 3
9 1 0 1
9 2 0 2
5 2 3 3
8 3 1 3
14 0 3 0
8 1 0 3
0 3 2 3
9 3 1 1
10 1 3 1
8 1 3 1
8 1 1 1
14 0 1 0
9 3 3 1
9 3 2 3
11 2 1 1
8 1 2 1
8 1 1 1
14 1 0 0
7 0 0 1
9 0 2 2
8 2 0 0
0 0 3 0
8 1 0 3
0 3 2 3
13 2 0 3
8 3 3 3
14 3 1 1
9 1 1 2
8 1 0 3
0 3 1 3
14 3 3 3
8 3 3 3
14 3 1 1
7 1 3 3
9 3 0 2
9 1 0 1
9 2 1 0
8 0 1 0
8 0 2 0
14 0 3 3
7 3 3 2
8 3 0 0
0 0 2 0
8 3 0 1
0 1 3 1
9 1 1 3
6 0 3 0
8 0 2 0
14 2 0 2
9 1 0 1
9 2 1 3
9 0 2 0
15 1 3 1
8 1 3 1
14 2 1 2
7 2 3 1
9 1 3 0
9 3 1 2
9 0 0 3
12 3 2 3
8 3 1 3
14 3 1 1
7 1 1 2
9 1 1 3
9 2 3 0
9 0 1 1
15 3 0 0
8 0 2 0
14 0 2 2
7 2 3 0
8 1 0 1
0 1 2 1
9 0 2 3
9 2 2 2
2 3 2 3
8 3 3 3
14 0 3 0
7 0 0 2
9 3 3 0
9 2 2 3
3 1 0 1
8 1 1 1
14 1 2 2
9 0 1 1
10 0 3 0
8 0 1 0
8 0 2 0
14 0 2 2
8 3 0 0
0 0 2 0
4 0 3 3
8 3 3 3
14 3 2 2
7 2 3 0
8 0 0 3
0 3 1 3
9 3 2 1
9 2 0 2
14 3 3 1
8 1 3 1
14 1 0 0
7 0 1 2
9 1 0 0
9 2 0 3
9 3 0 1
10 1 3 3
8 3 2 3
14 2 3 2
7 2 2 1
8 3 0 3
0 3 0 3
9 2 1 2
8 3 0 0
0 0 3 0
11 2 0 3
8 3 1 3
8 3 1 3
14 1 3 1
9 1 0 3
9 3 2 2
9 2 0 0
13 0 2 3
8 3 2 3
14 3 1 1
8 3 0 3
0 3 3 3
8 0 0 0
0 0 1 0
8 0 2 0
8 0 3 0
14 1 0 1
7 1 1 3
9 1 3 1
9 2 1 0
13 0 2 0
8 0 2 0
8 0 2 0
14 3 0 3
7 3 3 0
8 0 0 3
0 3 3 3
9 0 2 1
1 3 2 2
8 2 2 2
14 2 0 0
9 3 2 2
9 3 1 1
1 3 2 1
8 1 3 1
8 1 1 1
14 1 0 0
7 0 2 2
9 3 3 1
9 1 2 0
9 1 0 3
0 0 1 1
8 1 3 1
14 2 1 2
7 2 3 1
8 3 0 2
0 2 3 2
8 3 0 0
0 0 2 0
9 2 1 3
4 0 3 0
8 0 1 0
14 0 1 1
9 3 1 3
9 2 3 2
9 2 0 0
10 3 0 0
8 0 3 0
14 1 0 1
8 0 0 3
0 3 0 3
9 1 0 0
7 0 2 2
8 2 1 2
14 1 2 1
9 3 0 0
8 2 0 2
0 2 0 2
13 2 0 2
8 2 3 2
14 1 2 1
9 3 0 2
9 2 2 3
9 2 2 0
3 0 2 3
8 3 2 3
14 3 1 1
7 1 2 2
9 2 0 3
8 1 0 1
0 1 1 1
4 0 3 3
8 3 3 3
8 3 1 3
14 3 2 2
7 2 2 1
9 3 0 0
8 0 0 2
0 2 0 2
9 2 1 3
13 2 0 2
8 2 3 2
14 1 2 1
7 1 1 2
9 0 1 1
9 1 0 0
8 3 0 3
0 3 3 3
0 0 1 1
8 1 1 1
14 1 2 2
7 2 3 1
9 2 3 0
9 2 1 3
9 2 0 2
4 0 3 3
8 3 3 3
14 1 3 1
9 1 1 3
8 1 0 2
0 2 0 2
6 0 3 3
8 3 3 3
14 3 1 1
7 1 1 3
9 1 2 0
9 3 0 1
9 3 1 2
0 0 1 0
8 0 1 0
14 0 3 3
7 3 3 1
8 1 0 0
0 0 1 0
9 2 2 3
9 2 0 2
7 0 2 0
8 0 2 0
14 0 1 1
7 1 0 2
9 1 0 3
9 2 1 1
9 1 1 0
14 0 0 1
8 1 1 1
8 1 2 1
14 1 2 2
7 2 1 3
9 2 3 0
9 3 1 2
9 2 3 1
13 0 2 0
8 0 3 0
14 3 0 3
7 3 0 2
9 3 1 1
9 1 0 3
9 2 2 0
11 0 1 3
8 3 1 3
14 2 3 2
7 2 2 1
8 2 0 0
0 0 1 0
9 2 1 2
9 1 3 3
7 0 2 3
8 3 3 3
14 3 1 1
7 1 2 0
9 0 1 3
9 1 1 1
2 3 2 2
8 2 1 2
14 2 0 0
7 0 3 3
9 3 0 1
9 1 3 0
8 3 0 2
0 2 2 2
0 0 1 1
8 1 2 1
14 1 3 3
7 3 1 2
9 2 1 1
9 1 2 3
9 2 1 0
6 0 3 0
8 0 1 0
8 0 3 0
14 0 2 2
9 2 1 3
9 1 3 1
9 2 1 0
4 0 3 1
8 1 3 1
8 1 1 1
14 1 2 2
7 2 3 1
9 1 3 2
9 3 3 0
9 0 2 3
9 2 0 2
8 2 1 2
14 2 1 1
9 3 2 3
8 1 0 2
0 2 0 2
9 2 2 0
10 3 0 3
8 3 2 3
14 1 3 1
9 0 1 3
9 2 1 2
2 3 2 0
8 0 2 0
14 1 0 1
7 1 0 3
9 3 0 0
9 0 3 1
11 2 0 0
8 0 2 0
14 3 0 3
9 3 3 2
9 3 2 0
9 2 1 1
1 0 2 0
8 0 3 0
14 3 0 3
7 3 0 2
8 1 0 0
0 0 2 0
9 1 0 3
8 0 0 1
0 1 0 1
6 0 3 3
8 3 2 3
8 3 1 3
14 3 2 2
7 2 0 3
9 3 2 2
13 0 2 2
8 2 1 2
14 3 2 3
7 3 3 1
8 0 0 3
0 3 1 3
9 3 1 0
9 2 0 2
11 2 0 3
8 3 1 3
14 3 1 1
9 0 1 3
9 0 1 0
2 3 2 2
8 2 2 2
8 2 2 2
14 2 1 1
7 1 3 3
9 0 2 2
9 3 1 1
1 1 2 2
8 2 3 2
14 2 3 3
7 3 3 0



