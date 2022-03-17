# AoC-18 - Day 11: Chronal Charge
# 
serid = 5535
# serid = 18
len po[] 301 * 301
for x = 1 to 300
  for y = 1 to 300
    ra_id = x + 10
    h = (ra_id * y + serid) * ra_id
    h = h div 100 mod 10 - 5
    po[y * 301 + x] = h
  .
.
func part1 . .
  for x = 1 to 297
    for y = 1 to 297
      s = 0
      for xd = x to x + 2
        for yd = y to y + 2
          s += po[yd * 301 + xd]
        .
      .
      if s > max
        max = s
        mx = x
        my = y
      .
    .
  .
  print mx & "," & my
.
call part1
# 
len pox[] 301 * 301
len poy[] 301 * 301
for x = 1 to 300
  s = 0
  for y = 1 to 300
    s += po[y * 301 + x]
    poy[y * 301 + x] = s
  .
.
for y = 1 to 300
  s = 0
  for x = 1 to 300
    s += po[y * 301 + x]
    pox[y * 301 + x] = s
  .
.
func part2 . .
  for x = 1 to 300
    for y = 1 to 300
      msz = 300 - y
      if x > y
        msz = 300 - x
      .
      s = 0
      for sz = 0 to msz
        ind = x + (y + sz) * 301
        s += pox[ind + sz] - pox[ind - 1]
        ind += sz - 301
        s += poy[ind] - poy[ind - sz * 301]
        if s > max
          max = s
          maxx = x
          maxy = y
          maxsz = sz
        .
      .
    .
  .
  print maxx & "," & maxy & "," & maxsz + 1
.
call part2

