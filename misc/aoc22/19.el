# AoC-22 - Day 19: Not Enough Minerals
# 
# Part 1 with DFS
# 
global max res[] rob[] cost[][] .
# 
proc robres sig . .
   res[1] += sig * rob[1]
   res[2] += sig * rob[2]
   res[3] += sig * rob[3]
.
proc search time skip geodes . .
   if time = 0
      max = higher geodes max
      break 1
   .
   for r = 4 downto 1
      h = rob[r] + res[r] div time
      if not (h >= cost[1][r] and h >= cost[2][r] and h >= cost[3][r] and h >= cost[4][r])
         if cost[r][1] <= res[1] and cost[r][2] <= res[2] and cost[r][3] <= res[3]
            skipn = bitor skipn bitshift 1 r
            if bitand skip bitshift 1 r = 0
               res[1] -= cost[r][1]
               res[2] -= cost[r][2]
               res[3] -= cost[r][3]
               call robres 1
               if r = 4
                  call search time - 1 0 geodes + time
               else
                  rob[r] += 1
                  call search time - 1 0 geodes
                  rob[r] -= 1
               .
               call robres -1
               res[1] += cost[r][1]
               res[2] += cost[r][2]
               res[3] += cost[r][3]
               if r = 4
                  break 2
               .
            .
         .
      .
   .
   call robres 1
   call search time - 1 skipn geodes
   call robres -1
.
# 
proc run . .
   id = 1
   repeat
      s$ = input
      until s$ = ""
      a[] = number strsplit s$ " "
      cost[][] = [ [ a[7] 0 0 999 ] [ a[13] 0 0 999 ] [ a[19] a[22] 0 999 ] [ a[28] 0 a[31] 999 ] ]
      max = 0
      res[] = [ 0 0 0 0 ]
      rob[] = [ 1 0 0 0 ]
      call search 23 0 0
      sum += max * id
      id += 1
   .
   print sum
.
call run
# 
input_data
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.


