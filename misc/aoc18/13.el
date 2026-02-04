# AoC-18 - Day 13: Mine Cart Madness
#
sysconf topleft
visual = 1
#
global nc f[] car_dir[] car_pos[] .
#
proc init .
   repeat
      s$ = input
      until s$ = ""
      nc = len s$
      for a$ in strchars s$
         pos = len f[]
         if a$ = "-"
            f = 1
         elif a$ = "|"
            f = 2
         elif a$ = "<"
            f = 1
            car_dir[] &= 3
            car_pos[] &= pos
         elif a$ = ">"
            f = 1
            car_dir[] &= 1
            car_pos[] &= pos
         elif a$ = "^"
            f = 2
            car_dir[] &= 4
            car_pos[] &= pos
         elif a$ = "v"
            f = 2
            car_dir[] &= 2
            car_pos[] &= pos
         elif a$ = "/"
            f = 3
         elif a$ = "\\"
            f = 4
         elif a$ = "+"
            f = 5
         else
            f = 0
         .
         f[] &= f
      .
   .
.
init
#
first_show = 1
global tick crash_pos[] crash_tick[] .
#
proc show crash_pos .
   if visual = 0 : return
   w = 98 / nc
   if first_show = 1
      first_show = 0
      gbackground 000
      gcolor 777
      w3 = w / 3
      gcolor 333
      glinewidth w3
      gclear
      for i range0 len f[]
         x = i mod nc
         y = i div nc
         h = f[i + 1]
         if h = 1
            grect x * w + 1 y * w + w3 + 1 w w3
         elif h = 2
            grect x * w + w3 + 1 y * w + 1 w3 w
         elif h >= 3 and h <= 5
            grect x * w + 1 y * w + w3 + 1 w w3
            grect x * w + w3 + 1 y * w + 1 w3 w
         .
      .
      gbackground -1
   .
   if crash_pos = -2
      len crash_pos[] 0
      sleep 0.2
   .
   gclear
   gcolor 090
   for pos in car_pos[]
      if pos <> -1
         x = pos mod nc
         y = pos div nc
         gcircle x * w + w / 2 + 1 y * w + w / 2 + 1 w
      .
   .
   if crash_pos >= 0
      crash_pos[] &= crash_pos
      crash_tick[] &= tick
   .
   n = len crash_pos[]
   if n > 0
      gcolor 900
      i = 1
      while i <= n
         pos = crash_pos[i]
         x = pos mod nc
         y = pos div nc
         gcircle x * w + w / 2 + 1 y * w + w / 2 + 1 w * 3
         if crash_tick[i] + 20 = tick
            crash_pos[i] = crash_pos[n]
            crash_tick[i] = crash_tick[n]
            n -= 1
            i -= 1
         .
         i += 1
      .
      len crash_pos[] n
      len crash_tick[] n
   .
   tick += 1
   sleep 0.005
   if len f[] < 1000 : sleep 0.3
.
dir[] = [ 1 nc -1 (-nc) ]
len car_turn[] len car_dir[]
#
proc run .
   ncars = len car_pos[]
   repeat
      # sort car pos
      for i to len car_pos[] - 1
         for j = i + 1 to len car_pos[]
            if car_pos[j] < car_pos[i]
               swap car_pos[j] car_pos[i]
               swap car_dir[j] car_dir[i]
               swap car_turn[j] car_turn[i]
            .
         .
      .
      for id to len car_pos[]
         pos = car_pos[id]
         if pos <> -1
            h = f[pos + 1]
            if h = 3
               car_dir[id] = 5 - car_dir[id]
            elif h = 4
               car_dir[id] = (2 - car_dir[id]) mod 4 + 1
            elif h = 5
               car_dir[id] = (car_dir[id] + car_turn[id] - 2) mod 4 + 1
               car_turn[id] = (car_turn[id] + 1) mod 3
            .
            posn = pos + dir[car_dir[id]]
            car_pos[id] = posn
            for j to len car_pos[]
               if j <> id and posn = car_pos[j]
                  # crash
                  if first_done = 0
                     print posn mod nc & "," & posn div nc
                     first_done = 1
                  .
                  show posn
                  car_pos[id] = -1
                  car_pos[j] = -1
                  ncars -= 2
                  break 1
               .
            .
         .
      .
      show -1
      until ncars <= 1
   .
   show -2
   for id = 1 to len car_pos[]
      if car_pos[id] <> -1
         print car_pos[id] mod nc & "," & car_pos[id] div nc
      .
   .
.
run
#
input_data
/->-\       .
|   |  /----\
| /-+--+-\  |
| | |  | v  |
| | |  | |  |
| | |  | |  |
| | |  | |  |
| | |  | |  |
\-+-/  \-+--/
  \------/  .
