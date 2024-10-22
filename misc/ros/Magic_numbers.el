func[] bnmul a[] b .
   for d in a[]
      h = c + d * b
      r[] &= h mod 10000000
      c = h div 10000000
   .
   if c > 0
      r[] &= c
   .
   return r[]
.
func bnmod a[] b .
   for ia = len a[] downto 1
      m = (m * 10000000 + a[ia]) mod b
   .
   return m
.
func$ str bn[] .
   s$ = bn[$]
   for i = len bn[] - 1 downto 1
      h$ = bn[i]
      s$ &= substr "0000000" 1 (7 - len h$) & h$
   .
   return s$
.
func bnlen bn[] .
   if bn[] = [ 0 ]
      return 1
   .
   return (len bn[] - 1) * 7 + floor log10 bn[$] + 1
.
global mn[][] .
proc getmagnums . .
   i = 1
   n[] = [ 0 ]
   repeat
      l = bnlen n[]
      for dig = (l - bnmod n[] l) mod l step l to 9
         mn[][] &= n[]
         mn[$][1] += dig
      .
      i += 1
      until i = len mn[][]
      n[] = bnmul mn[i][] 10
   .
.
getmagnums
# 
proc show . .
   print len mn[][] & " magic numbers"
   print str mn[$][] & " is the largest"
   len ndigs[] 25
   min = 1 / 0
   for mi to len mn[][]
      n[] = mn[mi][]
      ndig = bnlen n[]
      ndigs[ndig] += 1
      if ndig = 9
         s$ = str n[]
         for i = 1 to 9
            if strpos s$ i = 0
               s$ = "999999999"
            .
         .
         min = lower min number s$
      .
   .
   print "count by number of digits:"
   for i to len ndigs[]
      write i & ":" & ndigs[i] & " "
   .
   print ""
   print min & " is minimal pandigital in 1..9"
   print min & 0 & " is minimal pandigital in 0..9"
.
show
