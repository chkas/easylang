# use array of array for this
proc hashGet ind$ . ar$[][] item$ .
   for i to len ar$[][]
      if ar$[i][1] = ind$
         item$ = ar$[i][2]
         return
      .
   .
   item$ = ""
.
proc hashSet ind$ val$ . ar$[][] .
   for i to len ar$[][]
      if ar$[i][1] = ind$
         ar$[i][2] = val$
         return
      .
   .
   ar$[][] &= [ ind$ val$ ]
.
clothing$[][] = [ [ "type" "t-shirt" ] [ "color" "red" ] ]
clothing$[][] &= [ "size" "xl" ]
# 
hashSet "color" "green" clothing$[][]
hashGet "color" clothing$[][] col$
print col$
