# AoC-24 - Day 18: RAM Run
#
global data[][] size m[] offs[] nc size .
proc read .
   size = 7
   repeat
      s$ = input
      until s$ = ""
      data[][] &= number strsplit s$ ","
   .
   if len data[][] > 1024 : size = 71
.
read
#
proc corrupt n .
   m[] = [ ]
   nc = size + 2
   offs[] = [ 1 nc -1 (-nc) ]
   for i to nc : m[] &= 1
   for i to nc - 2
      m[] &= 1
      for j to nc - 2 : m[] &= 0
      m[] &= 1
   .
   for i to nc : m[] &= 1
   #
   for i to n : m[nc + data[i][2] * nc + data[i][1] + 2] = 1
.
#
func find .
   len seen[] len m[]
   todo[] = [ nc + 2 ]
   seen[nc + 2] = 1
   while len todo[] > 0
      todon[] = [ ]
      for p in todo[]
         if p = nc * nc - nc - 1
            return cnt
            break 2
         .
         for of in offs[]
            pn = p + of
            if m[pn] = 0 and seen[pn] = 0
               seen[pn] = 1
               todon[] &= pn
            .
         .
      .
      swap todo[] todon[]
      cnt += 1
   .
.
proc part1 .
   cnt = 12
   if size > 7 : cnt = 1024
   corrupt cnt
   print find
.
part1
#
proc part2 .
   min = 1
   max = len data[][]
   repeat
      mid = (min + max) div 2
      corrupt mid
      if find = 0
         max = mid
      else
         min = mid + 1
      .
      until min = max
   .
   print data[min][1] & "," & data[min][2]
.
part2
#
input_data
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
