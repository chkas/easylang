# AoC-16 - Day 24: Air Duct Spelunking
#
len pos[] 7
#
repeat
   s$ = input
   until s$ = ""
   nc = len s$
   for i to nc
      c$ = substr s$ i 1
      if c$ = "#"
         h = -1
      elif c$ = "."
         h = 0
      elif c$ = "0"
         pos0 = len m[]
         h = 0
      else
         h = strcode c$ - 48
         pos[h] = len m[]
         max = higher max h
      .
      m[] &= h
   .
.
#
pos = pos0
n = len m[]
found_all = pow 2 max
len seen[] n * found_all
found_all -= 1
#
todo[] = [ pos ]
while len todo[] <> 0
   for cod in todo[]
      pos = cod mod n
      found = cod div n
      #
      if found = found_all and done1 = 0
         done1 = 1
         print steps
      .
      if found = found_all and pos = pos0
         print steps
         break 2
      .
      for posn in [ pos - nc pos + 1 pos + nc pos - 1 ]
         if m[posn + 1] >= 0
            foundn = found
            if m[posn + 1] > 0
               h = m[posn + 1] - 1
               foundn = bitor found bitshift 1 h
            .
            codn = foundn * n + posn
            if seen[codn + 1] = 0
               todon[] &= codn
               seen[codn + 1] = 1
            .
         .
      .
   .
   swap todo[] todon[]
   todon[] = [ ]
   steps += 1
.
#
input_data
###########
#0.1.....2#
#.#######.#
#4.......3#
###########

