# AoC-23 - Day 3: Gear Ratios
# 
func val c$ .
   c = strcode c$
   if c >= 48 and c <= 57
      return c - 48
   .
   if c$ = "."
      return -1
   .
   return -2
.
global m$[][] ln .
proc init . .
   s$ = input
   ln = len s$ + 2
   for i to ln
      m$[] &= "."
   .
   m$[][] &= m$[]
   while s$ <> ""
      m$[] = [ "." ]
      for c$ in strchars s$
         m$[] &= c$
      .
      m$[] &= "."
      m$[][] &= m$[]
      s$ = input
   .
   m$[][] &= m$[1][]
.
init
# 
func symupdown r0 c .
   for r = r0 - 1 to r0 + 1
      if val m$[r][c] = -2
         return 1
      .
   .
.
proc part1 . .
   for r = 2 to len m$[][] - 1
      c = 2
      while c <= ln - 1
         c$ = m$[r][c]
         if val c$ >= 0
            ok = 0
            v = 0
            if symupdown r (c - 1) = 1
               ok = 1
            .
            while val c$ >= 0
               v = v * 10 + val c$
               if symupdown r c = 1
                  ok = 1
               .
               c += 1
               c$ = m$[r][c]
            .
            if symupdown r c = 1
               ok = 1
            .
            if ok = 1
               sum += v
            .
         .
         c += 1
      .
   .
   print sum
.
call part1
# 
func num r c .
   if val m$[r][c] < 0
      return -1
   .
   repeat
      c -= 1
      until val m$[r][c] < 0
   .
   c += 1
   while val m$[r][c] >= 0
      res = res * 10 + val m$[r][c]
      c += 1
   .
   return res
.
# 
proc part2 . .
   for r0 = 2 to len m$[][] - 1
      for c0 = 2 to ln - 1
         if m$[r0][c0] = "*"
            r[] = [ 0 0 -1 1 ]
            c[] = [ -1 1 0 0 ]
            if val m$[r0 - 1][c0] < 0
               r[] &= -1 ; c[] &= -1
               r[] &= -1 ; c[] &= 1
            .
            if val m$[r0 + 1][c0] < 0
               r[] &= 1 ; c[] &= -1
               r[] &= 1 ; c[] &= 1
            .
            h0 = 0
            for i to len c[]
               h = num (r0 + r[i]) (c0 + c[i])
               if h >= 0
                  if h0 > 0
                     sum += h0 * h
                     break 1
                  .
                  h0 = h
               .
            .
         .
      .
   .
   print sum
.
call part2
# 
input_data
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..


