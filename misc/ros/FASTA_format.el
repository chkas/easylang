repeat
   s$ = input
   until s$ = ""
   if substr s$ 1 1 = ">"
      if stat = 1
         print ""
      .
      stat = 1
      print s$
   else
      write s$
   .
. 
input_data
>Rosetta_Example_1
THERECANBENOSPACE
>Rosetta_Example_2
THERECANBESEVERAL
LINESBUTTHEYALLMUST
BECONCATENATED
