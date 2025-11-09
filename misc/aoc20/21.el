# AoC-20 - Day 21: Allergen Assessment
#
global ingre$[] allerg$[] meal_ingre[][] meal_allerg[][] .
#
proc ingre_id s$ &i .
   for i to len ingre$[]
      if ingre$[i] = s$ : return
   .
   ingre$[] &= s$
.
proc allerg_id s$ &i .
   for i to len allerg$[]
      if allerg$[i] = s$ : return
   .
   allerg$[] &= s$
.
proc read .
   meal = 1
   repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ " "
      i = 1
      meal_ingre[][] &= [ ]
      while s$[i] <> "(contains"
         ingre_id s$[i] v
         meal_ingre[meal][] &= v
         i += 1
      .
      i += 1
      meal_allerg[][] &= [ ]
      while i <= len s$[]
         s$ = substr s$[i] 1 (len s$[i] - 1)
         allerg_id s$ v
         meal_allerg[meal][] &= v
         i += 1
      .
      meal += 1
   .
.
read
#
n_meal = len meal_ingre[][]
n_ingre = len ingre$[]
n_allerg = len allerg$[]
#
proc allerg_in_meal allerg meal &is_in .
   is_in = 0
   for i to len meal_allerg[meal][]
      if allerg = meal_allerg[meal][i]
         is_in = 1
         break 1
      .
   .
.
proc ingre_in_meal ingre meal &is_in .
   is_in = 0
   for i to len meal_ingre[meal][]
      if ingre = meal_ingre[meal][i]
         is_in = 1
         break 1
      .
   .
.
#
len ingre_allerg0[] n_ingre
global allerg_ingre[][] .
#
proc search allerg .
   len ingre_allerg[] n_ingre
   for i to n_ingre : ingre_allerg[i] = 1
   for meal to n_meal
      allerg_in_meal allerg meal is_in
      if is_in = 1
         for ingre to n_ingre
            ingre_in_meal ingre meal is_in
            if is_in = 0
               ingre_allerg[ingre] = 0
            .
         .
      .
   .
   for i to n_ingre
      if ingre_allerg[i] = 1
         ingre_allerg0[i] = 1
      .
   .
   allerg_ingre[][] &= ingre_allerg[]
.
for i to n_allerg
   search i
.
#
proc part1 .
   for ingre to n_ingre
      if ingre_allerg0[ingre] = 0
         for meal to n_meal
            ingre_in_meal ingre meal is_in
            sum += is_in
         .
      .
   .
   print sum
.
part1
#
#
len allerg_ingre[] n_allerg
proc part2 .
   for k to n_allerg
      for allerg to n_allerg
         s = 0
         for i to len allerg_ingre[allerg][]
            if allerg_ingre[allerg][i] = 1
               s += 1
               ingr = i
            .
         .
         if s = 1
            allerg_ingre[allerg] = ingr
            for allerg to n_allerg
               allerg_ingre[allerg][ingr] = 0
            .
            break 1
         .
      .
   .
   # sort it by allergen
   for i to n_allerg : ord[] &= i
   for i to n_allerg - 1
      for j = i + 1 to n_allerg
         h = strcmp allerg$[ord[j]] allerg$[ord[i]]
         if h < 0 : swap ord[i] ord[j]
      .
   .
   for i to n_allerg
      a = ord[i]
      ingr = allerg_ingre[a]
      write ingre$[ingr]
      if i < n_allerg : write ","
   .
   print ""
.
part2
#
input_data
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)



