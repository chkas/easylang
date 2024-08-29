# order unimportant
func choices coins[] tgt cdx .
   if tgt = 0
      return 1
   .
   if tgt > 0 and cdx <= len coins[]
      count = choices coins[] (tgt - coins[cdx]) (cdx + 1)
      count += choices coins[] tgt (cdx + 1)
   .
   return count
.
print choices [ 1 2 3 4 5 ] 6 1
print choices [ 1 1 2 3 3 4 5 ] 6 1
print choices [ 1 2 3 4 5 5 5 5 15 15 10 10 10 10 25 100 ] 40 1
