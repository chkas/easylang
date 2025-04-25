# AoC-24 - Day 21: Keypad Conundrum
#
proc movex &sx &dx &r[] .
   dirx = sign (dx - sx)
   k = 3
   if dirx = 1 : k = 5
   while sx <> dx
      r[] &= k
      sx += dirx
   .
.
proc movey &sy &dy &r[] .
   diry = sign (dy - sy)
   k = 1
   if diry = 1 : k = 4
   while sy <> dy
      r[] &= k
      sy += diry
   .
.
proc keypad dir src dst &r[] .
   dx = dst mod 3
   sx = src mod 3
   dy = dst div 3
   sy = src div 3
   if dir = 1
      movex sx dx r[]
      movey sy dy r[]
   elif dir = 2
      movey sy dy r[]
      movex sx dx r[]
   .
   r[] &= 2
.
# +---+---+---+
# | 7 | 8 | 9 |   0 1 2
# +---+---+---+
# | 4 | 5 | 6 |   3 4 5
# +---+---+---+
# | 1 | 2 | 3 |   6 7 8
# +---+---+---+
#     | 0 | A |   9 10 11
#     +---+---+
#
proc numkeypad keys$ &sq[] .
   a = 11
   for k$ in strchars keys$
      b = strpos "789456123x0A" k$ - 1
      dy = b div 3
      dx = b mod 3
      sy = a div 3
      sx = a mod 3
      #
      if dx = 0 and sy = 3
         keypad 2 a b sq[]
      elif dy = 3 and sx = 0
         keypad 1 a b sq[]
         #
      elif dx > sx
         keypad 2 a b sq[]
      else
         keypad 1 a b sq[]
      .
      a = b
   .
.
#     +---+---+
#     | ^ | A |  0 1 2
# +---+---+---+
# | < | v | > |  3 4 5
# +---+---+---+
#
proc dirkeypad &sq[] .
   swap sqin[] sq[]
   a = 2
   for b in sqin[]
      if a = 3
         keypad 1 a b sq[]
      elif b = 3
         keypad 2 a b sq[]
         #
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
func sq2cod sq[] .
   for i to len sq[] : ind = ind * 6 + sq[i]
   return ind + 1
.
func[] cod2sq ind .
   ind -= 1
   while ind > 0
      r[] &= ind mod 6
      ind = ind div 6
   .
   for i to len r[] div 2 : swap r[i] r[$ - 1 + 1]
   return r[]
.
#
len tbnxt[][] 212
len tblen[] 212
#
proc findchilds cod .
   if len tbnxt[cod][] > 0 : return
   sq[] = cod2sq cod
   sq[] &= 2
   tblen[cod] = len sq[]
   dirkeypad sq[]
   i = 1
   repeat
      s[] = [ ]
      while sq[i] <> 2
         s[] &= sq[i]
         i += 1
      .
      tbnxt[cod][] &= sq2cod s[]
      until i = len sq[]
      i += 1
   .
   for h in tbnxt[cod][] : findchilds h
.
proc seq2codes &sq[] &codes[] .
   i = 1
   repeat
      s[] = [ ]
      while sq[i] <> 2
         s[] &= sq[i]
         i += 1
      .
      h = sq2cod s[]
      codes[] &= h
      i += 1
      until i > len sq[]
   .
.
proc inittbl sq[] .
   seq2codes sq[] codes[]
   for cod in codes[]
      findchilds cod
   .
.
proc nextrobot &cnt[] .
   len ncnt[] len cnt[]
   for i = 1 to len cnt[]
      if cnt[i] > 0
         if len tbnxt[i][] = 0 : print "error"
         for h in tbnxt[i][]
            ncnt[h] += cnt[i]
         .
      .
   .
   swap cnt[] ncnt[]
.
func cntsum sqcnt[] .
   for j to len sqcnt[]
      s += sqcnt[j] * tblen[j]
   .
   return s
.
#
proc dokeys keys$ &nbtn1 &nbtn2 .
   numkeypad keys$ sq[]
   dirkeypad sq[]
   inittbl sq[]
   len sqcnt[] 212
   seq2codes sq[] codes[]
   for cod in codes[] : sqcnt[cod] += 1
   nextrobot sqcnt[]
   nbtn1 = cntsum sqcnt[]
   for j to 23 : nextrobot sqcnt[]
   nbtn2 = cntsum sqcnt[]
.
#
proc run .
   repeat
      s$ = input
      until s$ = ""
      dokeys s$ nbtn1 nbtn2
      sum1 += nbtn1 * number s$
      sum2 += nbtn2 * number s$
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
