# AoC-18 - Day 6: Chronal Coordinates
# 
repeat
   s$ = input
   until s$ = ""
   a$[] = strsplit s$ ","
   x = number a$[1]
   y = number a$[2]
   maxx = higher maxx x
   maxy = higher maxy y
   x[] &= x
   y[] &= y
   n[] &= 0
.
func part1 . .
   for y = 0 to maxy + 1
      for x = 0 to maxx + 1
         mind = 1 / 0
         for i to len x[]
            h = abs (x[i] - x) + abs (y[i] - y)
            if h <= mind
               mini = i
               if h = mind
                  mini = 0
               .
               mind = h
            .
         .
         if mini <> 0
            if n[mini] >= 0
               n[mini] += 1
            .
            if x = 0 or x = maxx + 1 or y = 0 or y = maxy + 1
               n[mini] = -1
            .
         .
      .
   .
   for n in n[]
      mx = higher n mx
   .
   print mx
.
call part1
# 
func part2 . .
   thre = 32
   if maxx > 100
      thre = 10000
   .
   for y to maxy
      for x to maxx
         md = 0
         for i to len x[]
            md += abs (x[i] - x) + abs (y[i] - y)
         .
         if md < thre
            save += 1
         .
      .
   .
   print save
.
call part2
# 
input_data
1, 1
1, 6
8, 3
3, 4
5, 5
8, 9

