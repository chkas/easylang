# AoC-21 - Day 11: Dumbo Octopus
# 
# First increase all fields by 1. Then let
# the flash spread 9 times (because of
# field dimension 10).  
# 
# WARNING: Flashing
# 
visualization = 1
# 
global m[][] .
# 
background 000
if visualization = 1
  move 10 10
  text "WARNING: Flashing"
  sleep 3
.
color 321
func draw . .
  if visualization = 0
    break 1
  .
  clear
  for y range 10
    for x range 10
      sz = m[y][x]
      if sz = 11
        sz = 15
      .
      move 5 + 10 * x 5 + 10 * y
      circle sz / 2
    .
  .
  sleep 0.2
.
for _ range 10
  m[][] &= number strchars input
.
repeat
  for y range 10
    for x range 10
      m[y][x] += 1
    .
  .
  for _ range 9
    for y range 10
      for x range 10
        # 
        if m[y][x] = 10
          m[y][x] = 11
          for nx = higher (x - 1) 0 to lower (x + 1) 9
            for ny = higher (y - 1) 0 to lower (y + 1) 9
              # 
              if m[ny][nx] < 10
                m[ny][nx] += 1
              .
            .
          .
        .
      .
    .
  .
  call draw
  h = n_flash
  for y range 10
    for x range 10
      # 
      if m[y][x] = 11
        n_flash += 1
        m[y][x] = 0
      .
    .
  .
  count += 1
  if count = 100
    print n_flash
  .
  until n_flash - h = 100
.
print count
# 
input_data
5651341452
1381541252
1878435224
6814831535
3883547383
6473548464
1885833658
3732584752
1881546128
5121717776


