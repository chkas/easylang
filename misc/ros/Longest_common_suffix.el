func$ right s$ i .
   return substr s$ (len s$ - i + 1) i
.
func$ lcs list$[] .
   if len list$[] = 0
      return ""
   .
   ref$ = list$[1]
   for s$ in list$[]
      if len s$ < len ref$
         ref$ = s$
      .
   .
   for i = 1 to len ref$
      sub$ = right ref$ i
      for s$ in list$[]
         if right s$ i <> sub$
            return right ref$ (i - 1)
         .
      .
   .
   return ref$
.
print lcs [ "Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" ]
print lcs [ "throne" "throne" ]
print lcs [ "throne" "dungeon" ]
print lcs [ "cheese" ]
print lcs [ "prefix" "suffix" ]
