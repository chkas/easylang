# AoC-21 - Day 11: Dumbo Octopus
#
# First increase all fields by 1. Then let
# the flash spread til there is no
# more flash
#
# WARNING: Flashing
#
visual = 1
#
global m[][] .
#
gbackground 000
if visual = 1
   gtext 8 70 "WARNING: Flashing"
   sleep 3
.
gcolor 321
proc draw .
   if visual = 0 : return
   gclear
   for y to 10 : for x to 10
      sz = m[y][x]
      if sz = 11 : sz = 15
      gcircle 10 * x - 5 10 * y - 5 sz / 2
   .
   sleep 0.2
.
for i to 10
   m[][] &= number strchars input
.
repeat
   for y to 10 : for x to 10
      m[y][x] += 1
   .
   repeat
      flash = 0
      for y to 10 : for x to 10
         #
         if m[y][x] = 10
            flash = 1
            m[y][x] = 11
            for nx = higher (x - 1) 1 to lower (x + 1) 10
               for ny = higher (y - 1) 1 to lower (y + 1) 10
                  #
                  if m[ny][nx] < 10 : m[ny][nx] += 1
               .
            .
         .
      .
      until flash = 0
   .
   draw
   h = n_flash
   for y to 10 : for x to 10
      #
      if m[y][x] = 11
         n_flash += 1
         m[y][x] = 0
      .
   .
   count += 1
   if count = 100 : print n_flash
   until n_flash - h = 100
.
print count
#
input_data
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
