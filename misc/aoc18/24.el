# AoC-18 - Day 24: Immune System Simulator 20XX
#
global type$[] .
#
proc type_id s$ . id .
   for id to len type$[]
      if type$[id] = s$ : return
   .
   type$[] &= s$
.
global team[] units0[] hitp[] imm[][] weak[][] dam0[] dam_type[] init[] attac[] .
#
proc read . .
   for team to 2
      s$ = input
      repeat
         s$ = input
         until s$ = ""
         s$[] = strtok s$ " (),;"
         team[] &= team
         units0[] &= number s$[1]
         ind = len units0[]
         hitp[] &= number s$[5]
         imm[][] &= [ ]
         weak[][] &= [ ]
         i = 8
         repeat
            h$ = s$[i]
            until h$ = "with"
            i += 1
            while s$[i] <> "immune" and s$[i] <> "weak" and s$[i] <> "with"
               type_id s$[i] h
               if h$ = "weak"
                  weak[ind][] &= h
               else
                  imm[ind][] &= h
               .
               i += 1
            .
         .
         dam0[] &= number s$[i + 5]
         type_id s$[i + 6] h
         dam_type[] &= h
         init[] &= number s$[i + 10]
         attac[] &= 0
      .
   .
.
read
#
#
proc combat boost . winner res .
   units[] = units0[]
   dam[] = dam0[]
   for i to len units[]
      if team[i] = 1 : dam[i] += boost
   .
   repeat
      len o[] 0
      for i to len units[]
         if units[i] > 0
            o[] &= i
            attac[i] = -1
         .
      .
      n = len o[]
      #
      for i to n - 1
         for j = i + 1 to n
            if units[o[j]] * dam[o[j]] * 100 + init[o[j]] > units[o[i]] * dam[o[i]] * 100 + init[o[i]]
               swap o[j] o[i]
            .
         .
      .
      for o to n
         i = o[o]
         max_ind = -1
         max_dam = 0
         for o2 to n
            j = o[o2]
            if team[j] <> team[i]
               for k to n
                  if attac[o[k]] = j : j = -1
               .
               if j <> -1
                  dam = dam[i] * units[i]
                  for k to len imm[j][]
                     if dam_type[i] = imm[j][k] : dam = 0
                  .
                  for k to len weak[j][]
                     if dam_type[i] = weak[j][k] : dam *= 2
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
      for i to n - 1
         for j = i + 1 to n
            if init[o[j]] > init[o[i]] : swap o[j] o[i]
         .
      .
      changed = 0
      for o to n
         i = o[o]
         j = attac[i]
         if j <> -1
            dam = dam[i] * units[i]
            for k to len weak[j][]
               if dam_type[i] = weak[j][k] : dam *= 2
            .
            nkill = dam div hitp[j]
            units[j] -= nkill
            if units[j] < 0 : units[j] = 0
            if nkill > 0 : changed = 1
         .
      .
      tst[] = [ 1 1 ]
      for o to n
         i = o[o]
         if units[i] > 0 : tst[team[i]] = 2
      .
      until tst[1] = 1 or tst[2] = 1 or changed = 0
   .
   res = 0
   for u in units[] : res += u
   winner = tst[2]
.
combat 0 winner res
print res
low = 1
high = 2000
while low + 1 < high
   boost = (high + low) div 2
   combat boost winner res
   if winner = 2
      low = boost
   else
      high = boost
   .
.
combat high winner res
print res
#
input_data
Immune System:
17 units each with 5390 hit points (weak to radiation, bludgeoning) with an attack that does 4507 fire damage at initiative 2
989 units each with 1274 hit points (immune to fire; weak to bludgeoning, slashing) with an attack that does 25 slashing damage at initiative 3

Infection:
801 units each with 4706 hit points (weak to radiation) with an attack that does 116 bludgeoning damage at initiative 1
4485 units each with 2961 hit points (immune to radiation; weak to fire, cold) with an attack that does 12 slashing damage at initiative 4


