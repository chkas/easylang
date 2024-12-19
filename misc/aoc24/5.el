# AoC-24 - Day 5: Print Queue
#
global m[][] .
proc init . .
   len m[][] 100
   for i to 100 : len m[i][] 100
   repeat
      s$ = input
      until s$ = ""
      n[] = number strsplit s$ "|"
      m[n[2]][n[1]] = -1
   .
.
init
proc gmid s$ . sum1 sum2 .
   n[] = number strsplit s$ ","
   for n in n[]
      seen[] &= 0
      for i to len seen[] - 1
         if m[seen[i]][n] < 0
            for j = len seen[] - 1 downto i
               seen[j + 1] = seen[j]
            .
            break 1
         .
      .
      seen[i] = n
   .
   if seen[] = n[]
      sum1 += n[len n[] div 2 + 1]
   else
      sum2 += seen[len seen[] div 2 + 1]
   .
.
repeat
   s$ = input
   until s$ = ""
   gmid s$ sum1 sum2
.
print sum1
print sum2
#
input_data
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
