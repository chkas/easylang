sysconf zero_based
func$ b2s i vars .
   for k to vars
      if i mod 2 = 1
         s$ = "1" & s$
      else
         s$ = "0" & s$
      .
      i = i div 2
   .
   return s$
.
func bitCount s$ .
   for c$ in strchars s$ : if c$ = "1" : cnt += 1
   return cnt
.
func$ merge i$ j$ .
   lng = lower len i$ len j$
   i$[] = strchars i$
   j$[] = strchars j$
   for k range0 lng
      a$ = i$[k]
      b$ = j$[k]
      if a$ = "X" or b$ = "X"
         if a$ <> b$ : return ""
         s$ &= a$
      elif a$ <> b$
         difCnt += 1
         if difCnt > 1 : return ""
         s$ &= "X"
      else
         s$ &= a$
      .
   .
   return s$
.
proc addToSet &s$[] item$ .
   for str$ in s$[] : if str$ = item$ : return
   s$[] &= item$
.
func inSet &s$[] item$ .
   for str$ in s$[] : if str$ = item$ : return 1
   return 0
.
proc unionSets &dest$[] &src$[] .
   for item$ in src$[] : addToSet dest$[] item$
.
proc computePrimes &cubes$[] vars &primes$[] .
   len sigma$[][] vars + 1
   for j = 0 to vars
      for cube$ in cubes$[]
         if bitCount cube$ = j : addToSet sigma$[j][] cube$
         if len sigma$[j][] > 0 : sigmaCount = j + 1
      .
   .
   while sigmaCount > 0
      len nsigma$[][] sigmaCount - 1
      for i range0 sigmaCount - 1
         nc$[] = [ ]
         for a$ in sigma$[i][]
            for b$ in sigma$[i + 1][]
               m$ = merge a$ b$
               if m$ <> ""
                  addToSet nc$[] m$
                  addToSet redundant$[] a$
                  addToSet redundant$[] b$
               .
            .
         .
         swap nsigma$[i][] nc$[]
      .
      for i range0 sigmaCount
         for cube$ in sigma$[i][]
            if inSet redundant$[] cube$ = 0 : addToSet primes$[] cube$
         .
      .
      sigmaCount = len nsigma$[][]
      if sigmaCount > 0
         for i range0 sigmaCount
            swap sigma$[i][] nsigma$[i][]
         .
      .
   .
.
proc activePrimes cubesel &primes$[] &result$[] .
   result$[] = [ ]
   s$[] = strchars b2s cubesel len primes$[]
   for i range0 len primes$[]
      if s$[i] = "1" : addToSet result$[] primes$[i]
   .
.
func isCover prime$ one$ .
   length = lower len prime$ len one$
   prime$[] = strchars prime$
   one$[] = strchars one$
   for i range0 length
      if prime$[i] <> "X" and prime$[i] <> one$[i] : return 0
   .
   return 1
.
func isFullCover &allPrimes$[] &ones$[] .
   for one$ in ones$[]
      covered = 0
      for prime$ in allPrimes$[]
         if isCover prime$ one$ = 1
            covered = 1
            break 1
         .
      .
      if covered = 0 : return 0
   .
   return 1
.
proc unateCover &primes$[] &ones$[] &result$[] .
   minCount = 1000
   minSel = -1
   total = bitshift 1 len primes$[]
   for cubesel range0 total
      activePrimes cubesel primes$[] active$[]
      if isFullCover active$[] ones$[] = 1
         cnt = 0
         binRep$ = b2s cubesel len primes$[]
         for c$ in strchars binRep$
            if c$ = "1" : cnt += 1
         .
         if cnt < minCount
            minCount = cnt
            minSel = cubesel
         .
      .
   .
   if minSel <> -1
      activePrimes minSel primes$[] result$[]
   else
      result$[] = [ ]
   .
.
func$[] qm &ones[] &zeros[] &dc[] .
   if ones[] = [ ] and zeros[] = [ ] and dc[] = [ ]
      return [ ]
   .
   for val in ones[] : maxVal = higher val maxVal
   for val in zeros[] : maxVal = higher val maxVal
   for val in dc[] : maxVal = higher val maxVal
   if maxVal = 0
      numvars = 1
   else
      while maxVal > 0
         numvars += 1
         maxVal = maxVal div 2
      .
   .
   for val in ones[] : addToSet onesSet$[] b2s val numvars
   for val in zeros[] : addToSet zerosSet$[] b2s val numvars
   for val in dc[] : addToSet dcSet$[] b2s val numvars
   unionSets cubes$[] onesSet$[]
   unionSets cubes$[] dcSet$[]
   computePrimes cubes$[] numvars primes$[]
   unateCover primes$[] onesSet$[] result$[]
   return result$[]
.
proc main .
   ones[] = [ 1 2 5 ]
   zeros[] = [ ]
   dc[] = [ 0 7 ]
   result$[] = qm ones[] zeros[] dc[]
   print strjoin result$[] " "
.
main
