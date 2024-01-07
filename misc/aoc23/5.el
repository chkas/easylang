# AoC-23 - Day 5: If You Give A Seed A Fertilizer
# 
len dest[][] 7
len src[][] 7
len lng[][] 7
global idn[] .
# 
proc init . .
   idn[] = number strsplit substr input 8 -1 " "
   s$ = input
   s$ = input
   for t to 7
      repeat
         s$ = input
         until s$ = ""
         m[] = number strsplit s$ " "
         dest[t][] &= m[1]
         src[t][] &= m[2]
         lng[t][] &= m[3]
      .
      s$ = input
   .
.
init
# 
proc part1 . .
   min = 1 / 0
   for id in idn[]
      for t to 7
         for i to len src[t][]
            if id >= src[t][i] and id < src[t][i] + lng[t][i]
               id = dest[t][i] + id - src[t][i]
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
      ind = 1
      while ind <= len id[] - 1
         id1 = id[ind]
         id2 = id1 + id[ind + 1]
         ind += 2
         for i to len src[t][]
            r1 = src[t][i]
            r2 = src[t][i] + lng[t][i]
            if id1 < r2 and id2 > r1
               p1 = higher id1 r1
               p2 = lower id2 r2
               idn[] &= p1 + dest[t][i] - r1
               idn[] &= p2 - p1
               # 
               if id1 < p1
                  id[] &= id1
                  id[] &= p1 - id1
               .
               if id2 > p2
                  id[] &= p2
                  id[] &= id2 - p2
               .
               break 1
            .
         .
         if i > len src[t][]
            idn[] &= id1
            idn[] &= id2 - id1
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
