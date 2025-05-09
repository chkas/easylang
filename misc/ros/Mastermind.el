# Mastermind:w90
#
col[] = [ 802 990 171 229 950 808 ]
len code[] 4
len guess[] 4
#
subr init_vars
   row = 0
.
proc draw_rate r black white .
   for j range0 2
      for c range0 2
         move c * 3.5 + 71.5 r * 11.5 + 9.4 - j * 3.5
         if black > 0
            color 000
            circle 1.4
            black -= 1
         elif white > 0
            color 999
            circle 1.4
            white -= 1
         else
            color 310
            circle 0.7
         .
      .
   .
.
proc show_code .
   color 531
   move 22 92
   rect 46 8
   for i to 4
      move i * 8 + 20 97
      color col[code[i]]
      circle 2
   .
.
proc draw_guess .
   for c to 4
      move c * 12 + 8 row * 11.5 + 7.5
      color col[guess[c]]
      circle 3.8
   .
.
proc next_row .
   color 420
   linewidth 11
   move 17 row * 11.5 + 7.5
   line 60 row * 11.5 + 7.5
   draw_guess
   move 73.5 row * 11.5 + 7.5
   color 310
   circle 5.0
   color 753
   move 71.5 row * 11.5 + 5
   textsize 7
   text "✓"
.
proc rate .
   move 73.5 row * 11.5 + 7.5
   color 531
   circle 5.2
   c[] = code[]
   g[] = guess[]
   for i to 4
      if c[i] = g[i]
         black += 1
         c[i] = -1
         g[i] = -2
      .
   .
   for i to 4
      for j to 4
         if c[i] = g[j]
            white += 1
            c[i] = -1
            g[j] = -2
         .
      .
   .
   draw_rate row black white
   color 531
   linewidth 12
   move 17 row * 11.5 + 7.5
   line 60 row * 11.5 + 7.5
   draw_guess
   row += 1
   if black = 4
      row = 8
   .
   if row = 8
      show_code
      timer 2
   else
      next_row
   .
.
on timer
   row = -2
.
proc new .
   init_vars
   for i to 4
      code[i] = random 6
   .
   color 531
   move 10 10
   rect 70 80
   linewidth 10
   move 5 95
   line 5 5
   line 85 5
   line 85 95
   line 5 95
   color 310
   linewidth 7
   move 28 96.5
   line 58 96.5
   move 30 95
   color 864
   textsize 4
   text "Mastermind"
   color 310
   linewidth 0.5
   move 10 90
   line 10 4
   move 67 90
   line 67 4
   move 80 90
   line 80 4
   for r range0 8
      for c range0 4
         move c * 12 + 20 r * 11.5 + 7.5
         circle 2
      .
      draw_rate r 0 0
   .
   guess[1] = 1
   guess[2] = 1
   guess[3] = 2
   guess[4] = 2
   next_row
.
proc do_move .
   c = (mouse_x - 15) div 12
   guess[c + 1] = guess[c + 1] mod 6 + 1
   draw_guess
.
on mouse_down
   if row = -2
      new
   elif mouse_y > row * 11.5 + 0.5 and mouse_y < row * 11.5 + 10.5 and row < 8
      if mouse_x > 15 and mouse_x < 61
         do_move
      elif mouse_x > 67 and mouse_x < 80
         rate
      .
   .
.
new
