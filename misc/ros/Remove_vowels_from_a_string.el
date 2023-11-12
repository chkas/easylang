func$ rmv s$ .
   for c$ in strchars s$
      for v$ in strchars "AEIOUaeiou"
         if c$ = v$
            c$ = ""
         .
      .
      r$ &= c$
   .
   return r$
.
print rmv "The Quick Brown Fox Jumped Over the Lazy Dog's Back"
