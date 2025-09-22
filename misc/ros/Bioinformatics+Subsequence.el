func$ dnaseq n .
   s$[] = [ "A" "C" "G" "T" ]
   for i to n : r$ &= s$[random 4]
   return r$
.
func[] positions dna$ sub$ .
   lsub = len sub$
   for i to len dna$ - lsub + 1
      if substr dna$ i lsub = sub$ : r[] &= i
   .
   return r[]
.
dna$ = dnaseq 200
write "DNA sequence: "
print dna$
sub$ = dnaseq 3
print ""
print "DNA subsequence: " & sub$
print ""
pos[] = positions dna$ sub$
if len pos[] = 0
   print "Subsequence not found."
else
   print "Subsequence found at positions: " & pos[]
.
