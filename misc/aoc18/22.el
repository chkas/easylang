# AoC-18 - Day 22: Mode Maze
# 
s$[] = strsplit input " "
depth = number s$[1]
s$[] = strsplit input " ,"
targx = number s$[1]
targy = number s$[2]
# 
nx = 100
ny = 1000
len f[] nx * ny
# 
func part1 . .
  len ero[] nx
  ero[0] = depth mod 20183
  f[0] = ero[0] mod 3
  for x = 1 to nx - 1
    ero[x] = (x * 16807 + depth) mod 20183
    f[x] = ero[x] mod 3
  .
  for y = 1 to ny - 1
    ero[0] = (y * 48271 + depth) mod 20183
    f[y * nx] = ero[0] mod 3
    for x = 1 to nx - 1
      ero[x] = (ero[x - 1] * ero[x] + depth) mod 20183
      f[y * nx + x] = ero[x] mod 3
    .
  .
  f[targy * nx + targx] = (depth mod 20183) mod 3
  for y = 0 to targy
    for x = 0 to targx
      risk += f[x + nx * y]
    .
  .
  print risk
.
call part1
# 
nx2 = 2 * nx
len w[] nx2 * ny
for i range len w[]
  w[i] = 99999
.
# 
# 0 rocky   torch gear
# 1 wet      -    gear
# 2 narrow   -    torch
# 
# 0 1  -+   straight
# 0 2  +-   cross
# 1 2  +-   straight
# 
todon[] = [ 0 ]
mintarg = 99999
targpos = targy * nx2 + 2 * targx
func add_todo pos w . .
  if w < w[pos]
    w[pos] = w
    if pos = targpos
      mintarg = w[pos]
    .
    if w[pos] < mintarg
      todon[] &= pos
    .
  .
.
# 
w[0] = 0
while len todon[] > 0
  swap todo[] todon[]
  len todon[] 0
  for i range len todo[]
    pos = todo[i]
    w = w[pos]
    chng = 1 - pos mod 2 * 2
    call add_todo pos + chng w + 7
    # 
    for j range 4
      posx = -1
      if j = 0 and pos mod nx2 > 1
        posx = pos - 2
      elif j = 1 and pos >= nx2
        posx = pos - nx2
      elif j = 2 and pos mod nx < nx - 2
        posx = pos + 2
      elif j = 3 and pos < nx2 * (ny - 1)
        posx = pos + nx2
      .
      if posx <> -1
        h1 = f[pos div 2]
        h2 = f[posx div 2]
        if h1 <> h2
          hs = h1 + h2
          if hs = 1 and chng = 1
            posx = -1
          elif hs = 3 and chng = -1
            posx = -1
          elif hs = 2
            if h1 = 0 and chng = 1
              posx += chng
            elif h1 = 2 and chng = -1
              posx += chng
            else
              posx = -1
            .
          .
        .
        if posx <> -1
          call add_todo posx w + 1
        .
      .
    .
  .
.
print mintarg
# 
# 
input_data
depth: 11820
target: 7,782




