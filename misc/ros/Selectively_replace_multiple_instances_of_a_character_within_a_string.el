rs$[] = [ "a" "b" "r" ]
rc[][] = [ [ 1 2 4 5 ] [ 1 ] [ 2 ] ]
rd$[][] = [ [ "A" "B" "C" "D" ] [ "E" ] [ "F" ] ]
s$ = "abracadabra"
# 
len cnt[] len rs$[]
for c$ in strchars s$
   for i to len rs$[]
      if c$ = rs$[i]
         cnt[i] += 1
         for j to len rc[i][]
            if rc[i][j] = cnt[i]
               c$ = rd$[i][j]
            .
         .
      .
   .
   r$ &= c$
.
print r$
