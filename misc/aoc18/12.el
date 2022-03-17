# AoC-18 - Day 12: Subterranean Sustainability
# 
n_rounds = 200
a$[] = strchars substr input 15 999
len f[] 4 + 2 * n_rounds + len a$[]
len p[] len f[]
for i range len a$[]
  if a$[i] = "#"
    f[i + n_rounds + 2] = 1
  .
.
_$ = input
# 
len rul[] 32
for _ range 32
  a$[] = strchars input
  ri = 0
  for i range 5
    ri *= 2
    if a$[i] = "#"
      ri += 1
    .
  .
  if a$[9] = "#"
    rul[ri] = 1
  .
.
for ro range n_rounds
  sp = s
  s = 0
  swap f[] p[]
  for i = 2 to len f[] - 3
    ri = 0
    for j = -2 to 2
      ri *= 2
      ri += p[i + j]
    .
    f[i] = rul[ri]
    s += f[i] * (i - n_rounds - 2)
  .
  if ro = 19
    print s
  .
.
dif = s - sp
print 50000000000 * dif - n_rounds * dif + s
# 
input_data
initial state: #.##.###.#.##...##..#..##....#.#.#.#.##....##..#..####..###.####.##.#..#...#..######.#.....#..##...#

.#.#. => .
...#. => #
..##. => .
....# => .
##.#. => #
.##.# => #
.#### => #
#.#.# => #
#..#. => #
##..# => .
##### => .
...## => .
.#... => .
###.. => #
#..## => .
#...# => .
.#..# => #
.#.## => .
#.#.. => #
..... => .
####. => .
##.## => #
..### => #
#.... => .
###.# => .
.##.. => #
#.### => #
..#.# => .
.###. => #
##... => #
#.##. => #
..#.. => #



