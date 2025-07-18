col[] = [ 802 990 171 229 950 808 ]
len code[] 4
len guess[] 4
row = 0
# 
proc draw_rate r black white .
   for j range0 2 : for c range0 2
      x = c * 3.5 + 71.5
      y = r * 11.5 + 9.4 - j * 3.5
      if black > 0
         gcolor 000
         gcircle x y 1.4
         black -= 1
      elif white > 0
         gcolor 999
         gcircle x y 1.4
         white -= 1
      else
         gcolor 310
         gcircle x y 0.7
      .
   .
.
proc show_code .
   gcolor 531
   grect 22 92 46 8
   for i to 4
      gcolor col[code[i]]
      gcircle i * 8 + 20 97 2
   .
.
proc draw_guess .
   for c to 4
      gcolor col[guess[c]]
      gcircle c * 12 + 8 row * 11.5 + 7.5 3.8
   .
.
proc next_row .
   gcolor 420
   glinewidth 11
   gline 17 row * 11.5 + 7.5 60 row * 11.5 + 7.5
   draw_guess
   gcolor 310
   gcircle 73.5 row * 11.5 + 7.5 5.0
   gcolor 753
   gtextsize 7
   gtext 71.5 row * 11.5 + 5 "✓"
.
proc rate .
   gcolor 531
   gcircle 73.5 row * 11.5 + 7.5 5.2
   c[] = code[]
   g[] = guess[]
   for i to 4 : if c[i] = g[i]
      black += 1
      c[i] = -1
      g[i] = -2
   .
   for i to 4 : for j to 4
      if c[i] = g[j]
         white += 1
         c[i] = -1
         g[j] = -2
      .
   .
   draw_rate row black white
   gcolor 531
   glinewidth 12
   gline 17 row * 11.5 + 7.5 60 row * 11.5 + 7.5
   draw_guess
   row += 1
   if black = 4 : row = 8
   if row = 8
      show_code
      timer 2
   else
      next_row
   .
.
on timer
   row = -1
.
proc new .
   row = 0
   for i to 4 : code[i] = random 6
   gcolor 531
   grect 10 10 70 80
   glinewidth 10
   gline 5 95 5 5
   gline 5 5 85 5
   gline 85 5 85 95
   gline 85 95 5 95
   gcolor 310
   glinewidth 7
   gline 28 96.5 58 96.5
   gcolor 864
   gtextsize 4
   gtext 30 95 "Mastermind"
   gcolor 310
   glinewidth 0.5
   gline 10 90 10 4
   gline 67 90 67 4
   gline 80 90 80 4
   for r range0 8
      for c range0 4
         gcircle c * 12 + 20 r * 11.5 + 7.5 2
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
   if row = -1
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
