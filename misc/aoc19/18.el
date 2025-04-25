# AoC-19 - Day 18: Many-Worlds Interpretation
#
sysconf topleft
inp$ = input
a$[] = strchars inp$
sz = len a$[]
fsz = 100 / sz
n_keys = 0
#
proc mark p col . .
   x = p mod sz
   y = p div sz
   color col
   move x * fsz + fsz / 2 y * fsz + fsz / 2
   circle fsz / 2
.
len map[] sz * sz
arrbase map[] 0
len door_pos[] 26
len key_pos[] 26 + 1
robot = 0
#
proc parse . .
   repeat
      a$[] = strchars inp$
      arrbase a$[] 0
      for x range0 len a$[]
         p = y * sz + x
         if a$[x] = "#"
            map[p] = 1
         elif a$[x] = "@"
            robot = p
         elif a$[x] <> "."
            h = strcode a$[x]
            if h >= 97 and h <= 122
               map[p] = h
               h -= 96
               if h > n_keys
                  n_keys = h
               .
               key_pos[h] = p
            elif h >= 65 and h <= 90
               map[p] = h
               h -= 64
               door_pos[h] = p
            .
         .
      .
      y += 1
      inp$ = input
      until inp$ = ""
   .
.
parse
#
proc show . .
   move 0 0
   color 888
   rect 100 100
   color 000
   for y range0 sz
      for x range0 sz
         p = y * sz + x
         if map[p] = 1
            move x * fsz y * fsz
            rect fsz fsz
         .
      .
   .
   sc = 1
   if fsz < 2
      sc = 2.5
   .
   textsize fsz * sc
   for y range0 sz
      for x range0 sz
         p = y * sz + x
         if map[p] > 1
            if map[p] < 97
               color 995
            else
               color 966
            .
            move x * fsz + fsz / 2 y * fsz + fsz / 2
            circle fsz * sc * 0.6
            color 000
            move x * fsz y * fsz - fsz / 2
            text strchar map[p]
         .
      .
   .
   color 070
   x = robot mod sz
   y = robot div sz
   move x * fsz + fsz / 2 y * fsz + fsz / 2
   circle fsz * 0.6 * sc
   sleep 0.01
.
offs[] = [ -sz 1 sz -1 ]
#
global kk_dist[] kk_doors[][] kk_keys[][] .
#
proc add_kk key k dist &coll[] ..
   k -= 96
   key -= 1
   ind = key * n_keys + k
   kk_dist[ind] = dist
   for i = 1 to len coll[]
      if coll[i] >= 97
         kk_keys[ind][] &= coll[i] - 96
      else
         kk_doors[ind][] &= coll[i] - 64
      .
   .
.
proc spread key . .
   len found[] n_keys
   m[] = map[]
   arrbase m[] 0
   posn[] = [ key_pos[key] ]
   colln[][] &= [ ]
   dist = 0
   repeat
      swap pos[] posn[]
      swap coll[][] colln[][]
      posn[] = [ ]
      len colln[][] 0
      for ind = 1 to len pos[]
         pos = pos[ind]
         swap coll[] coll[ind][]
         if m[pos] > 2 and dist > 0
            h = m[pos]
            if h >= 97 and found[h - 96] = 0
               add_kk key h dist coll[]
               found[h - 96] = 1
            .
            coll[] &= m[pos]
         .
         m[pos] = 1
         for dir = 1 to 4
            posn = pos + offs[dir]
            if m[posn] <> 1
               posn[] &= posn
               colln[][] &= coll[]
            .
         .
      .
      until len posn[] = 0
      dist += 1
   .
.
len open[] n_keys + 1
#
proc calc_distances . .
   len kk_dist[] 0
   len kk_doors[][] 0
   len kk_keys[][] 0
   len kk_dist[] n_keys * n_keys + n_keys
   len kk_doors[][] n_keys * n_keys + n_keys
   len kk_keys[][] n_keys * n_keys + n_keys
   key_pos[n_keys + 1] = robot
   for key = 1 to n_keys + 1
      if open[key] = 0
         spread key
      .
   .
.
proc is_path_open key k &open ..
   key -= 1
   ind = key * n_keys + k
   open = 0
   for d = 1 to len kk_keys[ind][]
      if open[kk_keys[ind][d]] = 0 : return
   .
   for d = 1 to len kk_doors[ind][]
      if open[kk_doors[ind][d]] = 0 : return
   .
   open = 1
.
hashsz = 199999
len hashind[] hashsz
len hashv[] hashsz
#
proc hashget ind &val ..
   hi = ind mod hashsz + 1
   repeat
      if hashind[hi] = ind
         val = hashv[hi]
         return
      .
      until hashind[hi] = 0
      hi = hi mod hashsz + 1
   .
   val = -1
.
proc hashset ind val . .
   hi = ind mod hashsz + 1
   while hashind[hi] <> 0
      hi = hi mod hashsz + 1
   .
   hashind[hi] = ind
   hashv[hi] = val
.
#
proc state_id key &id ..
   id = 0
   for k = 1 to n_keys
      id *= 2
      id += if open[k] = 0
   .
   id *= n_keys
   id += key
.
#
proc solve key &dist ..
   for k = 1 to n_keys
      remain += if open[k] = 0
   .
   if remain = 0
      dist = 0
      return
   .
   if key <= n_keys
      state_id key id
      hashget id dist
      if dist >= 0 : return
   .
   min = 1 / 0
   for k = 1 to n_keys
      if open[k] = 0
         is_path_open key k open
         if open = 1
            open[k] = 1
            solve k h
            open[k] = 0
            ind = (key - 1) * n_keys + k
            h += kk_dist[ind]
            min = lower h min
         .
      .
   .
   if key <= n_keys
      state_id key id
      hashset id min
   .
   dist = min
.
show
calc_distances
solve n_keys + 1 dist0
print dist0
#
proc part2 . .
   for i = 1 to 4
      map[robot + offs[i]] = 1
   .
   map[robot] = 1
   rob0 = robot
   qx[] = [ -1 1 1 -1 ]
   qy[] = [ -1 -1 1 1 ]
   for q = 1 to 4
      robot = rob0 + qx[q] + (sz * qy[q])
      for i = 1 to n_keys
         x = key_pos[i] mod sz - sz div 2
         y = key_pos[i] div sz - sz div 2
         if x div abs x = qx[q] and abs y div y = qy[q]
            open[i] = 0
         else
            open[i] = 1
         .
      .
      calc_distances
      solve n_keys + 1 dist
      sum += dist
   .
   print sum
.
part2
#
input_data
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################

