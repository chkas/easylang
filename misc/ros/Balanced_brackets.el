func balanced code$ .
   for i to len code$
      h$ = substr code$ i 1
      if h$ = "["
         br += 1
      elif h$ = "]"
         br -= 1
      .
      if br < 0
         return 0
      .
   .
   return if br = 0
.
repeat
   inp$ = input
   until inp$ = "eof"
   print inp$ & "\t" & balanced inp$
.
# 
input_data

[]   
[][]   
[[][]] 
][
][][
[]][[]
eof
