codes$[] = [ "AAAAA", "AAAAB", "AAABA", "AAABB", "AABAA", "AABAB", "AABBA", "AABBB", "ABAAA", "ABAAB", "ABABA", "ABABB", "ABBAA", "ABBAB", "ABBBA", "ABBBB", "BAAAA", "BAAAB", "BAABA", "BAABB", "BABAA", "BABAB", "BABBA", "BABBB", "BBAAA", "BBAAB", "BBBAA" ]
func$ getcode c$ .
   c = strcode c$
   if c >= 97 and c <= 122 : return codes$[c - 96]
   return codes$[27]
.
func$ getchar code$ .
   if codes$[27] = code$ : return " "
   for i to 26
      if codes$[i] = code$ : return strchar (i + 96)
   .
   print "invalid: " & code$
.
proc strtolower &s$ .
   for c$ in strchars s$
      c = strcode c$
      if c >= 65 and c <= 90
         c += 32
         c$ = strchar c
      .
      r$ &= c$
   .
   swap r$ s$
.
func$ bacon_enc plain$ msg$ .
   strtolower plain$
   for c$ in strchars plain$
      et$ &= getcode c$
   .
   strtolower msg$
   cnt = 1
   for c$ in strchars msg$
      c = strcode c$
      if c >= 97 and c <= 122
         if substr et$ cnt 1 = "A"
            mt$ &= c$
         else
            mt$ &= strchar (c - 32)
         .
         cnt += 1
         if cnt > 5 * len plain$ : break 1
      else
         mt$ &= c$
      .
   .
   return mt$
.
func$ bacon_dec cipher$ .
   for c$ in strchars cipher$
      c = strcode c$
      if c >= 97 and c <= 122
         ct$ &= "A"
      elif c >= 65 and c <= 90
         ct$ &= "B"
      .
   .
   for i = 1 step 5 to len ct$
      quint$ = substr ct$ i 5
      pt$ &= getchar quint$
   .
   return pt$
.
plain$ = "the quick brown fox jumps over the lazy dog"
msg$ = "bacon's cipher is a method of steganography created by francis bacon."
msg$ &= "this task is to implement a program for encryption and decryption of "
msg$ &= "plaintext using the simple alphabet of the baconian cipher or some "
msg$ &= "other kind of representation of this alphabet (make anything signify anything). "
msg$ &= "the baconian alphabet may optionally be extended to encode all lower "
msg$ &= "case characters individually and/or adding a few punctuation characters "
msg$ &= "such as the space."
cipher$ = bacon_enc plain$ msg$
print cipher$
print ""
hidden$ = bacon_dec cipher$
print hidden$
