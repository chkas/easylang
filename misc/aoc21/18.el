# AoC-21 - Day 18: Snailfish
# 
# The tree is stored in an array. The
# branches are always 2 * i and 2 * i + 1.
# When adding, everything is simply moved
# up one level. Calculate magnitude,
# explode and split works recursively. 
# 
subr readall
   repeat
      s$ = input
      until s$ = ""
      in$[] &= s$
   .
.
readall
# 
global s$[] si .
proc parse ind . tr[] .
   for ind = ind to ind + 1
      while s$[si] = "," or s$[si] = "]"
         si += 1
      .
      c$ = s$[si]
      si += 1
      if c$ = "["
         tr[ind] = -1
         parse ind * 2 tr[]
      else
         tr[ind] = strcode c$ - 48
      .
   .
.
# 
global exploded expli expln splitted .
proc explx lev ind . tr[] .
   for ind = ind to ind + 1
      if tr[ind] = -1
         if lev >= 4 and exploded = 0 and tr[ind * 2] <> -1 and tr[ind * 2 + 1] <> -1
            exploded = 1
            if expli >= 0
               tr[expli] += tr[ind * 2]
            .
            expln = tr[ind * 2 + 1]
            tr[ind] = 0
         else
            explx lev + 1 ind * 2 tr[]
         .
      else
         expli = ind
         if expln >= 0
            tr[ind] += expln
            expln = -1
         .
      .
   .
.
proc explode . tr[] .
   exploded = 0
   expli = -1
   expln = -1
   explx 1 2 tr[]
.
proc splitx ind . tr[] .
   for ind = ind to ind + 1
      if tr[ind] = -1
         splitx ind * 2 tr[]
      else
         if tr[ind] > 9 and splitted = 0
            splitted = 1
            tr[ind * 2] = tr[ind] div 2
            tr[ind * 2 + 1] = (tr[ind] + 1) div 2
            tr[ind] = -1
         .
      .
   .
.
proc split . tr[] .
   splitted = 0
   splitx 2 tr[]
.
# 
proc add tr[] . tree[] .
   tr0[] = tree[]
   for i to len tree[]
      tree[i] = 0
   .
   tree[2] = -1
   tree[3] = -1
   l = 2
   while l <= len tree[] / 4
      for i = 0 to l - 1
         tree[l * 2 + i] = tr0[l + i]
         tree[l * 2 + l + i] = tr[l + i]
      .
      l *= 2
   .
.
# 
proc magnitude_r ind . tr[] res .
   if tr[ind] = -1
      magnitude_r ind * 2 tr[] h1
   else
      h1 = tr[ind]
   .
   ind += 1
   if tr[ind] = -1
      magnitude_r ind * 2 tr[] h2
   else
      h2 = tr[ind]
   .
   res = 3 * h1 + 2 * h2
.
proc magnitude tr[] . res .
   magnitude_r 2 tr[] res
.
# 
proc reduce . t[] .
   repeat
      repeat
         explode t[]
         until exploded = 0
      .
      split t[]
      until splitted = 0
   .
.
proc getline l . tr[] .
   s$[] = strchars in$[l]
   si = 2
   len tr[] 64
   parse 2 tr[]
.
proc part1 . .
   getline 1 t1[]
   for i = 2 to len in$[]
      getline i t2[]
      add t2[] t1[]
      reduce t1[]
   .
   magnitude t1[] m
   print m
.
part1
# 
proc part2 . .
   for i to len in$[]
      for j to len in$[]
         if i <> j
            getline i t1[]
            getline j t2[]
            add t2[] t1[]
            reduce t1[]
            magnitude t1[] m
            if m > max
               max = m
            .
         .
      .
   .
   print max
.
part2
# 
# 
input_data
[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]


