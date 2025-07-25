proc babylon_spiral nsteps &pts[][] .
   pts[][] = [ [ 0 0 ] [ 0 1 ] ]
   norm = 1
   last[] = pts[$][]
   for k to nsteps - 2
      theta = atan2 last[2] last[1]
      cands[][] = [ ]
      while len cands[][] = 0
         norm += 1
         for i = 0 to nsteps
            a = i * i
            if a > norm div 2 : break 1
            for j = floor sqrt norm + 1 downto 0
               b = j * j
               if a + b < norm : break 1
               if a + b = norm
                  cands[][] &= [ i, j ]
                  cands[][] &= [ -i, j ]
                  cands[][] &= [ i, -j ]
                  cands[][] &= [ -i, -j ]
                  cands[][] &= [ j, i ]
                  cands[][] &= [ -j, i ]
                  cands[][] &= [ j, -i ]
                  cands[][] &= [ -j, -i ]
               .
            .
         .
      .
      min = 1 / 0
      for i to len cands[][]
         h = (theta - atan2 cands[i][2] cands[i][1]) mod 360
         if h < min
            min = h
            mini = i
         .
      .
      last[] = cands[mini][]
      pts[][] &= pts[$][]
      pts[$][1] += last[1]
      pts[$][2] += last[2]
   .
.
babylon_spiral 40 pts[][]
print pts[][]
# 
babylon_spiral 10000 pts[][]
for i to len pts[][]
   minx = lower minx pts[i][1]
   maxx = higher maxx pts[i][1]
   miny = lower miny pts[i][2]
   maxy = higher maxy pts[i][2]
.
scx = 100 / (maxx - minx) * 0.96
scy = 100 / (maxy - miny) * 0.96
ty = -miny * scy + 2
tx = -minx * scx + 2
glinewidth 0.1
gline 0 ty 100 ty
gline tx 0 tx 100
gpenup
for i to len pts[][]
   glineto pts[i][1] * scx + tx, pts[i][2] * scy + ty
.
