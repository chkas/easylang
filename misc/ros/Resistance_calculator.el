global m[][] .
serial = -1
parallel = -2
func getr n .
   if m[n][1] = serial
      r = getr m[n][2] + getr m[n][3]
   elif m[n][1] = parallel
      r = 1 / (1 / getr m[n][2] + 1 / getr m[n][3])
   else
      r = m[n][1]
   .
   return r
.
proc setu n v .
   a = m[n][2]
   b = m[n][3]
   m[n][4] = v
   if m[n][1] = serial
      ra = getr a
      rb = getr b
      setu a ra / (ra + rb) * v
      setu b rb / (ra + rb) * v
   elif m[n][1] = parallel
      setu a v
      setu b v
   .
.
global arr$[] .
func buildr .
   c$ = arr$[$]
   len arr$[] -1
   m[][] &= [ 0 0 0 0 ]
   ind = len m[][]
   if c$ = "+" or c$ = "*"
      m[ind][1] = serial
      m[ind][2] = buildr
      m[ind][3] = buildr
      if c$ = "*" : m[ind][1] = parallel
   else
      m[ind][1] = number c$
   .
   return ind
.
func$ gsym v .
   if v = serial : return "+"
   if v = parallel : return "*"
   return "r"
.
proc report n lev$ .
   r = getr n
   u = m[n][4]
   i = u / r
   print r & "\t" & u & "\t" & i & "\t" & u * i & "\t" & lev$ & gsym m[n][1]
   if m[n][3] > 0 : report m[n][3] lev$ & "| "
   if m[n][2] > 0 : report m[n][2] lev$ & "| "
.
proc go rpn$ .
   arr$[] = strsplit rpn$ " "
   m[][] = [ ]
   net = buildr
   setu net 18
   print "Ohm\tVolt\tAmpere\tWatt\tNetwork tree"
   print "--------------------------------------------"
   report net ""
.
go "10 2 + 6 * 8 + 6 * 4 + 8 * 4 + 8 * 6 +"
