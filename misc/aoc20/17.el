# AoC-20 - Day 17: Conway Cubes
# 
repeat
  s$ = input
  until s$ = ""
  in$[] &= s$
.
ln0 = len in$[]
# n = size + 2 * iterations + border
n = ln0 + 2 * 6 + 2
len f[] n * n * 8 * 8
len p[] len f[]
n2 = n * n
n3 = n * n * 8
# 
func init . .
  y = 7
  for ii range len in$[]
    s$[] = strchars in$[ii]
    x = 7
    for j range len s$[]
      i = x + y * n
      if s$[j] = "#"
        f[i] = 1
      .
      x += 1
    .
    y += 1
  .
.
func update part turn . sum .
  swap f[] p[]
  wx = turn + 1
  if part = 1
    wx = 0
  .
  a = 6 - turn
  b = a + ln0 + 2 + 2 * turn - 1
  for w = 0 to wx
    for z = 0 to turn + 1
      for y = a to b
        for x = a to b
          i = x + y * n + z * n2 + w * n3
          s = 0
          for wp0 = w - 1 to w + 1
            wp = wp0
            if wp0 = -1
              wp = 1
            .
            for zp0 = z - 1 to z + 1
              if zp0 = -1
                zp = 1
              else
                zp = zp0
              .
              ip = x + y * n - n + zp * n2 + wp * n3 - 1
              for _ range 3
                for ip = ip to ip + 2
                  s += p[ip]
                .
                ip += n - 3
              .
            .
          .
          s -= p[i]
          if s = 3
            f[i] = 1
          elif s = 2 and p[i] = 1
            f[i] = 1
          else
            f[i] = 0
          .
        .
      .
    .
  .
.
func run part . .
  call init
  for i range 6
    call update part i sum
  .
  sum = 0
  for w range 7
    for z range 7
      for y range ln0 + 14
        for x range ln0 + 14
          i = x + y * n + z * n2 + w * n3
          if w = 0 and z = 0
            sum += f[i]
          elif z = 0 or w = 0
            sum += f[i] * 2
          else
            sum += f[i] * 4
          .
          f[i] = 0
          p[i] = 0
        .
      .
    .
  .
  print sum
.
call run 1
call run 2
# 
# 
input_data
....#...
.#..###.
.#.#.###
.#....#.
...#.#.#
#.......
##....#.
.##..#.#


