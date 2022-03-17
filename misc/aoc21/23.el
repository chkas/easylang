# AoC-21 - Day 23: Amphipod
# 
# Dijkstra's algorithm. For each field there
# are 5 possibilities (empty, A-D), so you
# can store each state (7 + 16) fields in a
# number up to 5^23 and then create a "seen" 
# hash map.
#
visualization = 1
# 
hashsz = 1999993
len hashind[] hashsz
# 
func hash ind . ret .
  hi = ind mod hashsz
  while hashind[hi] <> 0 and hashind[hi] <> ind
    hi = (hi + 1) mod hashsz
  .
  if hashind[hi] = 0
    hashind[hi] = ind
    ret = 0
  else
    ret = 1
  .
.
m[] = [ 0 0 -1 0 -1 0 -1 0 -1 0 0 ]
global m0[] destid dim .
# 
func tonum . n .
  n = 0
  for i range len m0[]
    n = n * 5 + m0[i]
  .
  for i range 11
    if m[i] <> -1
      n = n * 5 + m[i]
    .
  .
.
func toarr n . .
  for i = 10 downto 0
    if m[i] <> -1
      m[i] = n mod 5
      n = n div 5
    .
  .
  for i = len m0[] - 1 downto 0
    m0[i] = n mod 5
    n = n div 5
  .
.
# 
sz = 8.5
sz2 = sz / 2
background 000
acol[] = [ 0 373 773 751 733 ]
func show cost t . .
  if visualization = 0
    break 1
  .
  clear
  x = 3
  y = 10 + sz
  move x y
  color 333
  rect 11 * sz sz
  for c range 4
    move 3 + (2 + c * 2) * sz y + sz
    rect sz dim * sz
  .
  textsize 4
  for i range 11
    if m[i] > 0
      move x + sz2 y + sz2
      color acol[m[i]]
      circle sz2 - 1
      color 000
      move x + 3 y + 2
      text strchar (m[i] + 65 - 1)
    .
    x += sz
  .
  i = 0
  for r range dim
    x = 3 + 2 * sz
    y += sz
    for c range 4
      if m0[i] > 0
        move x + sz2 y + sz2
        color acol[m0[i]]
        circle sz2 - 1
        color 000
        move x + 3 y + 2
        text strchar (m0[i] + 65 - 1)
      .
      i += 1
      x += 2 * sz
    .
  .
  textsize 6
  color 555
  move 5 70
  text "Energy: " & cost
  sleep t
.
# 
func read . .
  s$ = input
  s$ = input
  for l range 2
    s$ = input
    for i in [ 3 5 7 9 ]
      a = (strcode substr s$ i 1) - 65 + 1
      m0[ind] = a
      ind += 1
    .
  .
.
global m0saved[] .
func init . .
  dim = 2
  for i range 8
    m0[] &= (i mod 4) + 1
  .
  call tonum destid
  call read
  m0saved[] = m0[]
.
# 
func prepare_part2 . .
  dim = 4
  len m0[] 16
  for i range 16
    m0[i] = (i mod 4) + 1
  .
  call tonum destid
  for i range 4
    m0[i] = m0saved[i]
    m0[12 + i] = m0saved[4 + i]
  .
  h[] = [ 4 3 2 1 4 2 1 3 ]
  for i range 8
    m0[4 + i] = h[i]
  .
  m[] = [ 0 0 -1 0 -1 0 -1 0 -1 0 0 ]
.
# 
amp[] = [ 0 1 10 100 1000 ]
func init_cost . cost .
  cost = 0
  for i range 4
    for j range dim
      m = m0[i + j * 4]
      cost += amp[m] * (j + 1)
      cost += amp[i + 1] * (j + 1)
    .
    j = (dim - 1)
    repeat
      m = m0[i + j * 4]
      until m <> i + 1
      cost -= amp[m] * (j + 1)
      cost -= amp[i + 1] * (j + 1)
      j -= 1
    .
  .
.
global todo[] cost[] prev[] .
# 
func show_way cur cost . .
  list[] &= cur
  repeat
    for i = 0 step 2 to len prev[] - 2
      if cur = prev[i]
        cur = prev[i + 1]
        break 1
      .
    .
    if i > len prev[] - 2
      break 1
    .
    until cur = 0
    list[] &= cur
  .
  for i = len list[] - 1 downto 0
    call toarr list[i]
    call show cost 1
  .
.
# 
func take_min . cur cost .
  if len todo[] = 0
    cur = -1
    break 1
  .
  cost = 1 / 0
  for i range len todo[]
    if cost[i] < cost
      cost = cost[i]
      ind = i
    .
  .
  cur = todo[ind]
  last = len todo[] - 1
  todo[ind] = todo[last]
  cost[ind] = cost[last]
  len todo[] last
  len cost[] last
.
func go_home . cur .
  call toarr cur
  while done = 0
    done = 1
    for i range 11
      if m[i] > 0
        dpos = m[i] - 1
        j = dpos * 2 + 2
        dir = sign (i - j)
        while 1 = 1
          if j = i
            h = (dim - 1) * 4
            while m0[dpos + h] = dpos + 1
              h -= 4
            .
            if m0[dpos + h] = 0
              done = 0
              m0[dpos + h] = m[i]
              m[i] = 0
              cur0 = cur
              call tonum cur
              prev[] &= cur
              prev[] &= cur0
              break 2
            else
              break 1
            .
          .
          if m[j] > 0
            break 1
          .
          j += dir
        .
      .
    .
  .
.
func add_ways cur cost . .
  for box range 4
    m0i = -1
    i = 0
    while i < dim * 4 and m0[box + i] = 0
      i += 4
    .
    if i < dim * 4
      m0i = box + i
      if m0[box + i] = box + 1
        i += 4
        while i < dim * 4 and m0[box + i] = box + 1
          i += 4
        .
        if i = dim * 4
          m0i = -1
        .
      .
    .
    if m0i >= 0
      m = m0[m0i]
      m0[m0i] = 0
      pos = 2 * box + 2
      for endpos in [ 0 10 ]
        dir = sign (endpos - 5)
        for i = pos step dir to endpos
          if m[i] > 0
            break 1
          .
          if m[i] = 0
            m[i] = m
            call tonum new
            m[i] = 0
            call hash new r
            if r = 0
              prev[] &= new
              prev[] &= cur
              todo[] &= new
              cost[] &= cost + abs (i - pos) * amp[m] + abs (i - 2 * m) * amp[m]
            .
          .
        .
      .
      m0[m0i] = m
    .
  .
.
func run . cur cost .
  call init_cost cost
  call tonum n
  todo[] = [ n ]
  cost[] = [ cost ]
  prev[] &= n
  prev[] &= 0
  repeat
    call take_min cur cost
    until cur = -1
    call go_home cur
    if cnt mod 100 = 0
      call show cost 0.01
    .
    cnt += 1
    if cur = destid
      print cost
      break 1
    .
    call add_ways cur cost
  .
.
call init
call run cur cost
call show_way cur cost
# 
call prepare_part2
call run cur cost
call show_way cur cost
# 
input_data
#############
#...........#
###D#B#D#B###
  #C#A#A#C#
  #########


