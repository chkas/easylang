# AoC-18 - Day 15: Beverage Bandits
# 
visual = 1
delay = 0.3
# 
sys topleft 
global f0[] nc un0[] hp0[] .
proc read . .
   repeat
      s$ = input
      until s$ = ""
      nc = len s$
      for i = 1 to nc
         h$ = substr s$ i 1
         if h$ = "."
            f = -1
         elif h$ = "#"
            f = -2
         elif h$ = "E"
            un0[] &= 1
            hp0[] &= 200
            f = len un0[]
         elif h$ = "G"
            un0[] &= 2
            hp0[] &= 200
            f = len un0[]
         .
         f0[] &= f
      .
   .
   arrbase f0[] 0
.
call read
# 
att_p[] = [ 3 3 ]
dir[] = [ -nc (-1) 1 nc ]
global f[] un[] hp[] .
background 343
proc show . .
   if visual = 0
      break 1
   .
   clear
   sz = 100 / nc
   textsize sz / 2
   for y range0 len f[] / nc
      for x range0 nc
         h = f[nc * y + x]
         if h = -2
            color 000
            move x * sz y * sz
            rect sz * 1.03125 sz * 1.03125
         elif h >= 1
            color 944
            if un[h] = 1
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
proc battle . res .
   f[] = f0[]
   un[] = un0[]
   hp[] = hp0[]
   # 
   while 1 = 1
      unit_pos[] = [ ]
      unit_id[] = [ ]
      for i range0 len f[]
         if f[i] >= 1
            unit_pos[] &= i
            unit_id[] &= f[i]
         .
      .
      for un to len unit_pos[]
         unit = unit_id[un]
         pos = unit_pos[un]
         if f[pos] = unit and hp[unit] > 0
            target = 3 - un[unit]
            for j range0 len f[]
               if f[j] >= 1 and un[f[j]] = target
                  break 1
               .
            .
            if j = len f[]
               # no target found -> done
               call show
               hp = 0
               for i = 1 to len hp[]
                  if hp[i] > 0
                     hp += hp[i]
                  .
               .
               res = hp * round
               break 2
               # 
            .
            for i to 4
               h = f[pos + dir[i]]
               if h >= 0 and un[h] = target
                  break 1
               .
            .
            if i > 4
               ways[] = [ ]
               for i range0 len f[]
                  if f[i] = -3
                     f[i] = -1
                  .
               .
               for i to 4
                  h = pos + dir[i]
                  if f[h] = -1
                     f[h] = -3
                     ways[] &= h
                  .
                  ways[] &= -1
               .
               while len ways[] > 4
                  w[] = [ ]
                  ind = 1
                  minp = 999999
                  for way to 4
                     while ways[ind] <> -1
                        p = ways[ind]
                        for i = 1 to 4
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
            for i to 4
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
                  if target = 1
                     # elve died
                     if att_p[1] > 3
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
# 
proc part2 . .
   delay /= 10
   repeat
      att_p[1] += 1
      call battle res
      until res <> -1
      if visual = 1
         sleep delay * 10
      .
   .
   print res
.
call part2
# 
# 
input_data
#########
#G......#
#.E.#...#
#..##..G#
#...##..#
#...#...#
#.G...G.#
#.....G.#
#########


