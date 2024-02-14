alpha$[] = strchars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
key$[] = strchars "VsciBjedgrzyHalvXZKtUPumGfIwJxqOCFRApnDhQWobLkESYMTN"
# 
proc subst in$ . out$ a$[] b$[] .
   out$ = ""
   for c$ in strchars in$
      for i to len a$[]
         if a$[i] = c$
            out$ &= b$[i]
            break 1
         .
      .
      if i > len a$[]
         out$ &= c$
      .
   .
.
func$ enc s$ .
   subst s$ r$ alpha$[] key$[]
   return r$
.
func$ dec s$ .
   subst s$ r$ key$[] alpha$[]
   return r$
.
c$ = enc "Hello world"
print c$
print dec c$
