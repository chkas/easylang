# AoC-25 - Day 4: Printing Department
#
visual = 1
global m[] nc .
#
inputsim = 0
inputcnt = 0
func$ xinput .
   # if no "input_data" is provided,
   # a random input is generated
   if inputsim = 0 : s$ = input
   if s$ = "" and inputcnt = 0
      inputsim = 1
      random_seed 0
   .
   if inputsim = 1 and inputcnt < 139
      for i to 139
         if randomf > 0.33
            s$ &= "@"
         else
            s$ &= "."
         .
      .
   .
   inputcnt += 1
   return s$
.
proc init .
   s$ = xinput
   nc = len s$ + 1
   for i to nc : m[] &= 0
   while s$ <> ""
      m[] &= 0
      for c$ in strchars s$
         m[] &= if c$ = "@"
      .
      s$ = xinput
   .
   for i to nc + 1 : m[] &= 0
.
init
gbackground 000
gcolor 999
gtextsize 3
proc show sum .
   if visual = 0 : return
   gclear
   sc = 100 / nc
   for i to len m[]
      x = (i - 2) mod nc * sc
      y = (i - 2) div nc * sc
      if m[i] = 1
         gcircle x y sc / 2
      .
   .
   gtext 91 1 sum
   sleep 0.15
.
dir[] = [ 1 (nc + 1) nc (nc - 1) -1 (-nc - 1) (-nc) (-nc + 1) ]
#
func round remove .
   for p to len m[] : if m[p] = 1
      s = 0
      for d in dir[] : s += m[p + d]
      if s < 4
         cnt += 1
         if remove = 1 : m[p] = 0
      .
   .
   return cnt
.
print round 0
repeat
   r = round 1
   until r = 0
   sum += r
   show sum
.
print sum
#
input_data
