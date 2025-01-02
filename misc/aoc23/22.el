# AoC-23 - Day 22: Sand Slabs
#
global br[][] .
#
proc read . .
   repeat
      s$ = input
      until s$ = ""
      w[] = number strtok s$ ",~"
      br[][] &= w[]
   .
.
read
#
proc sort . d[][] .
   for i = 1 to len d[][] - 1
      for j = i + 1 to len d[][]
         if d[j][6] < d[i][6]
            swap d[j][] d[i][]
         .
      .
   .
.
sort br[][]
#
len supby[][] len br[][]
#
proc fall . .
   for i to len br[][]
      swap b[] br[i][]
      while b[3] > 1
         for j = i - 1 downto 1
            if br[j][6] + 1 = b[3]
               # one underneath
               if b[4] >= br[j][1] and b[1] <= br[j][4]
                  if b[5] >= br[j][2] and b[2] <= br[j][5]
                     supby[i][] &= j
                  .
               .
            .
         .
         if len supby[i][] > 0
            break 1
         .
         b[3] -= 1
         b[6] -= 1
      .
      swap b[] br[i][]
   .
.
fall
#
func safe x .
   for i to len supby[][]
      ln = len supby[i][]
      for j to ln
         if supby[i][j] = x and len supby[i][] = 1
            return 0
         .
      .
   .
   return 1
.
proc part1 . .
   for i to len supby[][] : sum += safe i
   print sum
.
part1
#
func remove x .
   supb[][] = supby[][]
   torm[] &= x
   while len torm[] > 0
      x = torm[len torm[]]
      sum += 1
      len torm[] -1
      for i to len supb[][]
         ln = len supb[i][]
         for j to ln
            if supb[i][j] = x
               supb[i][j] = supb[i][ln]
               len supb[i][] -1
               if ln = 1 : torm[] &= i
               break 1
            .
         .
      .
   .
   return sum - 1
.
proc part2 . .
   for i to len supby[][] : sum += remove i
   print sum
.
part2
#
input_data
1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9