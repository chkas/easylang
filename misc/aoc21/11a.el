# AoC-21 - Day 11: Dumbo Octopus
# 
# WARNING: flashing
visualization = 1
# 
global m[] .
nc = 12
# 
background 000
color 222
func draw . .
  if visualization = 0
    break 1
  .
  clear
  for y range 10
    for x range 10
      sz = m[x + 1 + y * nc + nc]
      if sz = 11
        sz = 15
      .
      move 5 + 10 * x 5 + 10 * y
      circle sz / 2
    .
  .
  sleep 0.2
.
for i range nc
  m[] &= 99
.
repeat
  inp$ = input
  until inp$ = ""
  m[] &= 99
  for i range nc - 2
    m[] &= number substr inp$ i 1
  .
  m[] &= 99
.
for i range nc
  m[] &= 99
.
# 
repeat
  for i range len m[]
    m[i] += 1
  .
  for l range 10
    for i range len m[]
      if m[i] = 10
        m[i] = 11
        for d in [ -nc (-nc + 1) 1 nc + 1 nc nc - 1 (-1) (-nc - 1) ]
          if m[i + d] < 10
            m[i + d] += 1
          .
        .
      .
    .
  .
  call draw
  h = n_flash
  for i range len m[]
    if m[i] = 11
      n_flash += 1
      m[i] = 0
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
1881546nc8
5121717776


