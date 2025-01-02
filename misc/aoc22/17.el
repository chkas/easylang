# AoC-22 - Day 17: Pyroclastic Flow
#
hashsz = 199999
len hashind0[] hashsz
global hashind[] .
#
func hashset ind .
   hi = ind mod hashsz + 1
   while hashind[hi] <> ind and hashind[hi] <> 0
      hi = hi mod hashsz + 1
   .
   if hashind[hi] = ind : return 1
   hashind[hi] = ind
   return 0
.
proc hashclear . .
   hashind[] = hashind0[]
.
hashclear
#
len m[] 10000 * 9
#
global rock[][] inp$ .
proc init . .
   for i = 0 to len m[] div 9 - 1
      h = i * 9 + 1
      m[h] = 1
      m[h + 8] = 1
   .
   for i = 2 to 8
      m[i] = 1
   .
   rock[][] &= [ 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 ]
   rock[][] &= [ 0 1 0 0 1 1 1 0 0 1 0 0 0 0 0 0 ]
   rock[][] &= [ 1 1 1 0 0 0 1 0 0 0 1 0 0 0 0 0 ]
   rock[][] &= [ 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ]
   rock[][] &= [ 1 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 ]
   inp$ = input
.
init
#
global high rock[] irock .
#
proc show . .
   rrock = irock div 9
   crock = irock mod 9
   for row = high + 7 downto 0
      for col to 9
         im = row * 9 + col
         if m[im] = 1
            write "#"
         elif m[im] = 2
            write "X"
         else
            c$ = "."
            if row >= rrock and row <= rrock + 3
               if col >= crock and col <= crock + 3
                  x = col - crock
                  y = row - rrock
                  h = y * 4 + x + 1
                  if rock[h] = 1
                     c$ = "@"
                  .
               .
            .
            write c$
         .
      .
      print ""
   .
   print ""
.
#
proc mov dir . block .
   for r = 0 to 3
      for c = 0 to 3
         ind = irock + r * 9 + c
         if rock[r * 4 + c + 1] = 1 and m[ind + dir] = 1
            block = 1
            break 3
         .
      .
   .
   block = 0
   irock += dir
.
high = 0
proc mkstone . .
   for r = 0 to 3
      for c = 0 to 3
         ind = irock + r * 9 + c
         if rock[r * 4 + c + 1] = 1
            m[ind] = 1
            h = ind div 9
            high = higher high h
         .
      .
   .
.
rock = 1
inp = 1
func testhash .
   if high >= 3
      h = inp
      h *= 5
      h += rock - 1
      mi = (high - 3) * 9 + 2
      for i to 4
         for j to 7
            h *= 2
            h += m[mi]
            mi += 1
         .
         mi += 2
      .
      fnd = hashset h
      if fnd = 1 : return h
   .
   return 0
.
#
while 1 = 1
   irock = (high + 4) * 9 + 4
   swap rock[] rock[rock][]
   # show
   repeat
      if substr inp$ inp 1 = "<"
         mov -1 block
      else
         mov 1 block
      .
      inp = inp mod len inp$ + 1
      # show
      mov -9 block
      until block = 1
      # show
   .
   mkstone
   #
   if nrock > 2022
      ind = testhash
      if ind > 0
         if cyc0 = 0
            cyc0 = nrock
            hash0 = ind
            hashclear
         elif hash0 = ind
            rem = 1000000000000 - cyc0
            cyclen = nrock - cyc0
            dhigh = high - high[1]
            mcyc = rem mod cyclen
            ncyc = rem div cyclen
            print dhigh * ncyc + high[mcyc]
            break 1
         .
      .
      if cyc0 > 0
         high[] &= high
      .
   .
   nrock += 1
   if nrock = 2022
      print high
   .
   swap rock[] rock[rock][]
   rock = rock mod len rock[][] + 1
.
#
input_data
>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>