# AoC-19 - Day 24: Planet of Discord
# 
visual = 1
# 
global inp[] .
func parse . .
  for r range 5
    for c$ in strchars input
      inp[] &= if c$ = "#"
    .
  .
.
call parse
# 
n = 5
n1 = n + 1
n2 = n + 2
len f[] n1 * n1 + n2
len p[] n1 * n1 + n2
# 
func init . .
  for r range n
    for c range n
      f[r * n1 + c + n2] = inp[r * 5 + c]
    .
  .
.
call init
# 
divi[] = [ ]
found = 0
divi = 0
# 
if visual = 1
  move 10 10
  text "WARNING: Flashing"
  sleep 3
  background 210
  color 432
.
func show . .
  if visual = 0
    break 1
  .
  clear
  for r range n
    for c range n
      if f[r * n1 + c + n2] = 1
        move c * 100 / n r * 100 / n
        rect 98 / n 98 / n
      .
    .
  .
  sleep 0.05
.
func update . .
  swap f[] p[]
  for r range n
    for c range n
      i = r * n1 + c + n2
      s = p[i - n1]
      s += p[i - 1] + p[i + 1]
      s += p[i + n1]
      if p[i] = 1 and s <> 1
        f[i] = 0
      elif p[i] = 0 and (s = 1 or s = 2)
        f[i] = 1
      else
        f[i] = p[i]
      .
    .
  .
.
func part1 . .
  repeat
    call show
    f = 1
    divi = 0
    for r range n
      for c range n
        if f[r * n1 + c + n2] = 1
          divi += f
        .
        f *= 2
      .
    .
    for i range len divi[]
      if divi[i] = divi
        found = 1
      .
    .
    divi[] &= divi
    until found = 1
    call update
  .
  print divi
.
call part1
# 
# 
lev0 = 120
len f[] 25 * (lev0 * 2) + 25
len p[] len f[]
# 
func init2 . .
  for i range len f[]
    f[i] = 0
  .
  for r range 5
    for c range 5
      i = r * 5 + c + lev0 * 25
      f[i] = inp[r * 5 + c]
    .
  .
.
func show2 . .
  if visual = 0
    break 1
  .
  for i range 4
    b = 25 * (lev0 - 1 + i)
    off = -170
    sz = 440
    for j range i
      off += 2 / 5 * sz
      sz = sz / 5
    .
    color 321 + 111 * i
    move off off
    rect sz sz
    color 210 + 111 * i
    f = sz / 5
    fs = f * 0.96
    off += 0.02 * f
    for r range 5
      for c range 5
        if r <> 2 or c <> 2
          if f[b + r * 5 + c] = 1
            move off + c * f off + r * f
            rect fs fs
          .
        .
      .
    .
  .
  sleep 0.02
.
func sum5 b inc . s .
  i = b
  for j range 5
    s += p[i]
    i += inc
  .
.
func updatel lev . dirty .
  dirty = 0
  b = lev * 25
  for r range 5
    for c range 5
      if r <> 2 or c <> 2
        s = 0
        i = r * 5 + c + b
        if p[i] = 1
          dirty = 1
        .
        # above
        if r = 0
          s += p[b - 18]
        elif r = 3 and c = 2
          call sum5 b + 45 1 s
        else
          s += p[i - 5]
        .
        # left
        if c = 0
          s += p[b - 14]
        elif c = 3 and r = 2
          call sum5 b + 29 5 s
        else
          s += p[i - 1]
        .
        # right
        if c = 4
          s += p[b - 12]
        elif c = 1 and r = 2
          call sum5 b + 25 5 s
        else
          s += p[i + 1]
        .
        # below
        if r = 4
          s += p[b - 8]
        elif r = 1 and c = 2
          call sum5 b + 25 1 s
        else
          s += p[i + 5]
        .
        # 
        if p[i] = 1 and s <> 1
          f[i] = 0
        elif p[i] = 0 and (s = 1 or s = 2)
          f[i] = 1
        else
          f[i] = p[i]
        .
      .
    .
  .
.
func update2 . .
  swap f[] p[]
  call updatel lev0 h
  repeat
    i += 1
    call updatel lev0 - i dirty1
    call updatel lev0 + i dirty2
    until dirty1 = 0 and dirty2 = 0 or i = lev0 - 1
  .
  if i = lev0 - 1
    print "error space"
  .
.
func part2 . .
  call init2
  call show2
  sleep 0.02
  for i range 200
    call update2
    call show2
  .
  for i range len f[]
    s += f[i]
  .
  print s
.
call part2
# 
input_data
#.###
.....
#..#.
##.##
..#.#
.




