# AoC-20 - Day 18: Operation Order
# 
repeat
   s$ = input
   until s$ = ""
   in$[] &= s$
.
# 
subr ntok
   if linepos > len lin$
      tok$ = "eof"
   else
      while substr lin$ linepos 1 = " "
         linepos += 1
      .
      tok$ = substr lin$ linepos 1
      tokv = strcode tok$ - strcode "0"
      if tokv >= 0 and tokv <= 9
         tok$ = "n"
      .
      linepos += 1
   .
.
subr init
   linepos = 1
   call ntok
.
# 
# Part 1
# 
funcdecl parse_expr1 . res .
# 
func parse_factor1 . res .
   if tok$ = "n"
      res = tokv
      call ntok
   elif tok$ = "("
      call ntok
      call parse_expr1 res
      if tok$ <> ")"
         print "error"
      .
      call ntok
   .
.
func parse_expr1 . res .
   call parse_factor1 res
   while tok$ = "+" or tok$ = "*"
      t$ = tok$
      call ntok
      call parse_factor1 r
      if t$ = "+"
         res += r
      else
         res *= r
      .
   .
.
sum = 0
for lin$ in in$[]
   call init
   call parse_expr1 res
   sum += res
.
print sum
# 
# Part 2
# 
funcdecl parse_expr . res .
# 
func parse_factor . res .
   if tok$ = "n"
      res = tokv
      call ntok
   elif tok$ = "("
      call ntok
      call parse_expr res
      if tok$ <> ")"
         print "error"
      .
      call ntok
   .
.
func parse_term . res .
   call parse_factor res
   while tok$ = "+"
      call ntok
      call parse_factor r
      res += r
   .
.
func parse_expr . res .
   call parse_term res
   while tok$ = "*"
      call ntok
      call parse_term r
      res *= r
   .
.
sum = 0
for lin$ in in$[]
   call init
   call parse_expr res
   sum += res
.
print sum
# 
input_data
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2

