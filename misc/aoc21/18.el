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
call readall
# 
global s$[] si .
func parse ind . tr[] .
   for ind = ind to ind + 1
      while s$[si] = "," or s$[si] = "]"
         si += 1
      .
      c$ = s$[si]
      si += 1
      if c$ = "["
         tr[ind] = -1
         call parse ind * 2 tr[]
      else
         tr[ind] = strcode c$ - 48
      .
   .
.
# 
global exploded expli expln splitted .
func explx lev ind . tr[] .
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
            call explx lev + 1 ind * 2 tr[]
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
func explode . tr[] .
   exploded = 0
   expli = -1
   expln = -1
   call explx 1 2 tr[]
.
func splitx ind . tr[] .
   for ind = ind to ind + 1
      if tr[ind] = -1
         call splitx ind * 2 tr[]
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
func split . tr[] .
   splitted = 0
   call splitx 2 tr[]
.
# 
func add tr[] . tree[] .
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
func magnitude_r ind . tr[] res .
   if tr[ind] = -1
      call magnitude_r ind * 2 tr[] h1
   else
      h1 = tr[ind]
   .
   ind += 1
   if tr[ind] = -1
      call magnitude_r ind * 2 tr[] h2
   else
      h2 = tr[ind]
   .
   res = 3 * h1 + 2 * h2
.
func magnitude tr[] . res .
   call magnitude_r 2 tr[] res
.
# 
func reduce . t[] .
   repeat
      repeat
         call explode t[]
         until exploded = 0
      .
      call split t[]
      until splitted = 0
   .
.
func getline l . tr[] .
   s$[] = strchars in$[l]
   si = 2
   len tr[] 64
   call parse 2 tr[]
.
func part1 . .
   call getline 1 t1[]
   for i = 2 to len in$[]
      call getline i t2[]
      call add t2[] t1[]
      call reduce t1[]
   .
   call magnitude t1[] m
   print m
.
call part1
# 
func part2 . .
   for i to len in$[]
      for j to len in$[]
         if i <> j
            call getline i t1[]
            call getline j t2[]
            call add t2[] t1[]
            call reduce t1[]
            call magnitude t1[] m
            if m > max
               max = m
            .
         .
      .
   .
   print max
.
call part2
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


