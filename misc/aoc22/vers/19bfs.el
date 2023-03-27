# AoC-22 - Day 19: Not Enough Minerals
#
# Part1 
#
# TODO: make it DFS
#
subr init
   skip = 0
   val = 0
   mon[] = [ 0 0 0 0 ]
   rob[] = [ 1 0 0 0 ]
   cost[][] = [ [ ore 0 0 999 ] [ clay 0 0 999 ] [ obso obsc 0 999 ] [ geodo 0 geodob 999 ] ]
.
# 
func tocod . cod .
   cod = 0
   for i = 1 to 3
      if mon[i] >= 300
         pr mon[]
         pr rob[]
         print "mon error"
         sleep 100
      .
      cod = cod * 300 + mon[i]
   .
   for i = 1 to 3
      if rob[i] >= 20
         pr rob[]
         print "rob error"
         sleep 100
      .
      cod = cod * 20 + rob[i]
   .
   cod = cod * 50 + val
   cod = cod * 8 + skip
.
func torob . cod .
   skip = cod mod 8
   cod = cod div 8
   val = cod mod 50
   cod = cod div 50
   for i = 3 downto 1
      rob[i] = cod mod 20
      cod = cod div 20
   .
   for i = 3 downto 1
      mon[i] = cod mod 300
      cod = cod div 300
   .
.
global todon[] max time .
# 
func add r . .
   for i = 1 to 3
      mon[i] += rob[i]
   .
   if r >= 1
      if r = 4
         val += time
      else
         rob[r] += 1
      .
   .
   call tocod cod
   todon[] &= cod
   if r >= 1
      if r = 4
         val -= time
      else
         rob[r] -= 1
      .
   .
   for i = 1 to 3
      mon[i] -= rob[i]
   .
.
func addways cod . .
   call torob cod
   skipp = skip
   skip = 0
   bas = 8
   for i = 4 downto 1
      sk *= 2
      h = 0
      s = 0
      if skipp >= bas
         skipp -= bas
         s = 1
      .
      bas = bas div 2
      # 
      h = rob[i] + mon[i] div time
      if h >= cost[1][i] and h >= cost[2][i] and h >= cost[3][i] and h >= cost[4][i]
      elif cost[i][1] <= mon[1] and cost[i][2] <= mon[2] and cost[i][3] <= mon[3]
         sk += 1
         if s = 0
            mon[1] -= cost[i][1]
            mon[2] -= cost[i][2]
            mon[3] -= cost[i][3]
            call add i
            mon[1] += cost[i][1]
            mon[2] += cost[i][2]
            mon[3] += cost[i][3]
            if i >= 4
               break 2
            .
         .
      .
   .
   skip = sk
   call add 0
   skip = 0
.
func run . max .
   max = 0
   call tocod cod
   todo[] = [ cod ]
   for time = 23 downto 0
      # for part2
      #   for time = 31 downto 0
      todon[] = [ ]
      for i = 1 to len todo[]
         call addways todo[i]
      .
      swap todon[] todo[]
      #      pr len todo[]
   .
   for cod in todo[]
      call torob cod
      max = higher max val
   .
.
# 
func read . .
   part2 = 1
   id = 1
   repeat
      s$ = input
      until s$ = ""
      a[] = number strsplit s$ " "
      ore = a[7]
      clay = a[13]
      obso = a[19]
      obsc = a[22]
      geodo = a[28]
      geodob = a[31]
      rob[] = [ 1 0 0 0 ]
      cost[][] = [ [ ore 0 0 ] [ clay 0 0 ] [ obso obsc 0 ] [ geodo 0 geodob ] ]
      call init
      call run max
      pr max
      sum += max * id
      part2 *= max
      id += 1
   .
   print ""
   print sum
   print part2
.
call read
# 
input_data
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.

