# AoC-18 - Day 13: Mine Cart Madness
# 
visual = 1
# 
sys topleft 
global nc f[] car_dir[] car_pos[] .
arrbase f[] 0
# 
func init . .
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
call init
# 
first_show = 1
global tick crash_pos[] crash_tick[] .
# 
func show crash_pos . .
   if visual = 0
      break 1
   .
   w = 98 / nc
   if first_show = 1
      first_show = 0
      background 000
      color 777
      w3 = w / 3
      color 333
      linewidth w3
      clear
      for i range0 len f[]
         x = i mod nc
         y = i div nc
         if f[i] = 1
            move x * w + 1 y * w + w3 + 1
            rect w w3
         elif f[i] = 2
            move x * w + w3 + 1 y * w + 1
            rect w3 w
         elif f[i] >= 3 and f[i] <= 5
            move x * w + 1 y * w + w3 + 1
            rect w w3
            move x * w + w3 + 1 y * w + 1
            rect w3 w
         .
      .
      background -1
   .
   if crash_pos = -2
      len crash_pos[] 0
      sleep 0.2
   .
   clear
   color 090
   for pos in car_pos[]
      if pos <> -1
         x = pos mod nc
         y = pos div nc
         move x * w + w / 2 + 1 y * w + w / 2 + 1
         circle w
      .
   .
   if crash_pos >= 0
      crash_pos[] &= crash_pos
      crash_tick[] &= tick
   .
   n = len crash_pos[]
   if n > 0
      color 900
      i = 1
      while i <= n
         pos = crash_pos[i]
         x = pos mod nc
         y = pos div nc
         move x * w + w / 2 + 1 y * w + w / 2 + 1
         circle w * 3
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
   if len f[] < 1000
      sleep 0.3
   .
.
dir[] = [ 1 nc -1 (-nc) ]
len car_turn[] len car_dir[]
# 
func run . .
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
            if f[pos] = 3
               car_dir[id] = 5 - car_dir[id]
            elif f[pos] = 4
               car_dir[id] = (2 - car_dir[id]) mod 4 + 1
            elif f[pos] = 5
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
                  call show posn
                  car_pos[id] = -1
                  car_pos[j] = -1
                  ncars -= 2
                  break 1
               .
            .
         .
      .
      call show -1
      until ncars <= 1
   .
   call show -2
   for id = 1 to len car_pos[]
      if car_pos[id] <> -1
         print car_pos[id] mod nc & "," & car_pos[id] div nc
      .
   .
.
call run
# 
input_data
/->-\        
|   |  /----\
| /-+--+-\  |
| | |  | v  |
| | |  | |  |
| | |  | |  |
| | |  | |  |
| | |  | |  |
\-+-/  \-+--/
  \------/   


