func fac n .
   f = 1
   for i to n : f *= i
   return f
.
global elements[] nperm permb perma .
proc perminit a b .
   perma = a
   permb = b
   elements[] = [ ]
   for i to a : elements[] &= i - 1
   nperm = fac a / fac b
.
func[] getperm r .
   digs[] = elements[]
   fa = nperm
   for i = perma downto 1 + permb
      fa /= i
      d = r div fa + 1
      r = r mod fa
      r[] &= digs[d]
      for j = d to i - 1
         digs[j] = digs[j + 1]
      .
   .
   return r[]
.
proc sendmore .
   perminit 10 2
   for p range0 nperm
      r[] = getperm p
      if r[1] <> 0 and r[5] <> 0
         send = 0
         for i to 4
            send = 10 * send + r[i]
         .
         more = 0
         for i = 5 to 7
            more = 10 * more + r[i]
         .
         more = 10 * more + r[2]
         money = more div 100
         money = 10 * money + r[3]
         money = 10 * money + r[2]
         money = 10 * money + r[8]
         if send + more = money
            print send & " + " & more & " = " & money
         .
      .
   .
.
sendmore
