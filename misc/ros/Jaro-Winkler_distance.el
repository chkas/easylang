repeat
   s$ = input
   until s$ = ""
   words$[] &= s$
.
func distance s1$ s2$ .
   if len s1$ < len s2$
      swap s1$ s2$
   .
   s1$[] = strchars s1$
   s2$[] = strchars s2$
   len1 = len s1$[]
   len2 = len s2$[]
   if len2 = 0
      return 0
   .
   delta = higher 0 (len1 div 2 - 1)
   len flag[] len2
   for i to len1
      c1$ = s1$[i]
      for j to len2
         c2$ = s2$[j]
         if j <= i + delta and j >= i - delta and c1$ = c2$ and flag[j] = 0
            flag[j] = 1
            c1_match$[] &= c1$
            break 1
         .
      .
   .
   m = len c1_match$[]
   if m = 0
      return 1
   .
   i = 0
   for j to len2
      if flag[j] = 1
         i += 1
         transpos += if s2$[j] <> c1_match$[i]
      .
   .
   jaro = (m / len1 + m / len2 + (m - transpos / 2) / m) / 3
   for i = 1 to lower len2 4
      comprefix += if s1$[i] = s2$[i]
   .
   return 1 - (jaro + comprefix * 0.1 * (1 - jaro))
.
proc sort . d[] d$[] .
   for i = len d[] - 1 downto 1
      for j = 1 to i
         if d[j] > d[j + 1]
            swap d[j] d[j + 1]
            swap d$[j] d$[j + 1]
         .
      .
   .
.
proc closewords s$ maxdist . r$[] r[] .
   r[] = [ ]
   r$[] = [ ]
   for w$ in words$[]
      jw = distance s$ w$
      if jw <= maxdist
         r$[] &= w$
         r[] &= jw
         sort r[] r$[]
      .
   .
.
for s$ in [ "accomodate" "definately" "goverment" "occured" "publically" "recieve" "seperate" "untill" "wich" ]
   print s$ & " ->"
   closewords s$ 0.15 r$[] r[]
   for i to lower 5 len r$[]
      print r[i] & " " & r$[i]
   .
   print ""
.
# the content of unixdict.txt 
input_data
10th
accommodate
accordant
till
until