minDelta = 1
func getMaxPrice &prices[] .
   max = -1 / 0
   for p in prices[] : max = higher max p
   return max
.
func getPRangeCount &prices[] min max .
   for p in prices[]
      if p >= min and p <= max : count += 1
   .
   return count
.
func[] get5000 &prices[] min max n .
   count = getPRangeCount prices[] min max
   delta = (max - min) / 2
   while count <> n and delta >= minDelta / 2
      if count > n
         max -= delta
      else
         max += delta
      .
      max = floor max
      count = getPRangeCount prices[] min max
      delta /= 2
   .
   return [ max count ]
.
func[][] getAll5000 &prices[] min max n .
   r[] = get5000 prices[] min max n
   pmax = r[1]
   pcount = r[2]
   res[][] &= [ min pmax pcount ]
   while pmax < max
      pmin = pmax + 1
      r[] = get5000 prices[] pmin max n
      pmax = r[1]
      if r[2] = 0
         print "Price list from " & pmin & " has too many with same price."
      .
      res[][] &= [ pmin pmax r[2] ]
   .
   return res[][]
.
proc main .
   numPrices = 99000 + random 2001 - 1
   for i to numPrices : prices[] &= random 100001 - 1
   actualMax = getMaxPrice prices[]
   print "Using " & numPrices & " items with prices from 0 to " & actualMax & ":"
   res[][] = getAll5000 prices[] 0 actualMax 5000
   print "Split into " & len res[][] & " bins of approx 5000 elements:"
   for r[] in res[][]
      min = r[1]
      tmx = r[2]
      tmx = lower tmx actualMax
      max = floor tmx
      cnt = r[3]
      total += cnt
      print "   From " & min & " to " & max & " with " & cnt & " items"
   .
   if total <> numPrices : print "Whoops! Some items missing!"
.
main
