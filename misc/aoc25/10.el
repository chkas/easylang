# AoC-25 - 10: Factory
#
global sw[][] ldiag[] cntr[][] .
proc init .
   repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ " "
      ldiag = 0
      for i = len s$[1] - 1 downto 2
         ldiag *= 2
         ldiag += if substr s$[1] i 1 = "#"
      .
      ldiag[] &= ldiag
      sw[][] &= [ ]
      for i = 2 to len s$[] - 1
         h[] = number strtok s$[i] "(,)"
         sw = 0
         for v in h[]
            sw += pow 2 v
         .
         sw[$][] &= sw
      .
      cntr[][] &= number strtok s$[i] "{,}"
   .
.
init
#
global sw[] ok want res .
#
proc take cnt pos .
   if cnt = 0
      if res = want : ok = 1
      return
   .
   for i = pos to len sw[]
      res = bitxor sw[i] res
      take cnt - 1 i + 1
      res = bitxor sw[i] res
   .
.
proc part1 .
   for row = 1 to len ldiag[]
      want = ldiag[row]
      sw[] = sw[row][]
      for cnt = 1 to len sw[]
         res = 0
         ok = 0
         take cnt 1
         if ok = 1 : break 1
      .
      if ok = 0 : pr 99999
      sum += cnt
   .
   print sum
.
part1
#
proc gauss_ref a[][] b[] &u[][] &y[] &piv[] &free[] .
   free[] = [ ]
   piv[] = [ ]
   nrow = len a[][]
   ncol = len a[1][]
   eps = 1e-9
   u[][] = a[][]
   y[] = b[]
   i = 1
   for c = 1 to ncol
      if i <= nrow
         maxr = 0
         maxv = 0
         for r = i to nrow
            if abs u[r][c] > maxv
               maxv = abs u[r][c]
               maxr = r
            .
         .
         if maxv > eps
            if maxr <> i
               swap u[maxr][] u[i][]
               swap y[maxr] y[i]
            .
            piv[] &= c
            for r = i + 1 to nrow
               fn = u[r][c]
               fd = u[i][c]
               if abs fn > eps
                  for k = c to ncol
                     u[r][k] -= u[i][k] * fn / fd
                  .
                  y[r] -= y[i] * fn / fd
               .
            .
            i += 1
         .
      .
   .
   for r = 1 to nrow
      rownorm = 0
      for c = 1 to ncol : rownorm += abs u[r][c]
      if rownorm <= eps and abs y[r] > eps
         u[][] = [ ]
         return
      .
   .
   for c = 1 to ncol
      ispiv = 0
      for t = 1 to len piv[]
         if piv[t] = c : ispiv = 1
      .
      if ispiv = 0 : free[] &= c
   .
.
#
func isnat f .
   i = floor (f + 0.5)
   if abs (f - i) > 0.0001 : return 0
   if i < 0 : return 0
   return 1
.
func[] solve_with_free u[][] y[] piv[] free[] free_val[] .
   ncols = len u[1][]
   len x[] ncols
   m = len free[]
   for t = 1 to m
      x[free[t]] = free_val[t]
   .
   for t = len piv[] downto 1
      c = piv[t]
      rhs = y[t]
      for k = c + 1 to ncols
         rhs -= u[t][k] * x[k]
      .
      x[c] = rhs / u[t][c]
      # kc
      if isnat x[c] = 0 : return [ ]
   .
   return x[]
.
#
#
global min u0[][] y[] piv[] free[] fv1[] maxfree .
func round f .
   return floor (f + 0.5)
.
proc feedfree ind .
   if ind = 0
      x1[] = solve_with_free u0[][] y[] piv[] free[] fv1[]
      if len x1[] = 0 : return
      for v in x1[] : s += v
      if s < min : min = round s
      return
   .
   for i = ind + 1 to len fv1[] : sumfree += fv1[i]
   for i = 0 to maxfree
      if sumfree + i >= min : return
      fv1[ind] = i
      feedfree ind - 1
   .
.
#
global a0[][] b0[] .
for xind = 1 to len cntr[][]
   b0[] = cntr[xind][]
   a0[][] = [ ]
   len a0[][] len b0[]
   sw[] = sw[xind][]
   sz = len sw[]
   for i to len a0[][] : len a0[i][] sz
   for i to len sw[]
      sw = sw[i]
      h = 0
      while sw > 0
         h += 1
         if sw mod 2 = 1 : a0[h][i] = 1
         sw = sw div 2
      .
   .
   gauss_ref a0[][] b0[] u0[][] y[] piv[] free[]
   if len u0[][] = 0
      print "error"
      return
   .
   min = 1 / 0
   len fv1[] len free[]
   maxfree = 0
   for v in b0[] : maxfree = higher maxfree v
   feedfree len free[]
   sum += floor min
.
print sum
#
input_data
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
