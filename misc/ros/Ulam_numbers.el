func getulam n .
   ulam[] = [ 1 2 ]
   i = 3
   repeat
      cnt = 0
      for x = 1 to len ulam[] - 1
         ux = ulam[x]
         for y = x + 1 to len ulam[]
            if ux + ulam[y] >= i
               if ux + ulam[y] > i
                  break 1
               .
               cnt += 1
               if cnt > 1
                  break 2
               .
            .
         .
      .
      if cnt = 1
         ulam[] &= i
      .
      until len ulam[] = n
      i += 1
   .
   return i
.
print getulam 100
