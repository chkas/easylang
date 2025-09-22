funcdecl[] tryperm i pos &seq[] n minlen .
func[] checkseq pos &seq[] n minlen .
   if pos > minlen or seq[$] > n : return [ minlen 0 ]
   if seq[$] = n : return [ pos 1 ]
   if pos < minlen : return tryperm 0 pos seq[] n minlen
   return [ minlen 0 ]
.
func[] tryperm i pos &seq[] n minlen .
   if i > pos : return [ minlen 0 ]
   seq[] &= seq[$] + seq[$ - i]
   res1[] = checkseq (pos + 1) seq[] n minlen
   len seq[] -1
   res2[] = tryperm (i + 1) pos seq[] n res1[1]
   if res2[1] < res1[1] : return res2[]
   if res2[1] = res1[1] : return [ res2[1] res1[2] + res2[2] ]
   print "tryperm error"
.
proc brauer num .
   seq1[] = [ 1 ]
   print "N = " & num
   res[] = tryperm 0 0 seq1[] num 12
   print "Minimum length of chains: L(n)= " & res[1]
   print "Number of minimum length Brauer chains: " & res[2]
   print ""
.
for i in [ 7 14 21 29 32 42 64 47 79 191 382 379 ]
   brauer i
.
