func$ rlenc in$ .
   for c$ in strchars in$
      if c$ = c0$
         cnt += 1
      else
         if cnt > 0
            out$ &= cnt & c0$ & " "
         .
         c0$ = c$
         cnt = 1
      .
   .
   out$ &= cnt & c0$
   return out$
.
func$ rldec in$ .
   for h$ in strsplit in$ " "
      c$ = substr h$ len h$ 1
      for i to number h$
         out$ &= c$
      .
   .
   return out$
.
s$ = input
print s$
s$ = rlenc s$
print s$
s$ = rldec s$
print s$
# 
input_data
WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW
