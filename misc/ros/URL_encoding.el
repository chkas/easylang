func$ tohex h .
   for c in [ h div 16 h mod 16 ]
      c += 48
      if c >= 58 : c += 7
      r$ &= strchar c
   .
   return r$
.
func[] utf8enc s$ .
   for c$ in strchars s$
      c = strcode c$
      if c < 0x80
         cnt = 0
         pre = 0
      elif c < 0x800
         cnt = 1
         pre = 0xc0
      elif c < 0x10000
         cnt = 2
         pre = 0xe0
      elif c < 0x200000
         cnt = 3
         pre = 0xf0
      else
         return [ ]
      .
      for i to cnt + 1 : r[] &= 0
      for i = 0 to cnt - 1
         l = c mod 0x40 + 0x80
         c = c div 0x40
         r[$ - i] = l
      .
      r[$ - i] = c + pre
   .
   return r[]
.
func$ urlenc s$ .
   b[] = utf8enc s$
   if b[] = [ ] : return ""
   for b in b[]
      if b >= 48 and b <= 57 or b >= 65 and b <= 90 or b >= 97 and b <= 122
         r$ &= strchar b
      else
         r$ &= "%" & tohex b
      .
   .
   return r$
.
print urlenc "https://bn.wikipedia.org/wiki/রোসেটা_কোড"
