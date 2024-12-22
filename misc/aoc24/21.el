# AoC-24 - Day 21: Keypad Conundrum
#
proc keypad dir src dst . r[] .
   subr gox
      dx = dst mod 3
      sx = src mod 3
      dirx = sign (dx - sx)
      k = 3
      if dirx = 1 : k = 5
      while sx <> dx
         r[] &= k
         sx += dirx
      .
   .
   subr goy
      dy = dst div 3
      sy = src div 3
      diry = sign (dy - sy)
      k = 1
      if diry = 1 : k = 4
      while sy <> dy
         r[] &= k
         sy += diry
      .
   .
   if dir = 1
      gox
      goy
   elif dir = 2
      goy
      gox
   .
   r[] &= 2
.
proc dirkeypad . sq[] .
   swap sqin[] sq[]
   a = 2
   for b in sqin[]
      if a = 3
         keypad 1 a b sq[]
      elif b = 3
         keypad 2 a b sq[]
      elif a = 1
         keypad 2 a b sq[]
      elif a = 4
         keypad 2 a b sq[]
      else
         keypad 1 a b sq[]
      .
      a = b
   .
.
func sq2ind sq[] .
   for i to len sq[] : ind = ind * 6 + sq[i]
   return ind + 1
.
func[] ind2sq ind .
   ind -= 1
   while ind > 0
      r[] &= ind mod 6
      ind = ind div 6
   .
   for i to len r[] div 2 : swap r[i] r[$ - 1 + 1]
   return r[]
.
#
len tblnxt[][] 212
len tbll[] 212
#
proc initnumsq ind . .
   if len tblnxt[ind][] > 0 : return
   sq[] = ind2sq ind
   sq[] &= 2
   tbll[ind] = len sq[]
   dirkeypad sq[]
   i = 1
   repeat
      s[] = [ ]
      while sq[i] <> 2
         s[] &= sq[i]
         i += 1
      .
      tblnxt[ind][] &= sq2ind s[]
      until i = len sq[]
      i += 1
   .
   for h in tblnxt[ind][] : initnumsq h
.
proc inittbl sq[] . cnt[] .
   i = 1
   cnt[] = [ ]
   len cnt[] 212
   repeat
      s[] = [ ]
      while sq[i] <> 2
         s[] &= sq[i]
         i += 1
      .
      h = sq2ind s[]
      initnumsq sq2ind s[]
      cnt[h] += 1
      i += 1
      until i > len sq[]
   .
.
proc doclick . cnt[] .
   len ncnt[] len cnt[]
   for i = 1 to len cnt[]
      if cnt[i] > 0
         if len tblnxt[i][] = 0 : print "error"
         for h in tblnxt[i][]
            ncnt[h] += cnt[i]
         .
      .
   .
   swap cnt[] ncnt[]
.
func cntsum sqcnt[] .
   for j to len sqcnt[]
      s += sqcnt[j] * tbll[j]
   .
   return s
.
#
proc docode code$ . r1 r2 .
   keyb1$ = "789456123x0A"
   a = 11
   for k$ in strchars code$
      b = strpos keyb1$ k$ - 1
      dy = b div 3
      dx = b mod 3
      sy = a div 3
      sx = a mod 3
      #
      if dx = 0 and sy = 3
         keypad 2 a b sq[]
      elif dy = 3 and sx = 0
         keypad 1 a b sq[]
      elif dx > sx
         keypad 2 a b sq[]
      else
         keypad 1 a b sq[]
      .
      a = b
   .
   dirkeypad sq[]
   inittbl sq[] sqcnt[]
   doclick sqcnt[]
   r1 = cntsum sqcnt[]
   for j to 23 : doclick sqcnt[]
   r2 = cntsum sqcnt[]
.
#
proc run . .
   repeat
      s$ = input
      until s$ = ""
      docode s$ s1 s2
      sum1 += s1 * number s$
      sum2 += s2 * number s$
   .
   print sum1
   print sum2
.
run
#
input_data
029A
980A
179A
456A
379A

