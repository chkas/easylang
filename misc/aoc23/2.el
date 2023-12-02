# AoC-23 - Day 2: Cube Conundrum
# 
repeat
   s$ = input
   until s$ = ""
   id += 1
   a$[] = strsplit s$ ":"
   add = id
   mr = 0 ; mg = 0 ; mb = 0
   for a$ in strsplit a$[2] ";"
      nr = 0 ; ng = 0 ; nb = 0
      for s$ in strsplit a$ ","
         h = number s$
         c$ = substr s$ len s$ 1
         if c$ = "d"
            nr += h
            mr = higher mr h
         elif c$ = "n"
            ng += h
            mg = higher mg h
         else
            nb += h
            mb = higher mb h
         .
      .
      if nr > 12 or ng > 13 or nb > 14
         add = 0
      .
   .
   sum1 += add
   sum2 += mr * mg * mb
.
print sum1
print sum2
# 
input_data
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green