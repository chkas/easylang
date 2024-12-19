# AoC-15 - Day 6: Probably a Fire Hazard
#
repeat
   s$ = input
   until s$ = ""
   inp$[] &= s$
.
for part to 2
   m[] = [ ]
   len m[] 1000 * 1000
   arrbase m[] 0
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
   sum = 0
   for v in m[]
      sum += v
   .
   print sum
.
#
input_data
turn on 0,0 through 999,999
toggle 0,0 through 999,0
turn off 499,499 through 500,500




