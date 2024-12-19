# AoC-17 - Day 2: Corruption Checksum
#
repeat
   s$ = input
   until s$ = ""
   a$[] = strtok s$ "\t "
   min = 1 / 0
   max = 0
   for i to len a$[]
      h = number a$[i]
      min = lower min h
      max = higher max h
      for j to len a$[]
         h2 = number a$[j]
         if i <> j and h mod h2 = 0
            cs2 += h div h2
         .
      .
   .
   cs1 += max - min
.
print cs1
print cs2
#
input_data
5 1 9 5
7 5 3
2 4 6 8
5 9 2 8
9 4 7 3
3 8 6 5


