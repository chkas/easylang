# AoC-15 - Day 22: Wizard Simulator 20XX
#
boss_hit = number substr input 13 9
boss_dmg = number substr input 9 9
#
procdecl player cost mana hit bhit eff[] .
#
min = 1 / 0
proc effect &arm &bhit &mana &eff[] .
   if eff[1] > 0
      arm = 7
      eff[1] -= 1
   .
   if eff[2] > 0
      bhit -= 3
      eff[2] -= 1
   .
   if eff[3] > 0
      mana += 101
      eff[3] -= 1
   .
.
sel_cost[] = [ 53 73 113 173 229 ]
proc select cost sel mana hit bhit eff[] .
   cost += sel_cost[sel]
   mana -= sel_cost[sel]
   if sel = 1
      bhit -= 4
   elif sel = 2
      bhit -= 2
      hit += 2
   elif sel = 3
      eff[1] = 6
   elif sel = 4
      eff[2] = 6
   else
      eff[3] = 5
   .
   if mana >= 0 and cost < min
      effect arm bhit mana eff[]
      if bhit <= 0
         min = lower min cost
      else
         hit -= higher 1 boss_dmg - arm
         player cost mana hit bhit eff[]
      .
   .
.
#
part2 = 0
proc player cost mana hit bhit eff[] .
   if part2 = 1
      hit -= 1
   .
   if hit > 0
      effect arm bhit mana eff[]
      if bhit <= 0
         min = lower min cost
      else
         for sel to 5
            if sel <= 2 or eff[sel - 2] = 0
               select cost sel mana hit bhit eff[]
            .
         .
      .
   .
.
#
player 0 500 50 boss_hit [ 0 0 0 ]
print min
part2 = 1
min = 1 / 0
player 0 500 50 boss_hit [ 0 0 0 ]
print min
#
input_data
Hit Points: 68
Damage: 9


