# AoC-19 - Day 14: Space Stoichiometry
# 
global name$[] recpt0[][] .
# 
proc nid n$ . i .
   for i to len name$[]
      if name$[i] = n$
         break 2
      .
   .
   name$[] &= n$
.
proc parse . .
   nid "ORE" h
   nid "FUEL" h
   repeat
      s$ = input
      until s$ = ""
      len recpt[] 2
      i = 1
      a$[] = strsplit s$ ", "
      repeat
         nid a$[i + 1] id
         recpt[] &= id
         recpt[] &= number a$[i]
         until a$[i + 2] = "=>"
         i += 3
      .
      nid a$[i + 4] id
      recpt[1] = id
      recpt[2] = number a$[i + 3]
      recpt0[][] &= recpt[]
   .
.
parse
# 
proc produce_fuel need . n_ore .
   recpt[][] = recpt0[][]
   len need[] len name$[]
   need[2] = need
   while len recpt[][] > 0
      for recpt to len recpt[][]
         chem = recpt[recpt][1]
         is_top = 1
         for i to len recpt[][]
            for j = 3 step 2 to len recpt[i][]
               if chem = recpt[i][j]
                  is_top = 0
                  break 2
               .
            .
         .
         if is_top = 1
            break 1
         .
      .
      n = floor ((need[chem] - 1) / recpt[recpt][2] + 1)
      for j = 3 step 2 to len recpt[recpt][]
         need[recpt[recpt][j]] += n * recpt[recpt][j + 1]
      .
      need[chem] = 0
      h = len recpt[][]
      swap recpt[recpt][] recpt[h][]
      len recpt[][] -1
   .
   n_ore = need[1]
.
produce_fuel 1 n_ore
print n_ore
# 
proc part2 . .
   min = 1
   max = 9999999999
   while min + 1 < max
      t = (min + max) div 2
      produce_fuel t n_ore
      if n_ore <= 1000000000000
         min = t
      else
         max = t
      .
   .
   print min
.
part2
# 
input_data
171 ORE => 8 CNZTR
7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
114 ORE => 4 BHXH
14 VRPVC => 6 BMBT
6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
5 BMBT => 4 WPTQ
189 ORE => 9 KTJDG
1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
12 VRPVC, 27 CNZTR => 2 XDBXC
15 KTJDG, 12 BHXH => 5 XCVML
3 BHXH, 2 VRPVC => 7 MZWV
121 ORE => 7 VRPVC
7 XCVML => 6 RJRHP
5 BHXH, 4 VRPVC => 5 LTCX

