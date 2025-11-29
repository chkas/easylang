subr nch
   if inp_ind > len inp$[]
      ch$ = strchar 0
   else
      ch$ = inp$[inp_ind]
      inp_ind += 1
   .
   ch = strcode ch$
.
# 
subr ntok
   if ch = 0
      tok$ = "eof"
   else
      while ch$ = " "
         nch
      .
      if ch >= 48 and ch <= 58
         tok$ = "n"
         s$ = ""
         while ch >= 48 and ch <= 58 or ch$ = "."
            s$ &= ch$
            nch
         .
         tokv = number s$
      else
         tok$ = ch$
         nch
      .
   .
.
subr init0
   a$[] = [ ]
   ale[] = [ ]
   ari[] = [ ]
   err = 0
.
proc init s$ . .
   inp$[] = strchars s$
   inp_ind = 1
   nch
   ntok
   init0
.
proc ast_print nd . .
   write "AST: " & nd
   for i to len a$[]
      write " ( "
      write a$[i] & " "
      write ale[i] & " "
      write ari[i]
      write " )"
   .
   print ""
.
func node .
   a$[] &= ""
   ale[] &= 0
   ari[] &= 0
   return len a$[]
.
# 
funcdecl parse_expr .
# 
func parse_factor .
   if tok$ = "n"
      nd = node
      a$[nd] = "n"
      ale[nd] = tokv
      ntok
   elif tok$ = "("
      ntok
      nd = parse_expr
      if tok$ <> ")"
         err = 1
         print "error: ) expected, got " & tok$
      .
      ntok
   .
   return nd
.
func parse_term .
   ndx = parse_factor
   while tok$ = "*" or tok$ = "/"
      nd = node
      ale[nd] = ndx
      a$[nd] = tok$
      ntok
      ari[nd] = parse_factor
      ndx = nd
   .
   return ndx
.
func parse_expr .
   ndx = parse_term
   while tok$ = "+" or tok$ = "-"
      nd = node
      ale[nd] = ndx
      a$[nd] = tok$
      ntok
      ari[nd] = parse_term
      ndx = nd
   .
   return ndx
.
func parse s$ .
   init s$
   return parse_expr
.
func eval nd .
   if a$[nd] = "n"
      return ale[nd]
   .
   le = eval ale[nd]
   ri = eval ari[nd]
   a$ = a$[nd]
   if a$ = "+"
      return le + ri
   elif a$ = "-"
      return le - ri
   elif a$ = "*"
      return le * ri
   elif a$ = "/"
      return le / ri
   .
.
repeat
   inp$ = input
   until inp$ = ""
   print "Inp: " & inp$
   nd = parse inp$
   ast_print nd
   if err = 0
      print "Eval: " & eval nd
   .
   print ""
.
input_data
4 * 6
4.2 * ((5.3+8)*3 + 4)
2.5 * 2 + 2 * 3.14 