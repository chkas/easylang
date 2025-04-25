# AoC-23 - Day 12: Hot Springs
#
global cache[] cache0[] .
proc init .
   for i to 18 * 36 * 120 : cache0[] &= -1
.
init
proc cache_init .
   cache[] = cache0[]
.
func cache_ind idx gid cnt .
   return (idx * 18 + cnt) * 36 + gid
.
global spr$[] grp[] .
#
funcdecl test idx gid cnt .
func test_op idx gid cnt .
   if cnt > 0 and cnt <> grp[gid] : return 0
   return test (idx + 1) gid 0
.
func test_dmg idx gid cnt .
   if cnt = 0
      if gid + 1 > len grp[] : return 0
      return test (idx + 1) (gid + 1) 1
   .
   if cnt >= grp[gid] : return 0
   return test (idx + 1) gid (cnt + 1)
.
func test idx gid cnt .
   cind = cache_ind idx gid cnt
   if cache[cind] <> -1 : return cache[cind]
   if idx > len spr$[]
      res = 1
      if gid <> len grp[]
         res = 0
      elif cnt > 0 and cnt <> grp[gid]
         res = 0
      .
   elif spr$[idx] = "."
      res = test_op idx gid cnt
   elif spr$[idx] = "#"
      res = test_dmg idx gid cnt
   elif spr$[idx] = "?"
      r1 = test_dmg idx gid cnt
      r2 = test_op idx gid cnt
      res = r1 + r2
   .
   cache[cind] = res
   return res
.
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ " "
   m$[] = strchars s$[1]
   m[] = number strsplit s$[2] ","
   #
   # part 1
   spr$[] = m$[]
   grp[] = m[]
   cache_init
   sum1 += test 1 0 0
   #
   # part 2
   for k = 2 to 5
      spr$[] &= "?"
      for idx to len m$[] : spr$[] &= m$[idx]
      for idx to len m[] : grp[] &= m[idx]
   .
   cache_init
   sum2 += test 1 0 0
.
print sum1
print sum2
#
input_data
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
