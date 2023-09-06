# AoC-16 - Day 11: Radioisotope Thermoelectric Generators
# 
hashsz = 1999993
len hashind[] hashsz
# 
proc hash ind . ret .
   hi = ind mod hashsz + 1
   while hashind[hi] <> 0 and hashind[hi] <> ind
      hi = hi mod hashsz + 1
   .
   if hashind[hi] = 0
      hashind[hi] = ind
      ret = 0
   else
      ret = 1
   .
.
# 
na$[] = [ ]
proc getid n$ . id .
   for id to len na$[]
      if na$[id] = n$
         break 2
      .
   .
   na$[] &= n$
.
global todo[] todon[] .
global el el0 cod destcod .
len ar[] 16
arrbase ar[] 0
# 
proc init . .
   len ob[] 5
   len obx[] 5
   for fl = 0 to 3
      s$[] = strsplit input " "
      j = 6
      while j < len s$[]
         if s$[j] = "a"
            j += 1
         .
         n$ = substr s$[j] 1 2
         call getid n$ id
         if substr s$[j + 1] 1 3 = "gen"
            ob[id] = fl
         else
            obx[id] = fl
         .
         j += 3
      .
   .
   nob = len ob[]
   for i to nob
      h = 4 * ob[i] + obx[i]
      ar[h] += 1
   .
   destcod = nob * 4 + 3
.
call init
# 
proc tocod . .
   cod = 0
   for v in ar[]
      cod = cod * 8 + v
   .
   cod = cod * 4 + el
.
call tocod
cod0 = cod
# 
proc toarr . .
   h = cod
   el = h mod 4
   h = h div 4
   for i = 15 downto 0
      ar[i] = h mod 8
      h = h div 8
   .
.
# 
proc add_check i1 i2 . .
   ar[i1] -= 1
   ar[i2] += 1
   gen = 0
   for i = el * 4 to el * 4 + 3
      gen += ar[i]
   .
   for i range0 16
      if ar[i] > 0
         m = i mod 4
         g = i div 4
         if m = el and g <> el and gen > 0
            break 1
         .
      .
   .
   if i = 16
      call tocod
      call hash cod h
      if h = 0
         todon[] &= cod
      .
   .
   ar[i1] += 1
   ar[i2] -= 1
.
proc add_todo . .
   # one object
   l1[] = [ ]
   l2[] = [ ]
   for i range0 16
      if ar[i] > 0
         g = i div 4
         m = i mod 4
         if g = el0
            l1[] &= i
            l2[] &= el * 4 + m
         .
         if m = el0
            l1[] &= i
            l2[] &= g * 4 + el
         .
      .
   .
   for i to len l1[]
      call add_check l1[i] l2[i]
   .
   # gen+mic
   i = el0 * 4 + el0
   if ar[i] > 0
      call add_check i el * 4 + el
   .
   # 
   # two objects
   for li to len l1[]
      i = l1[li]
      gi = i div 4
      mi = i mod 4
      ii = l2[li]
      ar[i] -= 1
      ar[ii] += 1
      for lj to len l1[]
         j = l1[lj]
         if ar[j] > 0
            gj = j div 4
            mj = j mod 4
            ij = l2[lj]
            if gi = gj or mi = mj
               call add_check j ij
            .
         .
      .
      ar[ii] -= 1
      ar[i] += 1
   .
.
proc run . .
   call tocod
   todon[] = [ cod ]
   todo[] = [ ]
   # 
   while len todon[] <> 0
      swap todon[] todo[]
      todon[] = [ ]
      for cod in todo[]
         if cod = destcod
            print step
            break 2
         .
         call toarr
         el0 = el
         if el0 < 3
            el = el0 + 1
            call add_todo
         .
         if el0 > 0
            el = el0 - 1
            call add_todo
         .
      .
      step += 1
   .
.
call run
# 
cod = cod0
call toarr
el = 0
destcod += 8
ar[0] += 2
call run
# 
# 
input_data
The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.


