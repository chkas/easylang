# AoC-16 - Day 8: Two-Factor Authentication
#
sysconf topleft
visualization = 1
#
nc = 50
nr = 6
len m[] nc * nr
arrbase m[] 0
#
f = 90 / nc
proc show m .
   if visualization = 1
      gclear
      for r range0 nr : for c range0 nc
         if m[c + nc * r] = 1
            gcircle 5 + c * f 5 + r * f f / 2
         .
      .
      sleep 0.02
   elif m = 2
      for r range0 nr
         for c range0 nc
            if m[c + nc * r] = 1
               write "#"
            else
               write "."
            .
         .
         print ""
      .
      print ""
   .
.
#
len r[] nr
len c[] nc
arrbase r[] 0
arrbase c[] 0
#
repeat
   s$ = input
   until s$ = ""
   if substr s$ 1 4 = "rect"
      v[] = number strtok s$ "x "
      for r range0 v[2] : for c range0 v[1]
         m[c + nc * r] = 1
      .
   else
      s$[] = strsplit s$ " "
      a = number substr s$[3] 3 9
      b = number s$[5]
      if s$[2] = "column"
         c = a
         for r range0 nr
            r[r] = m[c + nc * ((r - b) mod nr)]
         .
         for r range0 nr
            m[c + nc * r] = r[r]
         .
      else
         r = a
         for c range0 nc
            c[c] = m[(c - b) mod nc + nc * r]
         .
         for c range0 nc
            m[c + nc * r] = c[c]
         .
      .
   .
   show 1
.
for v in m[] : sum += v
print sum
show 2
#
input_data
rect 3x2
rotate column x=1 by 1
rotate row y=0 by 4
rotate column x=1 by 1
