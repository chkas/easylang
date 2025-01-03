# AoC-21 - Day 23: Amphipod
#
# Dijkstra's algorithm. For each field there
# are 5 possibilities (empty, A-D), so you
# can store each state (7 + 16) fields in a
# number up to 5^23 and then create a "seen"
# hash map.
#
sysconf topleft
visual = 0
#
hashsz = 1999993
len hashind[] hashsz
#
proc hash ind . ret .
   hi = ind mod hashsz + 1
   while hashind[hi] <> 0 and hashind[hi] <> ind
      hi = hi mod hashsz + 1
   .
   ret = 1
   if hashind[hi] = 0
      hashind[hi] = ind
      ret = 0
   .
.
m[] = [ 0 0 -1 0 -1 0 -1 0 -1 0 0 ]
global m0[] destid dim .
#
proc tonum . n .
   n = 0
   for i to len m0[]
      n = n * 5 + m0[i]
   .
   for i to 11
      if m[i] <> -1
         n = n * 5 + m[i]
      .
   .
.
proc toarr n . .
   for i = 11 downto 1
      if m[i] <> -1
         m[i] = n mod 5
         n = n div 5
      .
   .
   for i = len m0[] downto 1
      m0[i] = n mod 5
      n = n div 5
   .
.
#
sz = 8.5
sz2 = sz / 2
background 000
acol[] = [ 373 773 751 733 ]
proc show cost t . .
   if visual = 0 : break 1
   clear
   x = 3
   y = 10 + sz
   move x y
   color 333
   rect 11 * sz sz
   for c = 0 to 3
      move 3 + (2 + c * 2) * sz y + sz
      rect sz dim * sz
   .
   textsize 4
   for i to 11
      if m[i] > 0
         move x + sz2 y + sz2
         color acol[m[i]]
         circle sz2 - 1
         color 000
         move x + 3 y + 2.5
         text strchar (m[i] + 64)
      .
      x += sz
   .
   i = 1
   for r = 0 to dim - 1
      x = 3 + 2 * sz
      y += sz
      for c = 0 to 3
         if m0[i] > 0
            move x + sz2 y + sz2
            color acol[m0[i]]
            circle sz2 - 1
            color 000
            move x + 3 y + 2.5
            text strchar (m0[i] + 64)
         .
         i += 1
         x += 2 * sz
      .
   .
   textsize 6
   color 555
   move 5 70
   text "Energy: " & cost
   sleep t
.
#
proc read . .
   s$ = input
   s$ = input
   ind = 1
   for l to 2
      s$ = input
      for i in [ 4 6 8 10 ]
         a = (strcode substr s$ i 1) - 64
         m0[ind] = a
         ind += 1
      .
   .
.
global m0saved[] .
proc init . .
   dim = 2
   m0[] = [ 1 2 3 4 1 2 3 4 ]
   tonum destid
   read
   m0saved[] = m0[]
.
#
proc prepare_part2 . .
   dim = 4
   m0[] = [ ]
   for i = 0 to 15
      m0[] &= (i mod 4) + 1
   .
   tonum destid
   for i to 4
      m0[i] = m0saved[i]
      m0[12 + i] = m0saved[4 + i]
   .
   h[] = [ 4 3 2 1 4 2 1 3 ]
   for i to 8
      m0[4 + i] = h[i]
   .
   m[] = [ 0 0 -1 0 -1 0 -1 0 -1 0 0 ]
.
#
amp[] = [ 1 10 100 1000 ]
proc init_cost . cost .
   cost = 0
   for i to 4
      for j to dim
         m = m0[i + j * 4 - 4]
         cost += amp[m] * j
         cost += amp[i] * j
      .
      j = dim
      repeat
         m = m0[i + j * 4 - 4]
         until m <> i
         cost -= amp[m] * j
         cost -= amp[i] * j
         j -= 1
      .
   .
.
global todo[] cost[] prev[] .
#
proc show_way . .
   list[] &= destid
   cur = destid
   repeat
      for i = 1 step 2 to len prev[] - 1
         if cur = prev[i]
            cur = prev[i + 1]
            break 1
         .
      .
      until cur = 1
      list[] &= cur
   .
   mp[] = m[]
   m0p[] = m0[]
   toarr list[len list[]]
   if visual = 1
      clear
      sleep 0.1
   .
   show cost 1
   for i = len list[] - 1 downto 1
      swap m[] mp[]
      swap m0[] m0p[]
      toarr list[i]
      for j to len m0[]
         if m0[j] <> m0p[j]
            c = (j - 1) mod 4 * 2 + 3
            st = (j - 1) div 4 + 1
            break 1
         .
      .
      for j to len m[]
         if m[j] <> mp[j]
            st += abs (c - j)
            w = m[j] + mp[j]
            cost += st * amp[w]
            break 1
         .
      .
      show cost 1
   .
.
#
proc take_min . cur cost .
   n = len todo[]
   if n = 0
      cur = -1
      break 1
   .
   for i to n - 1
      if cost[i] < cost[n]
         swap cost[i] cost[n]
         swap todo[i] todo[n]
      .
   .
   cur = todo[n]
   cost = cost[n]
   len todo[] -1
   len cost[] -1
.
proc go_home . cur .
   toarr cur
   while done = 0
      done = 1
      for i to 11 : if m[i] > 0
         dpos = m[i]
         j = (dpos - 1) * 2 + 3
         dir = sign (i - j)
         while 1 = 1
            if j = i
               h = (dim - 1) * 4
               while m0[dpos + h] = dpos
                  h -= 4
               .
               if m0[dpos + h] = 0
                  done = 0
                  m0[dpos + h] = m[i]
                  m[i] = 0
                  cur0 = cur
                  tonum cur
                  prev[] &= cur
                  prev[] &= cur0
                  break 2
               else
                  break 1
               .
            .
            if m[j] > 0 : break 1
            j += dir
         .
      .
   .
.
proc add_ways cur cost . .
   for box to 4
      m0i = -1
      i = 0
      while i < dim * 4 and m0[box + i] = 0
         i += 4
      .
      if i < dim * 4
         m0i = box + i
         if m0[box + i] = box
            i += 4
            while i < dim * 4 and m0[box + i] = box + 1
               i += 4
            .
            if i = dim * 4
               m0i = -1
            .
         .
      .
      if m0i >= 1
         m = m0[m0i]
         m0[m0i] = 0
         pos = 2 * box + 1
         for endpos in [ 1 11 ]
            dir = sign (endpos - 5)
            for i = pos step dir to endpos
               if m[i] > 0 : break 1
               if m[i] = 0
                  m[i] = m
                  tonum new
                  m[i] = 0
                  hash new r
                  if r = 0
                     prev[] &= new
                     prev[] &= cur
                     todo[] &= new
                     h = cost + abs (i - pos) * amp[m] + abs (i - 2 * m - 1) * amp[m]
                     cost[] &= h
                  .
               .
            .
         .
         m0[m0i] = m
      .
   .
.
proc run . .
   init_cost cost
   tonum h
   todo[] = [ h ]
   cost[] = [ cost ]
   prev[] &= h
   prev[] &= 1
   repeat
      take_min cur cost
      if cur = -1
         print "not solved"
         break 2
      .
      go_home cur
      if cnt mod 100 = 0 : show cost 0.01
      cnt += 1
      until cur = destid
      add_ways cur cost
   .
   show cost 2
   print cost
.
init
run
show_way
#
prepare_part2
run
show_way
#
input_data
#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########

