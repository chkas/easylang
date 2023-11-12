func dist s1$ s2$ .
   if len s1$ = 0
      return len s2$
   .
   if len s2$ = 0
      return len s1$
   .
   c1$ = substr s1$ 1 1
   c2$ = substr s2$ 1 1
   s1rest$ = substr s1$ 2 len s1$
   s2rest$ = substr s2$ 2 len s2$
   # 
   if c1$ = c2$
      return dist s1rest$ s2rest$
   .
   min = lower dist s1rest$ s2rest$ dist s1$ s2rest$
   min = lower min dist s1rest$ s2rest$
   return min + 1
.
print dist "kitten" "sitting"
print dist "rosettacode" "raisethysword"
