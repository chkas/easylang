# AoC-20 - Day 7: Handy Haversacks
#
global col$[] cont_col[][] cont_cnt[][] .
#
proc col_id s$ . col .
   for col to len col$[]
      if col$[col] = s$ : return
   .
   col$[] &= s$
   cont_col[][] &= [ ]
   cont_cnt[][] &= [ ]
.
proc read_inp . .
   repeat
      inp$ = input
      until inp$ = ""
      s$[] = strsplit inp$ " "
      col_id s$[1] & " " & s$[2] s
      if s$[5] <> "no"
         i = 5
         while i <= len s$[]
            cnt = number s$[i]
            col_id s$[i + 1] & " " & s$[i + 2] col
            cont_col[s][] &= col
            cont_cnt[s][] &= cnt
            i += 4
         .
      .
   .
.
read_inp
col_id "shiny gold" gold
#
proc search col . fnd .
   if col = gold
      fnd = 1
      return
   .
   fnd = 0
   for c in cont_col[col][]
      search c h
      if h = 1 : fnd = 1
   .
.
proc part1 . .
   for i to len cont_col[][]
      if i <> gold
         search i fnd
         sum += fnd
      .
   .
   print sum
.
part1
#
proc get_sum col . sum .
   sum = 0
   for i to len cont_col[col][]
      get_sum cont_col[col][i] s
      h = cont_cnt[col][i]
      sum += h + h * s
   .
.
proc part2 . .
   get_sum gold sum
   print sum
.
part2
#
input_data
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.