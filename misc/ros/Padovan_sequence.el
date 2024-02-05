p[] = [ 1 1 1 ]
padorn = 1
func padorec .
   if padorn <= 3
      h = p[padorn]
   else
      h = p[1] + p[2]
   .
   p[1] = p[2]
   p[2] = p[3]
   p[3] = h
   padorn += 1
   return h
.
pfn = 1
P = 1.32471795724474602596
S = 1.0453567932525329623
# 
func padofloor .
   p = floor ((pow P (pfn - 2)) / S + 0.5)
   pfn += 1
   return p
.
str$ = "A"
func$ padolsys .
   r$ = str$
   for c$ in strchars str$
      if c$ = "A"
         nxt$ &= "B"
      elif c$ = "B"
         nxt$ &= "C"
      else
         nxt$ &= "AB"
      .
   .
   str$ = nxt$
   return r$
.
# 
print "First 20 terms of the Padovan sequence:"
for i to 64
   par[] &= padorec
.
for i to 20
   write par[i] & " "
.
print ""
for i to 64
   paf[] &= padofloor
.
if par[] = paf[]
   print "\nRecurrence and floor functions agree for first 64 terms"
.
for i to 32
   pal$[] &= padolsys
.
print "\nFirst 10 strings produced from the L-system:"
for i to 10
   write pal$[i] & " "
.
print ""
for i to 32
   if len pal$[i] <> par[i]
      break 1
   .
.
if i > 32
   print "\nLength of first 32 strings produced from the L-system = Padovan sequence"
.
