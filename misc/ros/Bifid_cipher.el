func$ crypt enc msg$ key$ .
   key$[] = strchars key$
   n = len msg$
   for i to len msg$
      c$ = substr msg$ i 1
      for j to 25
         if c$ = key$[j]
            break 1
         .
      .
      j -= 1
      h[] &= j div 5
      h[] &= j mod 5
   .
   if enc = 1
      for i = 1 step 4 to 2 * n - 3
         j = h[i] * 5 + h[i + 2] + 1
         r$ &= key$[j]
      .
      for i = 2 step 4 to 2 * n - 2
         j = h[i] * 5 + h[i + 2] + 1
         r$ &= key$[j]
      .
   else
      for i = 1 to n
         j = h[i] * 5 + h[i + n] + 1
         r$ &= key$[j]
      .
   .
   return r$
.
func$ conv s$ .
   for e$ in strchars s$
      h = strcode e$
      if h >= 97
         h -= 32
      .
      if h >= 65 and h <= 91
         if h = 74
            h = 73
         .
         r$ &= strchar h
      .
   .
   return r$
.
func$ encr msg$ key$ .
   return crypt 1 conv msg$ key$
.
func$ decr msg$ key$ .
   return crypt 0 msg$ key$
.
key$ = "ABCDEFGHIKLMNOPQRSTUVWXYZ"
h$ = encr "ATTACKATDAWN" key$
print h$
print decr h$ key$
print ""
# 
key$ = "BGWKZQPNDSIOAXEFCLUMTHYVR"
h$ = encr "FLEEATONCE" key$
print h$
print decr h$ key$
print ""
h$ = encr "ATTACKATDAWN" key$
print h$
print decr h$ key$
print ""
# 
h$ = encr "The invasion will start on the first of January" key$
print h$
print decr h$ key$
