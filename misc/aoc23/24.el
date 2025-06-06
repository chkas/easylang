# AoC-23 - Day 24: Never Tell Me The Odds
#
global w[][] p1b1 p1b2 sc sc2 eps .
#
proc init .
   repeat
      s$ = input
      until s$ = ""
      w[][] &= number strsplit s$ " "
   .
   if len w[][] <= 6
      p1b1 = 7
      p1b2 = 27
      sc = 1
      sc2 = 1
      eps = 0.01
   else
      p1b1 = 200000000000000
      p1b2 = 400000000000000
      sc = 1 / 10000000000000
      sc2 = 1 / 2
      eps = 100
   .
   for i = 4 to len w[][]
      h = abs (w[1][4] - w[i][4]) + abs (w[1][5] - w[i][5])
      if h > m
         m = h
         swap w[2][] w[i][]
      .
   .
.
init
#
proc coord p1 p2 u1 u2 &a &b &c .
   a = -u2
   b = u1
   c = p1 * a + p2 * b
.
proc intxy a1 b1 c1 a2 b2 c2 &x &y .
   d = (a1 * b2 - a2 * b1)
   x = (c1 * b2 - c2 * b1) / d
   y = (a1 * c2 - a2 * c1) / d
.
proc part1 .
   for i to len w[][]
      for j = i + 1 to len w[][]
         coord w[i][1] w[i][2] w[i][4] w[i][5] a1 b1 c1
         coord w[j][1] w[j][2] w[j][4] w[j][5] a2 b2 c2
         intxy a1 b1 c1 a2 b2 c2 x y
         #
         if x >= p1b1 and x <= p1b2 and y >= p1b1 and y <= p1b2
            ta = (x - w[i][1]) / w[i][4]
            tb = (x - w[j][1]) / w[j][4]
            if ta >= 0 and tb >= 0
               sum += 1
            .
         .
      .
   .
   print sum
.
part1
#
proc show b1 b2 d1 d2 .
   glinewidth 0.4
   m = d1 / d2
   b = (b2 - b1 * m) * sc
   gline 0 b 100 b + 100 * m * sc2
.
#
proc showallxy dx dy .
   gclear
   drawgrid
   for i = 1 to len w[][]
      gcolor i * 300 + i * 2
      d1 = w[i][5] + dy
      d2 = w[i][4] + dx
      show w[i][1] w[i][2] d1 d2
   .
   sleep 0
.
len w[][] 3
showallxy 0 0
sleep 1
#
proc sameinter dx dy &x &y &found .
   found = 0
   coord w[1][1] w[1][2] (w[1][4] + dx) (w[1][5] + dy) a1 b1 c1
   coord w[2][1] w[2][2] (w[2][4] + dx) (w[2][5] + dy) a2 b2 c2
   intxy a1 b1 c1 a2 b2 c2 x y
   if x <> x
      # pr "nan"
      return
   .
   tx = (x - w[1][1]) / (w[1][4] + dx)
   ty = (y - w[1][2]) / (w[1][5] + dy)
   if tx < 0 or ty < 0
      # past
      return
   .
   #
   if x = -1 / 0 or x = 1 / 0
      # pr "infinity"
      return
   .
   for i = i + 1 to len w[][]
      coord w[i][1] w[i][2] (w[i][4] + dx) (w[i][5] + dy) a b c
      h = a * x + b * y
      if abs (h - c) > eps
         return
      .
   .
   found = 1
   return
.
proc sameinterz dx dz x0 &z &found .
   found = 0
   coord w[1][1] w[1][3] (w[1][4] + dx) (w[1][6] + dz) a1 b1 c1
   coord w[2][1] w[2][3] (w[2][4] + dx) (w[2][6] + dz) a2 b2 c2
   intxy a1 b1 c1 a2 b2 c2 x z
   if z <> z
      # nan
      return
   .
   if abs (x - x0) > eps
      return
   .
   tz = (z - w[1][3]) / (w[1][6] + dz)
   if tz < 0
      # past
      return
   .
   for i = 3 to len w[][]
      coord w[i][1] w[i][3] (w[i][4] + dx) (w[i][6] + dz) a b c
      if abs (a * x + b * z - c) > eps
         return
      .
   .
   found = 1
.
#
proc main .
   for dx = -300 to 300
      for dy = -300 to 300
         sameinter dx dy x y found
         if found = 1
            for dz = -300 to 300
               sameinterz dx dz x z found
               if found = 1
                  # print "vel: " & -dx & " " & -dy & " " & -dz
                  break 3
               .
            .
         .
      .
   .
   if found = 1
      showallxy dx dy
      # print x & " " & y & " " & z
      print floor (x + y + z + 0.5)
   .
.
main
#
input_data
19, 13, 30 @ -2,  1, -2
18, 19, 22 @ -1, -1, -2
20, 25, 34 @ -2, -2, -4
12, 31, 28 @ -1, -2, -1
20, 19, 15 @  1, -5, -3