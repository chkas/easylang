func$ tostr r[] .
   coin$[] = [ "H" "T" ]
   for r in r[] : r$ &= coin$[r]
   return r$
.
func[] humaninp .
   write "Your guess:"
   repeat
      s$ = input
      r[] = [ ]
      for c$ in strchars s$
         if c$ = "H" or c$ = "h"
            r[] &= 1
         elif c$ = "T" or c$ = "t"
            r[] &= 2
         .
      .
      until len r[] = 3
   .
   print tostr r[]
   return r[]
.
proc game .
   c[] = [ ]
   beginner = random 2
   if beginner = 1
      c[] &= random 2
      c[] &= 3 - c[1]
      c[] &= random 2
      print "Computer: " & tostr c[]
      h[] = humaninp
   else
      h[] = humaninp
      c[] &= 3 - h[2]
      c[] &= h[1]
      c[] &= h[2]
      print "Computer: " & tostr c[]
   .
   print ""
   roll[] = [ ]
   for i to 3 : roll[] &= random 2
   repeat
      sleep 1
      print "Last 3: " & tostr roll[]
      sleep 1
      until h[] = roll[] or c[] = roll[]
      roll[1] = roll[2]
      roll[2] = roll[3]
      roll[3] = random 2
   .
   print ""
   if h[] = roll[]
      print "Congratulation - you win"
   else
      print "Computer wins"
   .
.
game
