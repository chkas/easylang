func$ rot13 str$ .
   for c$ in strchars str$
      c = strcode c$
      if c >= 65 and c <= 90
         c = (c + 13 - 65) mod 26 + 65
      elif c >= 97 and c <= 122
         c = (c + 13 - 97) mod 26 + 97
      .
      enc$ &= strchar c
   .
   return enc$
.
enc$ = rot13 "Rosetta Code"
print enc$
print rot13 enc$
