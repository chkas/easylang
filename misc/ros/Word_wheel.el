letters$ = "ndeokgelw"
mid$ = substr letters$ 5 1
# 
func count word$ c$ .
   for h$ in strchars word$
      cnt += if h$ = c$
   .
   return cnt
.
repeat
   word$ = input
   until word$ = ""
   if len word$ >= 3 and len word$ <= 9 and strpos word$ mid$ <> 0
      hits = 0
      for c$ in strchars word$
         if strpos letters$ c$ <> 0
            hits += 1
         .
      .
      if len word$ = hits and hits >= 3
         c$ = ""
         for c$ in strchars word$
            if count word$ c$ > count letters$ c$
               break 1
            .
         .
         if c$ = ""
            write word$ & " "
         .
      .
   .
.
# 
# the content of unixdict.txt 
input_data
10th
eke
keg
kong
week