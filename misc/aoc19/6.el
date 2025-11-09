# AoC-19 - Day 6: Universal Orbit Map
#
repeat
   s$ = input
   until s$ = ""
   h$[] = strsplit s$ ")"
   a$[] &= h$[1]
   b$[] &= h$[2]
.
orbsum = 0
proc go a$ orb .
   orbsum += orb
   for i = 1 to len a$[]
      if a$[i] = a$
         go b$[i] orb + 1
      .
   .
.
go "COM" 0
print orbsum
#
proc find a$ orb &you &san .
   if a$ = "YOU"
      you = orb
      san = -1
   elif a$ = "SAN"
      san = orb
      you = -1
   else
      you = -1
      san = -1
      for i = 1 to len a$[]
         if a$[i] = a$
            find b$[i] orb + 1 h1 h2
            if h1 <> -1
               you = h1
            elif h2 <> -1
               san = h2
            .
         .
      .
      if you <> -1 and san <> -1
         print you + san - 2 * orb - 2
      .
   .
.
find "COM" 0 you san
#
input_data
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN


