# AoC-23 - Day 5: If You Give A Seed A Fertilizer
# 
len range[][] 7
len diff[][] 7
global idn[] .
# 
proc init . .
   idn[] = number strsplit substr input 8 -1 " "
   s$ = input
   s$ = input
   for t to 7
      src[] = [ ]
      dest[] = [ ]
      lng[] = [ ]
      repeat
         s$ = input
         until s$ = ""
         m[] = number strsplit s$ " "
         dest[] &= m[1]
         src[] &= m[2]
         lng[] &= m[3]
      .
      # sort
      for i = 1 to len src[] - 1
         for j = i + 1 to len src[]
            if src[j] < src[i]
               swap src[j] src[i]
               swap dest[j] dest[i]
               swap lng[j] lng[i]
            .
         .
      .
      range[t][] &= 0
      diff[t][] &= 0
      for i to len src[]
         range[t][] &= src[i]
         diff[t][] &= dest[i] - src[i]
         range[t][] &= src[i] + lng[i]
         diff[t][] &= 0
      .
      range[t][] &= 1 / 0
      s$ = input
   .
.
init
# 
proc part1 . .
   min = 1 / 0
   for id in idn[]
      for t to 7
         for i to len range[t][] - 1
            if id >= range[t][i] and id < range[t][i + 1]
               id += diff[t][i]
               break 1
            .
         .
      .
      min = lower min id
   .
   print min
.
part1
# 
proc part2 . .
   for t to 7
      swap id[] idn[]
      idn[] = [ ]
      for ind = 1 step 2 to len id[]
         id = id[ind]
         lng = id[ind + 1]
         for i to len diff[t][]
            r1 = range[t][i]
            r2 = range[t][i + 1]
            if id >= r1 and id < r2
               idn[] &= id + diff[t][i]
               if id + lng <= r2
                  idn[] &= lng
                  break 1
               .
               idn[] &= r2 - id
               lng = lng - (r2 - id)
               id = r2
            .
         .
      .
   .
   min = 1 / 0
   for i = 1 step 2 to len idn[] - 1
      min = lower idn[i] min
   .
   print min
.
part2
# 
input_data
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4