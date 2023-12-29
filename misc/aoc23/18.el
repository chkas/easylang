# AoC-23 - Day 18: Lavaduct Lagoon
# 
global d[] n[] inp2$[] .
proc read . .
   repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ " "
      if s$[1] = "R"
         d[] &= 1
      elif s$[1] = "D"
         d[] &= 2
      elif s$[1] = "L"
         d[] &= 3
      else
         d[] &= 4
      .
      n[] &= number s$[2]
      inp2$[] &= s$[3]
   .
.
read
# 
proc read2 . .
   d[] = [ ]
   n[] = [ ]
   for s$ in inp2$[]
      s$[] = strchars s$
      d[] &= number s$[8] + 1
      n = 0
      for i = 3 to 7
         n *= 16
         c = strcode s$[i] - 48
         if c > 10
            c -= 39
         .
         n += c
      .
      n[] &= n
   .
.
proc sort . d1[] d2[] d3[] .
   for i = 1 to len d1[] - 1
      for j = i + 1 to len d1[]
         if d1[j] < d1[i]
            swap d1[j] d1[i]
            swap d2[j] d2[i]
            swap d3[j] d3[i]
         .
      .
   .
.
proc run . .
   for i to len d[]
      d = d[i]
      sum += n[i]
      if d mod 2 = 1
         dx = d
         x += (2 - d) * n[i]
      else
         # vertical
         yp = y
         y += (3 - d) * n[i]
         if d = 4
            # up
            if dx = 3
               yp -= 1
            .
            ux[] &= x
            uy1[] &= y
            uy2[] &= yp
            if i < len d[]
               if d[i + 1] = 1
                  uy1[len uy1[]] += 1
               .
            else
               # last line
               uy1[len uy1[]] += 1
            .
         else
            dx[] &= x
            dy1[] &= yp
            dy2[] &= y
         .
      .
   .
   sort dx[] dy1[] dy2[]
   while len ux[] > 0
      ln = len ux[]
      x = ux[ln]
      y1 = uy1[ln]
      y2 = uy2[ln]
      len ux[] -1
      len uy1[] -1
      len uy2[] -1
      for j to len dx[]
         if dx[j] > x
            dy1 = dy1[j]
            dy2 = dy2[j]
            if dy2 >= y1 and dy1 <= y2
               iy1 = higher y1 dy1
               iy2 = lower y2 dy2
               h = (dx[j] - x - 1) * (iy2 - iy1 + 1)
               sum += h
               # 
               if y1 < dy1
                  ux[] &= x
                  uy1[] &= y1
                  uy2[] &= dy1 - 1
               .
               if y2 > dy2
                  ux[] &= x
                  uy1[] &= dy2 + 1
                  uy2[] &= y2
               .
               break 1
            .
         .
      .
   .
   print sum
.
read
run
read2
run
# 
input_data
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)

