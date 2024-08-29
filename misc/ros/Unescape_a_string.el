func$ unescape val$ .
   subr tonum
      h$ = "0x"
      for ind = ind to ind + 3
         h$ &= val$[ind]
      .
      v = number h$
      if error = 1
         print "error: no hex number"
         return ""
      .
   .
   # 
   val$[] = strchars val$
   ind = 1
   while ind <= len val$[]
      c$ = val$[ind]
      ind += 1
      if c$ = "\\"
         if ind > len val$[]
            print "error: expected escape character"
            return ""
         .
         c$ = val$[ind]
         ind += 1
         if c$ = "\"" or c$ = "\\" or c$ = "/"
            r$ &= c$
         elif c$ = "b"
            r$ &= strchar 0x08
         elif c$ = "f"
            r$ &= strchar 0x0c
         elif c$ = "n"
            r$ &= "\n"
         elif c$ = "r"
            r$ &= strchar 0x0d
         elif c$ = "t"
            r$ &= strchar 0x09
         elif c$ = "u"
            if ind + 3 > len val$[]
               print "error: unexpected end"
               return ""
            .
            tonum
            if v >= 0xdc00 and v <= 0xdfff
               print "error: unexpected low surrogate code point"
               return ""
            .
            if v >= 0xd800 and v <= 0xdbff
               vh = v
               if ind + 6 > len val$[]
                  print "error: unexpected end"
                  return ""
               .
               if val$[ind] & val$[ind + 1] <> "\\u"
                  print "error: expected \\u"
                  return ""
               .
               ind += 2
               tonum
               if not (v >= 0xdc00 and v <= 0xdfff)
                  print "error: expected low surrogate code point"
                  return ""
               .
               v = 0x10000 + bitor bitshift bitand vh 0x03ff 10 bitand v 0x03ff
            .
            r$ &= strchar v
         else
            print "error: expected escape character"
            return ""
         .
      else
         r$ &= c$
      .
   .
   return r$
.
repeat
   s$ = input
   until s$ = ""
   write s$ & " --> "
   r$ = unescape s$
   if r$ <> ""
      print r$
   .
.
# 
input_data
abc
a☺c
a\"c
\u0061\u0062\u0063
a\\c
a\u263Ac
a\\u263Ac<c/ode>
a\uD834\uDD1Ec
a\ud834\udd1ec
a\u263
a\u263Xc
a\uDD1Ec
a\uD834c
a\uD834\u263Ac
