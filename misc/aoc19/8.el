# AoC-19 - Day 8: Space Image Format
# 
sysconf topleft
img[] = number strchars input
arrbase img[] 0
w = 25
h = 6
if len img[] < 40
   w = 2
   h = 2
.
# 
sz = w * h
n_layer = len img[] / sz
# 
proc part1 . .
   min = 1 / 0
   for l range0 n_layer
      cnt = 0
      for i range0 sz
         ind = sz * l + i
         if img[ind] = 0
            cnt += 1
         .
      .
      if cnt < min
         min = cnt
         min_l = l
      .
   .
   for i range0 sz
      ind = sz * min_l + i
      if img[ind] = 1
         cnt1 += 1
      elif img[ind] = 2
         cnt2 += 1
      .
   .
   print cnt1 * cnt2
.
part1
# 
proc part2 . .
   len img2[] sz
   arrbase img2[] 0
   for i range0 sz
      for l = n_layer - 1 downto 0
         ind = sz * l + i
         if img[ind] < 2
            img2[i] = img[ind]
         .
      .
   .
   background 000
   color 777
   clear
   for i range0 sz
      if img2[i] = 1
         x = i mod w * 3 + 10
         y = i div w * 3 + 10
         move x + 1.5 y + 1.5
         circle 1.8
      .
   .
.
part2
# 
input_data
0222112222120000




