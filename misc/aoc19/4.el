# AoC-19 - Day 4: Secure Container
# 
inp[] = number strsplit input "-"
func part1 . .
  for i = inp[0] to inp[1]
    ok = 1
    ok2 = 0
    h = i
    m = 10
    while h > 0
      if h mod 10 > m
        ok = 0
      elif h mod 10 = m
        ok2 = 1
      .
      m = h mod 10
      h = h div 10
    .
    ans += (ok + ok2) div 2
  .
  print ans
.
call part1
# 
func part2 . .
  for i = inp[0] to inp[1]
    ok = 1
    ok2 = 0
    h = i
    m = 10
    cnt = 0
    while h > 0
      if h mod 10 > m
        ok = 0
      .
      if h mod 10 = m
        cnt += 1
      else
        if cnt = 1
          ok2 = 1
        .
        cnt = 0
      .
      m = h mod 10
      h = h div 10
    .
    if cnt = 1
      ok2 = 1
    .
    ans += (ok + ok2) div 2
  .
  print ans
.
call part2
# 
input_data
145852-616942


