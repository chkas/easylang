# AoC-22 - Day 19: Not Enough Minerals
#
global max res[] rob[] cost[][] .
#
proc robres sig .
   res[1] += sig * rob[1]
   res[2] += sig * rob[2]
   res[3] += sig * rob[3]
.
proc search time skip geodes .
   if time = 0
      max = higher geodes max
      return
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
               robres 1
               if r = 4
                  search time - 1 0 geodes + time
               else
                  rob[r] += 1
                  search time - 1 0 geodes
                  rob[r] -= 1
               .
               robres -1
               res[1] += cost[r][1]
               res[2] += cost[r][2]
               res[3] += cost[r][3]
               if r = 4 : return
            .
         .
      .
   .
   robres 1
   search time - 1 skipn geodes
   robres -1
.
#
global inp$[] .
proc read .
   repeat
      s$ = input
      until s$ = ""
      inp$[] &= s$
   .
.
read
#
proc run time cnt &r[] .
   r[] = [ ]
   for id = 1 to cnt
      s$ = inp$[id]
      a[] = number strtok s$ " "
      cost[][] = [ [ a[2] 0 0 999 ] [ a[3] 0 0 999 ] [ a[4] a[5] 0 999 ] [ a[6] 0 a[7] 999 ] ]
      max = 0
      res[] = [ 0 0 0 0 ]
      rob[] = [ 1 0 0 0 ]
      search time 0 0
      r[] &= max
   .
.
run 23 len inp$[] r[]
for id to len r[] : sum += r[id] * id
print sum
run 31 3 r[]
print r[1] * r[2] * r[3]
#
input_data
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
Blueprint 3: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
