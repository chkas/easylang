# AoC-16 - Day 3: Squares With Three Sides
# 
repeat
   s$ = input
   until s$ = ""
   s$[] &= s$
.
subr count
   sum = 0
   lin = 1
   while lin <= len s$[]
      len d[] 3
      for i to 3
         if part2 = 1
            d[i] = number substr s$[lin + i - 1] col * 5 + 1 5
         else
            d[i] = number substr s$[lin] i * 5 - 4 5
         .
      .
      if part2 = 1
         col += 1
         if col = 4
            col = 0
            lin += 3
         .
      else
         lin += 1
      .
      if d[2] > d[1]
         swap d[2] d[1]
      .
      if d[3] > d[1]
         swap d[3] d[1]
      .
      if d[1] < d[2] + d[3]
         sum += 1
      .
   .
   print sum
.
count
part2 = 1
count
# 
input_data
  101  301  501
  102  302  502
  103  303  503
  201  401  601
  202  402  602
  203  403  603


