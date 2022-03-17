len row[] 810
len col[] 810
len box[] 810
len grid[] 82
# 
func init . .
  for pos range 81
    if pos mod 9 = 0
      s$ = input
      if s$ = ""
        s$ = input
      .
      len inp[] 0
      for i range len s$
        if substr s$ i 1 <> " "
          inp[] &= number substr s$ i 1
        .
      .
    .
    dig = number inp[pos mod 9]
    grid[pos] = dig
    r = pos div 9
    c = pos mod 9
    b = r div 3 * 3 + c div 3
    row[r * 10 + dig] = 1
    col[c * 10 + dig] = 1
    box[b * 10 + dig] = 1
  .
.
call init
# 
func display . .
  for i range 81
    write grid[i] & " "
    if i mod 3 = 2
      write " "
    .
    if i mod 9 = 8
      print ""
    .
    if i mod 27 = 26
      print ""
    .
  .
.
# 
func solve pos . .
  while grid[pos] <> 0
    pos += 1
  .
  if pos = 81
    # solved
    call display
    break 1
  .
  r = pos div 9
  c = pos mod 9
  b = r div 3 * 3 + c div 3
  r *= 10
  c *= 10
  b *= 10
  for d = 1 to 9
    if row[r + d] = 0 and col[c + d] = 0 and box[b + d] = 0
      grid[pos] = d
      row[r + d] = 1
      col[c + d] = 1
      box[b + d] = 1
      call solve pos + 1
      row[r + d] = 0
      col[c + d] = 0
      box[b + d] = 0
    .
  .
  grid[pos] = 0
.
call solve 0
# 
input_data
5 3 0  0 2 4  7 0 0
0 0 2  0 0 0  8 0 0
1 0 0  7 0 3  9 0 2

0 0 8  0 7 2  0 4 9
0 2 0  9 8 0  0 7 0
7 9 0  0 0 0  0 8 0

0 0 0  0 3 0  5 0 6
9 6 0  0 1 0  3 0 0
0 5 0  6 9 0  0 1 0


