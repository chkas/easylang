# AoC-15 - Day 6: Probably a Fire Hazard
#
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
proc go part .
   len m[] 1000 * 1000
   for s$ in inp$[]
      s$[] = strtok s$ " ,"
      inc = 2
      if s$[2] = "on"
         inc = 1
      elif s$[2] = "off"
         inc = -1
      .
      h = len s$[] - 4
      x1 = number s$[h]
      y1 = number s$[h + 1]
      x2 = number s$[h + 3]
      y2 = number s$[h + 4]
      for x = x1 to x2
         for y = y1 to y2
            p = x + y * 1000
            if part = 1
               if inc = 1
                  m[p] = 1
               elif inc = -1
                  m[p] = 0
               else
                  m[p] = 1 - m[p]
               .
            else
               m[p] = higher 0 (m[p] + inc)
            .
         .
      .
   .
   for i range0 len m[] : sum += m[i]
   print sum
.
go 1
go 2
#
input_data
turn on 0,0 through 999,999
toggle 0,0 through 999,0
turn off 499,499 through 500,500
