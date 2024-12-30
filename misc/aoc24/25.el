# AoC-24 - Day 25: Code Chronicle
#
len k[] 5
repeat
   s$ = input
   until s$ = ""
   lock = if s$ = "#####"
   k[] = [ 0 0 0 0 0 ]
   for i to 5
      s$ = input
      a$[] = strchars s$
      for j to 5
         if lock = 1
            if a$[j] = "#" : k[j] = i
         else
            if a$[j] = "#" and k[j] = 0 : k[j] = 6 - i
         .
      .
   .
   if lock = 1
      locks[][] &= k[]
   else
      keys[][] &= k[]
   .
   s$ = input
   s$ = input
.
for l to len locks[][]
   for k to len keys[][]
      for p to 5 : if locks[l][p] + keys[k][p] > 5 : break 1
      if p > 5 : nfit += 1
   .
.
print nfit
#
input_data
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
