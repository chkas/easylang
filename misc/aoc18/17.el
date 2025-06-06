# AoC-18 - Day 17: Reservoir Research
#
sysconf topleft
visual = 1
#
global f[] maxpos minpos .
#
proc read .
   len f[] 300 * 2500
   arrbase f[] 0
   miny = 9999
   maxy = 0
   repeat
      s$ = input
      until s$ = ""
      n[] = number strtok s$ "=."
      a = n[1] ; b = n[2] ; c = n[3]
      if substr s$ 1 1 = "x"
         for y = b to c
            p = y * 300 + a - 300
            f[p] = 1
         .
      else
         for x = b to c
            p = a * 300 + x - 300
            f[p] = 1
         .
         b = a ; c = a
      .
      miny = lower miny b
      maxy = higher maxy b
   .
   minpos = miny * 300
   maxpos = maxy * 300 + 300
.
read
#
gbackground 765
global pos0 skip .
proc show p .
   if visual = 0 : return
   skip = (skip + 1) mod 10
   if skip < 6 : break 1
   p = p div 300 * 300 - 30000
   if p > pos0 + 60000
      pos0 = p
   .
   gclear
   sz = 1 / 3
   for y range0 300
      x = 0
      while x < 300
         h = f[x + 300 * y + pos0]
         x += 1
         if h > 0
            x0 = x - 1
            while f[x + 300 * y + pos0] = h
               x += 1
            .
            if h = 1
               gcolor 000
            elif h = 2
               gcolor 066
            elif h = 3
               gcolor 008
            .
            grect x0 * sz y * sz sz * (x - x0) sz
         .
      .
   .
   sleep 0
.
proc run .
   pos = 500 - 300
   while pos < minpos
      pos += 300
   .
   todo_n[] &= pos
   while len todo_n[] > 0
      len todo[] 0
      swap todo[] todo_n[]
      for i_todo to len todo[]
         pos = todo[i_todo]
         while pos < maxpos and f[pos] = 0
            f[pos] = 3
            pos += 300
         .
         show pos
         if f[pos] <> 3 and pos < maxpos
            repeat
               l = pos - 300
               while f[l] <> 1 and f[l + 300] <> 0
                  f[l] = 3
                  l -= 1
               .
               r = pos - 300
               while f[r] <> 1 and f[r + 300] <> 0
                  f[r] = 3
                  r += 1
               .
               until f[l] <> 1 or f[r] <> 1
               for h = l + 1 to r - 1
                  f[h] = 2
               .
               show pos
               pos -= 300
            .
            if f[l] = 0
               todo_n[] &= l
            .
            if f[r] = 0
               todo_n[] &= r
            .
         .
      .
   .
   show pos
   for i range0 len f[]
      if f[i] > 1
         sum += 1
         if f[i] = 2
            sum2 += 1
         .
      .
   .
   print sum
   print sum2
.
run
#
input_data
x=495, y=2..7
y=7, x=495..501
x=501, y=3..7
x=498, y=2..4
x=506, y=1..2
x=498, y=10..13
x=504, y=10..13
y=13, x=498..504

