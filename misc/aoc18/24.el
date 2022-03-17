# AoC-18 - Day 24: Immune System Simulator 20XX
# 
global type$[] .
# 
func type_id s$ . id .
  for id range len type$[]
    if type$[id] = s$
      break 2
    .
  .
  type$[] &= s$
.
global team[] units0[] hitp[] imm[][] weak[][] dam0[] dam_type[] init[] attac[] .
# 
func read . .
  for team range 2
    s$ = input
    repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ " (),;"
      ind = len units0[]
      team[] &= team
      units0[] &= number s$[0]
      hitp[] &= number s$[4]
      imm[][] &= [ ]
      weak[][] &= [ ]
      i = 8
      if s$[i] = "an"
        i -= 1
      .
      while s$[i] = "weak" or s$[i] = "immune"
        if s$[i] = "weak"
          i += 2
          while s$[i] <> "immune" and s$[i] <> "with"
            if s$[i] <> ""
              call type_id s$[i] h
              weak[ind][] &= h
            .
            i += 1
          .
        else
          i += 2
          while s$[i] <> "weak" and s$[i] <> "with"
            if s$[i] <> ""
              call type_id s$[i] h
              imm[ind][] &= h
            .
            i += 1
          .
        .
      .
      dam0[] &= number s$[i + 5]
      call type_id s$[i + 6] h
      dam_type[] &= h
      init[] &= number s$[i + 10]
      attac[] &= 0
    .
  .
.
call read
# 
# 
func combat boost . winner res .
  units[] = units0[]
  dam[] = dam0[]
  for i range len units[]
    if team[i] = 0
      dam[i] += boost
    .
  .
  repeat
    len o[] 0
    for i range len units[]
      if units[i] > 0
        o[] &= i
        attac[i] = -1
      .
    .
    n = len o[]
    # 
    for i = 0 to n - 2
      for j = i + 1 to n - 1
        if units[o[j]] * dam[o[j]] * 100 + init[o[j]] > units[o[i]] * dam[o[i]] * 100 + init[o[i]]
          swap o[j] o[i]
        .
      .
    .
    for o range n
      i = o[o]
      max_ind = -1
      max_dam = 0
      for o2 range n
        j = o[o2]
        if team[j] <> team[i]
          for k range n
            if attac[o[k]] = j
              j = -1
            .
          .
          if j <> -1
            dam = dam[i] * units[i]
            for k range len imm[j][]
              if dam_type[i] = imm[j][k]
                dam = 0
              .
            .
            for k range len weak[j][]
              if dam_type[i] = weak[j][k]
                dam *= 2
              .
            .
            if dam > max_dam
              max_dam = dam
              max_ind = j
            .
          .
        .
      .
      attac[i] = max_ind
    .
    for i = 0 to n - 2
      for j = i + 1 to n - 1
        if init[o[j]] > init[o[i]]
          swap o[j] o[i]
        .
      .
    .
    changed = 0
    for o range n
      i = o[o]
      j = attac[i]
      if j <> -1
        dam = dam[i] * units[i]
        for k range len weak[j][]
          if dam_type[i] = weak[j][k]
            dam *= 2
          .
        .
        nkill = dam div hitp[j]
        units[j] -= nkill
        if units[j] < 0
          units[j] = 0
        .
        if nkill > 0
          changed = 1
        .
      .
    .
    tst[] = [ 0 0 ]
    for o range n
      i = o[o]
      if units[i] > 0
        tst[team[i]] = 1
      .
    .
    until tst[0] = 0 or tst[1] = 0 or changed = 0
  .
  res = 0
  for i range len units[]
    res += units[i]
  .
  winner = tst[1]
.
call combat 0 winner res
print res
low = 1
high = 1000
while low + 1 < high
  boost = (high + low) div 2
  call combat boost winner res
  if winner = 1
    low = boost
  else
    high = boost
  .
.
call combat high winner res
print res
# 
# 
input_data
Immune System:
479 units each with 3393 hit points (weak to radiation) with an attack that does 66 cold damage at initative 8
2202 units each with 4950 hit points (weak to fire; immune to slashing) with an attack that does 18 cold damage at initative 2
8132 units each with 9680 hit points (weak to bludgeoning, fire; immune to slashing) with an attack that does 9 radiation damage at initative 7
389 units each with 13983 hit points (immune to bludgeoning) with an attack that does 256 cold damage at initative 13
1827 units each with 5107 hit points with an attack that does 24 slashing damage at initative 18
7019 units each with 2261 hit points (immune to radiation, slashing, cold) with an attack that does 3 fire damage at initative 16
4736 units each with 8421 hit points (weak to cold) with an attack that does 17 slashing damage at initative 3
491 units each with 3518 hit points (weak to cold; immune to fire, bludgeoning) with an attack that does 65 radiation damage at initative 1
2309 units each with 7353 hit points (immune to radiation) with an attack that does 31 bludgeoning damage at initative 20
411 units each with 6375 hit points (immune to slashing; weak to cold, fire) with an attack that does 151 bludgeoning damage at initative 14

Infection:
148 units each with 31914 hit points (immune to radiation, cold, fire; weak to bludgeoning) with an attack that does 416 cold damage at initative 4
864 units each with 38189 hit points with an attack that does 72 slashing damage at initative 6
2981 units each with 7774 hit points (immune to bludgeoning, cold) with an attack that does 4 fire damage at initative 15
5259 units each with 22892 hit points with an attack that does 8 fire damage at initative 5
318 units each with 16979 hit points (weak to fire) with an attack that does 106 bludgeoning damage at initative 9
5017 units each with 32175 hit points (immune to radiation; weak to slashing) with an attack that does 11 bludgeoning damage at initative 17
4308 units each with 14994 hit points (weak to slashing; immune to fire, cold) with an attack that does 5 fire damage at initative 10
208 units each with 14322 hit points (weak to radiation) with an attack that does 133 cold damage at initative 19
3999 units each with 48994 hit points (weak to cold, slashing) with an attack that does 20 cold damage at initative 11
1922 units each with 34406 hit points (weak to slashing) with an attack that does 35 slashing damage at initative 12








