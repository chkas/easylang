# AoC-24 - Day 2: Red-Nosed Reports
#
global in[] .
func check del .
   i = 2
   prev = in[1]
   if del = 1
      prev = in[2]
      i = 3
   elif del = 2
      i = 3
   .
   sgn = sign (in[i] - prev)
   if sgn = 0 : return 0
   repeat
      if i = del : i += 1
      until i > len in[]
      d = in[i] - prev
      if sign d <> sgn or abs d > 3 : return 0
      prev = in[i]
      i += 1
   .
   return 1
.
func check2 .
   if check 0 = 1 : return 1
   for i to len in[]
      if check i = 1 : return 1
   .
   return 0
.
repeat
   s$ = input
   until s$ = ""
   in[] = number strsplit s$ " "
   nsafe += check 0
   nsafe2 += check2
.
print nsafe
print nsafe2
#
input_data
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
