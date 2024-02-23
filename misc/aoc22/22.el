# AoC-22 - Day 22: Monkey Map
#
nc = 160
len m[] nc * 210
#
proc read . .
   r = 1
   repeat
      s$ = input
      until s$ = ""
      i = r * nc + 1
      for c$ in strchars s$
         if c$ <> " "
            if c$ = "."
               m[i] = 1
            else
               m[i] = 2
            .
         .
         i += 1
      .
      r += 1
   .
.
read
#
inc[] = [ 1 nc -1 (-nc) ]
global sz .
#
proc turn d . ni .
   for i to 4
      if inc[i] = ni
         ni = inc[(i + d) mod1 4]
         break 2
      .
   .
.
global cur[] prev[] plane dif .
proc takedir . nxt ni .
   if m[nxt + ni] = 0
      # left
      turn -1 ni
      nxt -= ni
      swap cur[] prev[]
      cur[] = prev[]
      i = 1
      while i = plane or i = dif
         i += 1
      .
      dif = i
      cur[dif] = 1 - cur[dif]
   else
      nxt += ni
      turn 1 ni
      if m[nxt + ni] <> 0
         # right
         swap cur[] prev[]
         i = 1
         while i = plane or i = dif
            i += 1
         .
         plane = i
      else
         # straight
         turn -1 ni
         nxt -= ni
         swap cur[] prev[]
         cur[] = prev[]
         swap plane dif
         cur[dif] = 1 - cur[dif]
      .
   .
.
proc findedge . nxt ni .
   turn -1 ni
   h = nxt - nc
   if abs ni > 1
      h = h div nc
   else
      h = h mod nc - 1
   .
   off = h mod sz
   if ni > 0
      off = sz - 1 - off
   .
   plane = 3
   dif = 1
   prev[] = [ 0 0 0 ]
   cur[] = [ 1 0 0 ]
   nxt += ni * off
   nxt0 = nxt
   while 1 = 1
      takedir nxt ni
      if cur[] = [ 1 0 0 ] and prev[] = [ 0 0 0 ]
         offs = sz - 1 - offs
         break 1
      .
      if cur[] = [ 0 0 0 ] and prev[] = [ 1 0 0 ]
         break 1
      .
      nxt += ni * sz
      if nxt0 = nxt
         print "error not found"
      .
   .
   nxt += ni * (off + 1)
   turn -1 ni
.
proc step part . ind inc .
   nxt = ind + inc
   ni = inc
   #
   if m[nxt] = 0
      if part = 2
         nxt -= inc
         findedge nxt ni
      else
         while m[nxt - inc] > 0
            nxt -= inc
         .
      .
   .
   if m[nxt] = 1
      ind = nxt
      inc = ni
   .
.
proc go part inp$ . .
   inc = 1
   ind = nc
   while m[ind] <> 1
      ind += 1
   .
   sz = 4
   if ind > nc + 20 or m[ind + 20] <> 0
      sz = 50
   .
   repeat
      n = number substr inp$ 1 2
      if n >= 10
         inp$ = substr inp$ 3 99
      else
         inp$ = substr inp$ 2 99
      .
      while n <> 0
         step part ind inc
         n -= 1
      .
      until len inp$ = 0
      c$ = substr inp$ 1 1
      inp$ = substr inp$ 2 99
      if c$ = "L"
         turn -1 inc
      elif c$ = "R"
         turn 1 inc
      else
         print "error input"
      .
   .
   for h to 4
      if inc[h] = inc
         break 1
      .
   .
   print 1000 * (ind div nc) + 4 * (ind mod nc) + h - 1
.
#
inp$ = input
go 1 inp$
go 2 inp$
#
input_data
        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5



