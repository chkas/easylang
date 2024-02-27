proc conj inf$ . .
   if substr inf$ -3 3 <> "are"
      print "Not a first conjugation verb."
      return
   .
   stem$ = substr inf$ 1 (len inf$ - 3)
   if stem$ = ""
      print "Stem cannot be empty."
      return
   .
   print "Present indicative tense of " & inf$ & ":"
   for en$ in [ "o" "as" "at" "amus" "atis" "ant" ]
      print stem$ & en$
   .
.
for s$ in [ "amare" "dare" ]
   conj s$
   print ""
.
