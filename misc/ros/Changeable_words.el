repeat
   s$ = input
   until s$ = ""
   if len s$ > 11
      w$[] &= s$
   .
.
func hammingdist w1$ w2$ .
   if len w1$ <> len w2$
      return 0
   .
   for i to len w1$
      if substr w1$ i 1 <> substr w2$ i 1
         cnt += 1
         if cnt = 2
            break 1
         .
      .
   .
   return cnt
.
for i to len w$[]
   for j = i + 1 to len w$[]
      if hammingdist w$[i] w$[j] = 1
         print w$[i] & " <-> " & w$[j]
      .
   .
.
# the content of unixdict.txt 
input_data
10th
.
confirmation
conformation
.
