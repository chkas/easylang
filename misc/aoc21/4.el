# AoC-21 - Day 4: Giant Squid
#
# Straightforward. The only tricky part is
# determining whether a row or column is
# complete. Completed fields are marked with
# -1. So the sum of the completed rows or
# columns is -5.
#
numbs[] = number strtok input ","
s$ = input
#
repeat
   s$ = input
   until s$ = ""
   brd[][] &= [ ]
   for i = 1 to 5
      for h in number strtok s$ " "
         brd[$][] &= h
      .
      s$ = input
   .
.
len done[] len brd[][]
#
for numb in numbs[]
   for b = 1 to len brd[][]
      if done[b] = 0
         for i = 1 to 25
            if brd[b][i] = numb : brd[b][i] = -1
         .
         for i = 0 to 4
            nl = 0
            nr = 0
            for j = 0 to 4
               nl += brd[b][i * 5 + j + 1]
               nr += brd[b][j * 5 + i + 1]
            .
            if nl = -5 or nr = -5
               done[b] = 1
               n_done += 1
               if n_done = 1 or n_done = len brd[][]
                  sum = 0
                  for m in brd[b][]
                     sum += m * if m <> -1
                  .
                  print numb * sum
               .
               break 1
            .
         .
      .
   .
.
#
input_data
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
