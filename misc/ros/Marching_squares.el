func any arr[] val .
   for v in arr[] : if val = v : return 1
   return 0
.
E = 1
N = 2
W = 3
S = 4
dirs$[] = [ "E" "N" "W" "S" ]
dirx[] = [ 1 0 -1 0 ]
diry[] = [ 0 -1 0 1 ]
#
proc identifyPeri data[][] &x &y &path$ .
   lngx = len data[1][]
   lngy = len data[][]
   for y to lngy : for x to lngx
      if data[y][x] <> 0
         path$ = ""
         cx = x
         cy = y
         repeat
            mask = 0
            for v[] in [ [ 0 0 1 ] [ 1 0 2 ] [ 0 1 4 ] [ 1 1 8 ] ]
               mx = cx + v[1]
               my = cy + v[2]
               if mx > 1 and my > 1 and my - 1 <= lngy and mx - 1 <= lngx and data[my - 1][mx - 1] <> 0
                  mask += v[3]
               .
            .
            if any [ 1 5 13 ] mask = 1 : d = N
            if any [ 2 3 7 ] mask = 1 : d = E
            if any [ 4 12 14 ] mask = 1 : d = W
            if any [ 8 10 11 ] mask = 1 : d = S
            if mask = 6
               d = E
               if pd = N : d = W
            .
            if mask = 9
               d = S
               if pd = E : d = N
            .
            path$ &= dirs$[d]
            cx += dirx[d]
            cy += diry[d]
            pd = d
            until cx = x and cy = y
         .
         y = -y
         return
      .
   .
   print "That did not work out..."
.
m[][] = [ [ 0 0 0 0 0 ] [ 0 0 0 0 0 ] [ 0 0 1 1 0 ] [ 0 0 1 1 0 ] [ 0 0 0 1 0 ] [ 0 0 0 0 0 ] ]
identifyPeri m[][] x y path$
print "x: " & x & " y: " & y & " path: " & path$
