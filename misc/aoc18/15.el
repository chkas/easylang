# AoC-18 - Day 15: Beverage Bandits
# 
visual = 1
delay = 0.3
# 
global f0[] nc un0[] hp0[] .
func read . .
  repeat
    s$ = input
    until s$ = ""
    nc = len s$
    for i range nc
      h$ = substr s$ i 1
      if h$ = "."
        f0[] &= -1
      elif h$ = "#"
        f0[] &= -2
      elif h$ = "E"
        f0[] &= len un0[]
        un0[] &= 0
        hp0[] &= 200
      elif h$ = "G"
        f0[] &= len un0[]
        un0[] &= 1
        hp0[] &= 200
      .
    .
  .
.
call read
# 
att_p[] = [ 3 3 ]
dir[] = [ -nc (-1) 1 nc ]
global f[] un[] hp[] .
background 343
func show . .
  if visual = 0
    break 1
  .
  clear
  sz = 100 / nc
  textsize sz / 2
  for y range len f[] / nc
    for x range nc
      h = f[nc * y + x]
      if h = -2
        color 000
        move x * sz y * sz
        rect sz * 1.03125 sz * 1.03125
      elif h >= 0
        color 944
        if un[h] = 0
          color 559
        .
        move x * sz + sz / 2 y * sz + sz / 2
        circle sz / 2
        color 000
        move x * sz + sz / 16 y * sz + sz / 4
        text hp[h]
      .
    .
  .
  sleep delay
.
# 
func battle . res .
  f[] = f0[]
  un[] = un0[]
  hp[] = hp0[]
  # 
  while 1 = 1
    unit_pos[] = [ ]
    unit_id[] = [ ]
    for i range len f[]
      if f[i] >= 0
        unit_pos[] &= i
        unit_id[] &= f[i]
      .
    .
    for un range len unit_pos[]
      unit = unit_id[un]
      pos = unit_pos[un]
      if f[pos] = unit and hp[unit] > 0
        target = 1 - un[unit]
        for j range len f[]
          if f[j] >= 0 and un[f[j]] = target
            break 1
          .
        .
        if j = len f[]
          # no target found -> done
          call show
          hp = 0
          for i range len hp[]
            if hp[i] > 0
              hp += hp[i]
            .
          .
          res = hp * round
          break 2
          # 
        .
        for i range 4
          h = f[pos + dir[i]]
          if h >= 0 and un[h] = target
            break 1
          .
        .
        if i = 4
          ways[] = [ ]
          for i range len f[]
            if f[i] = -3
              f[i] = -1
            .
          .
          for i range 4
            h = pos + dir[i]
            if f[h] = -1
              f[h] = -3
              ways[] &= h
            .
            ways[] &= -1
          .
          while len ways[] > 4
            w[] = [ ]
            ind = 0
            minp = 999999
            for way range 4
              while ways[ind] <> -1
                p = ways[ind]
                for i range 4
                  h = p + dir[i]
                  if f[h] >= 0 and un[f[h]] = target
                    if p < minp
                      minp = p
                      minway = way
                    .
                  elif f[h] = -1
                    w[] &= h
                    f[h] = -3
                  .
                .
                ind += 1
              .
              ind += 1
              w[] &= -1
            .
            if minp < 999999
              f[pos + dir[minway]] = f[pos]
              f[pos] = -1
              pos = pos + dir[minway]
              break 1
            .
            swap ways[] w[]
          .
        .
        min = 201
        for i range 4
          h = f[pos + dir[i]]
          if h >= 0 and un[h] = target
            if hp[h] < min
              min = hp[h]
              mind = i
            .
          .
        .
        if min < 201
          # attac
          h = pos + dir[mind]
          hp[f[h]] -= att_p[un[unit]]
          if hp[f[h]] <= 0
            f[h] = -1
            if target = 0
              # elve died
              if att_p[0] > 3
                res = -1
                call show
                break 3
              .
            .
          .
        .
      .
    .
    round += 1
    call show
  .
.
call battle res
print res
delay /= 10
repeat
  att_p[0] += 1
  call battle res
  until res <> -1
  if visual = 1
    sleep delay * 10
  .
.
print res
# 
# 
input_data
################################
###.GG#########.....#.....######
#......##..####.....G.G....#####
#..#.###...######..........#####
####...GG..######..G.......#####
####G.#...########....G..E.#####
###.....##########.........#####
#####..###########..G......#####
######..##########.........#####
#######.###########........###.#
######..########G.#G.....E.....#
######............G..........###
#####..G.....G#####...........##
#####.......G#######.E......#..#
#####.......#########......E.###
######......#########........###
####........#########.......#..#
#####.......#########.........##
#.#.E.......#########....#.#####
#............#######.....#######
#.....G.G.....#####.....########
#.....G.................########
#...G.###.....#.....############
#.....####E.##E....##.##########
##############.........#########
#############....#.##..#########
#############.#######...########
############.E######...#########
############..####....##########
############.####...E###########
############..####.E.###########
################################





