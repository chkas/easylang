col[] = [ 997 977 ]
subr initvars
   sum = 0
   stat = 0
   sum[] = [ 0 0 ]
   player = 1
.
proc btn x y txt$ .
   gcolor 666
   glinewidth 18
   gline x y x + 15 y
   gcolor 000
   gtextsize 10
   gtext x - 4 y - 3 txt$
.
proc show .
   gbackground col[player]
   gclear
   gcolor 000
   gtextsize 10
   gtext 8 78 "Player-" & player
   gtextsize 8
   gtext 8 66 "Total: " & sum[player]
   gtextsize 5
   # 
   h = 3 - player
   gcolor col[h]
   grect 65 63 30 19
   gcolor 000
   gtext 68 74 "Player-" & h
   gtextsize 4
   gtext 68 67 "Total: " & sum[h]
   # 
   btn 20 20 "Roll"
   btn 70 20 "Hold"
.
proc nxtplayer .
   sum[player] += sum
   if sum > 0
      sum = 0
      show
   .
   gtextsize 7
   gcolor 000
   if sum[player] >= 100
      gtext 10 92 "You won !"
      stat = 3
   else
      gtext 10 92 "Switch player ..."
      player = 3 - player
      stat = 2
   .
   timer 2
.
on timer
   if stat = 1
      # roll
      if tmcnt = 0
         gcolor col[player]
         grect 44 34 30 13
         if dice > 1
            sum += dice
            stat = 0
         else
            sum = 0
         .
         gcolor 000
         gtext 44 37 sum
         if dice = 1
            nxtplayer
         .
      else
         gcolor 555
         grect 24 34 13 13
         gcolor 000
         dice = random 6
         gtext 27 37 dice
         tmcnt -= 1
         if tmcnt = 0
            timer 0.5
         else
            timer 0.1
         .
      .
   elif stat = 2
      stat = 0
      show
   elif stat = 3
      gcolor col[player]
      grect 0 0 100 30
      gcolor 000
      gtext 10 30 "Click for new game"
      stat = 4
   .
.
proc roll .
   stat = 1
   tmcnt = 10
   gtextsize 10
   timer 0
.
on mouse_down
   if stat = 0
      if mouse_x > 10 and mouse_x < 45 and mouse_y > 10 and mouse_y < 30
         roll
      elif mouse_x > 60 and mouse_x < 95 and mouse_y > 10 and mouse_y < 30
         nxtplayer
      .
   elif stat = 4
      initvars
      show
   .
.
initvars
show
