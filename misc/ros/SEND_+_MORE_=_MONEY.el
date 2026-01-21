global elements[] nperm perma permb digs[] perm[] .
fastproc mkperm p .
   fa = nperm
   ind = 1
   for i = perma downto permb + 1
      fa /= i
      d = p div fa + 1
      p = p mod fa
      perm[ind] = digs[d]
      for j = d to i - 1
         digs[j] = digs[j + 1]
      .
      ind += 1
   .
.
proc perminit a b .
   perma = a
   permb = b
   len perm[] a - b
   elements[] = [ ]
   for i to a : elements[] &= i - 1
   nperm = 1
   for i = a downto b + 1
      nperm *= i
   .
.
proc test .
   if perm[1] = 0 or perm[5] = 0 : return
   for i to 4
      send = 10 * send + perm[i]
   .
   for i = 5 to 7
      more = 10 * more + perm[i]
   .
   more = 10 * more + perm[2]
   money = more div 100
   money = 10 * money + perm[3]
   money = 10 * money + perm[2]
   money = 10 * money + perm[8]
   if send + more = money
      print send & " + " & more & " = " & money
   .
.
proc sendmore .
   perminit 10 2
   for p range0 nperm
      digs[] = elements[]
      mkperm p
      test
   .
.
sendmore
