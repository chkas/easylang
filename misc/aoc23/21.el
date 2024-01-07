# AoC-23 - Day 21: Step Counter
# 
global m0[] nc start0 .
proc read . .
   s$ = input
   nc = len s$ + 1
   for i = 1 to nc
      m0[] &= -2
   .
   repeat
      s$[] = strchars s$
      for c$ in s$[]
         if c$ = "#"
            m0[] &= -2
         else
            m0[] &= -1
            if c$ = "S"
               start0 = len m0[]
            .
         .
      .
      m0[] &= -2
      s$ = input
      until s$ = ""
   .
   for i = 1 to nc
      m0[] &= -2
   .
.
read
# 
proc run p nsteps . sum .
   dir[] = [ 1 nc -1 (-nc) ]
   m[] = m0[]
   m[p] = 0
   p[] = [ p ]
   for step = 1 to nsteps
      pn[] = [ ]
      for p in p[]
         for i to 4
            pn = p + dir[i]
            if m[pn] = -1
               pn[] &= pn
               m[pn] = step mod 2
            .
         .
      .
      swap pn[] p[]
   .
   sum = 0
   for i to len m[]
      if m[i] >= 0 and m[i] mod 2 = nsteps mod 2
         sum += 1
      .
   .
.
# 
proc part1 . .
   run start0 64 h
   print h
.
part1
# 
proc calc nsteps . .
   nst = nc - 1
   nc2 = nc / 2
   qu[] = [ nc + 1 2 * nc - 1 nc * (nc + 1) - nc - 1 nc * (nc + 1) - 2 * nc + 1 ]
   qu2[] = [ nc + nc2 nc * nc2 + 1 nc * nc2 + nc - 1 nc * nc - nc2 ]
   # 
   run start0 2 * nst + 1 plots1
   run start0 2 * nst + 2 plots0
   # 
   # ----- diagonal
   # 
   plots = plots1
   n = nsteps - (nst + 1)
   nm = n div nst
   rem = n mod nst
   if nm > 1
      nm2 = nm div 2
      h = nm2 * nm2 * plots1 * 4
      plots += h
      # 
      nm4 = (nm - 1) div 4
      # 
      plots += (nm4 * 4 + 2) * nm4 * plots0 * 4
      if (nm - 1) mod 4 >= 2
         plots += (nm4 * 4 + 2) * plots0 * 4
      .
   .
   # 
   # remainder 
   if nm >= 1
      for i to 4
         run qu[i] nst + rem h
         plots += nm * h
         run qu[i] rem h
         plots += (nm + 1) * h
      .
   .
   # straight
   # 
   n = nsteps - (nst div 2 + 1)
   nm = n div nst
   if nm > 1
      rem = n mod nst
      plots += nm div 2 * plots0 * 4
      plots += (nm - 1) div 2 * plots1 * 4
   .
   # 
   # straight remainder 
   # 
   for i to 4
      if nm > 0
         run qu2[i] nst + rem h
         plots += h
      .
      run qu2[i] rem h
      plots += h
   .
   print plots
.
calc 26501365
# 
input_data
...........
......##.#.
.###..#..#.
..#.#...#..
....#.#....
.....S.....
.##......#.
.......##..
.##.#.####.
.##...#.##.
...........
