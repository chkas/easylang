# AoC-15 - Day 22: Wizard Simulator 20XX
# 
boss_hit = number substr input 12 99
boss_dmg = number substr input 8 99
# 
funcdecl player cost mana hit bhit eff[] . .
# 
min = 1 / 0
func effect . arm bhit mana eff[] .
  if eff[0] > 0
    arm = 7
    eff[0] -= 1
  .
  if eff[1] > 0
    bhit -= 3
    eff[1] -= 1
  .
  if eff[2] > 0
    mana += 101
    eff[2] -= 1
  .
.
sel_cost[] = [ 53 73 113 173 229 ]
func select cost sel mana hit bhit eff[] . .
  cost += sel_cost[sel]
  mana -= sel_cost[sel]
  if sel = 0
    bhit -= 4
  elif sel = 1
    bhit -= 2
    hit += 2
  elif sel = 2
    eff[0] = 6
  elif sel = 3
    eff[1] = 6
  else
    eff[2] = 5
  .
  if mana >= 0 and cost < min
    call effect arm bhit mana eff[]
    if bhit <= 0
      min = lower min cost
    else
      hit -= higher 1 boss_dmg - arm
      call player cost mana hit bhit eff[]
    .
  .
.
# 
part2 = 0
func player cost mana hit bhit eff[] . .
  if part2 = 1
    hit -= 1
  .
  if hit > 0
    call effect arm bhit mana eff[]
    if bhit <= 0
      min = lower min cost
    else
      for sel range 5
        if sel < 2 or eff[sel - 2] = 0
          call select cost sel mana hit bhit eff[]
        .
      .
    .
  .
.
# 
call player 0 500 50 boss_hit [ 0 0 0 ]
print min
part2 = 1
min = 1 / 0
call player 0 500 50 boss_hit [ 0 0 0 ]
print min
#  
input_data
Hit Points: 71
Damage: 10



