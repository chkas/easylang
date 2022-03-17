# AoC-20 - Day 23: Crab Cups
# 
global n next[] cur .
inp[] = number strchars input
# 
func init n0 . .
  n = n0
  len next[] n
  cur = inp[0] - 1
  h = cur
  for i = 1 to len inp[] - 1
    next[h] = inp[i] - 1
    h = next[h]
  .
  for i = i to n - 1
    next[h] = i
    h = i
  .
  next[h] = cur
.
func mov . .
  tak1 = next[cur]
  tak2 = next[tak1]
  tak3 = next[tak2]
  next[cur] = next[tak3]
  dest = cur
  repeat
    dest = (dest - 1) mod n
    until dest <> tak1 and dest <> tak2 and dest <> tak3
  .
  next[tak3] = next[dest]
  next[dest] = tak1
  cur = next[cur]
.
func part1 . .
  call init 9
  for _ range 100
    call mov
  .
  h = next[0]
  while h <> 0
    s$ &= h + 1
    h = next[h]
  .
  print s$
.
call part1
# 
func part2 . .
  call init 1000000
  for _ range 10000000
    call mov
  .
  print (next[0] + 1) * (next[next[0]] + 1)
.
call part2
# 
input_data
158937462



