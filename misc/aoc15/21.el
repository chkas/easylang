# AoC-15 - Day 21: RPG Simulator 20XX
# 
hit2s = number substr input 13 -1
dmg2s = number substr input 9 -1
arm2s = number substr input 8 -1
# 
wpn_dmg[] = [ 4 5 6 7 8 ]
wpn_cost[] = [ 8 10 25 40 74 ]
arm_arm[] = [ 1 2 3 4 5 0 ]
arm_cost[] = [ 13 31 53 75 102 0 ]
ring_cost[] = [ 25 50 100 20 40 80 0 0 ]
ring_dmg[] = [ 1 2 3 0 0 0 0 0 ]
ring_arm[] = [ 0 0 0 1 2 3 0 0 ]
# 
min = 1 / 0
for wpn to 5
   for iarm to 6
      for r1 to 7
         for r2 = r1 + 1 to 8
            if r1 <= 6 and r2 <= 7 or r1 = 7 and r2 = 8
               cost = wpn_cost[wpn] + arm_cost[iarm] + ring_cost[r1] + ring_cost[r2]
               dmg = wpn_dmg[wpn] + ring_dmg[r1] + ring_dmg[r2]
               arm = arm_arm[iarm] + ring_arm[r1] + ring_arm[r2]
               # 
               hit = 100
               hit2 = hit2s
               dmg2 = dmg2s
               arm2 = arm2s
               # 
               winner = 0
               repeat
                  d = dmg - arm2
                  if d < 1
                     d = 1
                  .
                  hit2 -= d
                  until hit2 <= 0
                  swap hit hit2
                  swap dmg dmg2
                  swap arm arm2
                  winner = 1 - winner
               .
               if winner = 0
                  min = lower min cost
               else
                  max = higher max cost
               .
            .
         .
      .
   .
.
print min
print max
#  
input_data
Hit Points: 120
Damage: 7
Armor: 2


