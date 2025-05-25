txt_tutor = String.raw`+ Programming small games

-

+ It's not that difficult to program simple games

* A paddle game

+ Try to keep the ball in the field.

##50
background 789
linewidth 2
textsize 2.5
color 789
move 0 50
rect 50 50
color 700
move 30 60
circle 2.5
color 444
move 20 51
line 30 51
move 1 97
text "Pts: 14"

+ We start with a bouncing ball.

vy = 1.5
vx = 1
x = 50
y = 80
#
on animate
   clear
   color 700
   move x y
   circle 5
   color 444
   x += vx
   y += vy
   if x > 95 or x < 5
      vx = -vx
   .
   if y > 95 or y < 5
      vy = -vy
   .
.

+ In this tutorial, a dot is used instead of the *end* as a block end delimeter. Both are equivalent and it is just a personal preference which you use.

+ The paddle is controlled with the left and right arrow keys. We can determine the current status of the keys with *on key_down* and *on key_up*.

px = 50
linewidth 4
on animate
   clear
   color 444
   move px - 10 2
   line px + 10 2
   move 2 95
   if right = 1 and px < 88
      px += 1
   .
   if left = 1 and px > 12
      px -= 1
   .
.
on key_down
   if keybkey = "ArrowRight"
      right = 1
   elif keybkey = "ArrowLeft"
      left = 1
   .
.
on key_up
   if keybkey = "ArrowRight"
      right = 0
   elif keybkey = "ArrowLeft"
      left = 0
   .
.

+ We now combine the paddle and the ball. We also need to check whether the paddle is under the ball when it reaches the bottom.

background 789
subr init
   linewidth 4
   x = 50
   y = 90
   vx = 1
   vy = -1.5
   px = 50
   out = 0
.
init
on animate
   clear
   color 700
   move x y
   circle 5
   color 444
   move px - 10 2
   line px + 10 2
   #
   x += vx
   y += vy
   if right = 1 and px < 88
      px += 1
   .
   if left = 1 and px > 12
      px -= 1
   .
   if x > 95 or x < 5
      vx = -vx
   .
   if y > 95
      vy = -vy
   .
   if y < 8
      if abs (x - px) < 16 and out = 0
         vy = -vy
      else
         out = 1
      .
      if y < -10
         textsize 10
         move 20 60
         text "Game over"
      .
   .
.
on key_down
   if keybkey = "ArrowRight"
      right = 1
   elif keybkey = "ArrowLeft"
      left = 1
   elif keybkey = " " and out = 1
      init
   .
.
on key_up
   if keybkey = "ArrowRight"
      right = 0
   elif keybkey = "ArrowLeft"
      left = 0
   .
.

+ You can add an extension so that the successful return shots are counted. To make the game more difficult, you can gradually increase the speed of the ball and the paddle.

* Reaction tester

+ We are writing a program with which you can test your own reaction time. After a random time, the prompt to press a button is displayed and then the time until the button is pressed is measured.

background 000
subr wait
   clear
   color 733
   text "WAIT"
   timer 1 + 2 * randomf
.
on timer
   clear
   color 373
   text "PRESS"
   time0 = systime
.
on mouse_down
   if time0 <> 0
      clear
      color 555
      text systime - time0
      time0 = 0
   else
      wait
   .
.
textsize 20
move 20 50
wait

+ *systime* returns the seconds since 1.1.1970 00:00 as a floating point number. The timer event is triggered with a selectable delay by the *timer* command. *randomf* returns a random float value between 0 and 1.

* Letter memory game

+ The aim is to find identical pairs of cards. After each attempt, the cards are covered up again.

##50
proc square ind col s$ .
   ind -= 1
   x = ind mod 4 * 12 + 2
   y = ind div 4 * 12 + 52
   color col
   move x y
   rect 11 11
   move x + 3 y + 3
   color 000
   text s$
.
textsize 8
for i = 1 to 16 : square i 353 ""
square 3 575 "A"
square 6 575 "A"
square 7 575 "D"
square 16 575 "D"
square 9 575 "E"

+ We have 16 cards, which we arrange line by line from bottom to top. These cards and also the positions are numbered from 1 to 16.

##50
proc square ind col n .
  ind -= 1
  x = ind mod 4 * 12 + 2
  y = ind div 4 * 12 + 52
  color col
  move x y
  rect 11 11
  if n < 10 : x += 1.7
  move x + 1.6 y + 3
  color 000
  text n
.
textsize 6
for i = 1 to 16 : square i 353 i

+ At first we create a procedure that draws a square at a position (1-16).

+ The drawing area is 100 times 100 units. The origin is bottom left. There are 1000 possible colors - from 000 to 999, mixed from the primary colours red, green and blue. The left digit specifies the red component, the middle digit the green component and the right digit the blue component (*900* is a deep red).

subr draw_square
   x = (ind - 1) mod 4 * 24 + 3
   y = (ind - 1) div 4 * 24 + 3
   move x y
   rect 22 22
.
ind = 2
color 353
draw_square

+ *(ind - 1) mod 4* calculates the rest of the division by 4 and gives the 0-based column of the card. *(ind - 1) div 4* calculates the integer part of the division and gives the row. This is then scaled to *x* and *y* and a small square is drawn, leaving an edge free.

+ We need an array of size 16 containing the letters.

cards$[] = strchars "AABBDDEEFFGGHHII"
print cards$[]

+ Now we shuffle the cards (this array) and display them.

cards$[] = strchars "AABBDDEEFFGGHHII"
textsize 16
#
subr draw_square
   x = (ind - 1) mod 4 * 24 + 3
   y = (ind - 1) div 4 * 24 + 3
   move x y
   rect 22 22
.
subr show_card
   color 575
   draw_square
   move x + 5 y + 5
   color 000
   text cards$[ind]
.
for ind = 16 downto 1
   r = random ind
   swap cards$[r] cards$[ind]
   show_card
.

+ On mouse-click we search for the card under the mouse pointer and uncover it.

cards$[] = strchars "AABBDDEEFFGGHHII"
textsize 16
#
subr draw_square
   x = (ind - 1) mod 4 * 24 + 3
   y = (ind - 1) div 4 * 24 + 3
   move x y
   rect 22 22
.
subr cover_card
   color 353
   draw_square
.
subr show_card
   color 575
   draw_square
   move x + 5 y + 5
   color 000
   text cards$[ind]
.
on mouse_down
   c = mouse_x div 25
   r = mouse_y div 25
   ind = r * 4 + c + 1
   show_card
.
for ind = 1 to 16
   cover_card
   r = random ind
   swap cards$[r] cards$[ind]
.

+ We need a *timer* to automatically close the face-up cards. And *systime* to measure how much time it takes the player to find all matches.

# Letter memory
#
cards$[] = strchars "AABBDDEEFFGGHHII"
len open[] 16
background 000
textsize 16
#
subr draw_square
   x = (ind - 1) mod 4 * 24 + 3
   y = (ind - 1) div 4 * 24 + 3
   move x y
   rect 22 22
.
subr cover_card
   open[ind] = 0
   color 353
   draw_square
.
subr show_card
   open[ind] = 1
   color 575
   draw_square
   move x + 5 y + 5
   color 000
   text cards$[ind]
.
subr init
   opencards = 0
   time0 = systime
   clear
   # shuffle and close cards
   for ind = 1 to 16
      cover_card
      r = random ind
      swap cards$[r] cards$[ind]
   .
.
subr open
   show_card
   if card1 = 0
      # first card
      card1 = ind
   else
      # second card
      card2 = ind
      if cards$[card2] <> cards$[card1]
         # cards are covered after one second
         timer 1
      else
         # two matching cards found
         card1 = 0
         card2 = 0
         opencards += 2
         if opencards = 16
            # done
            clear
            move 5 50
            color 575
            text "Time: " & floor (systime - time0)
         .
      .
   .
.
on timer
   # cover the two uncovered cards
   ind = card1
   cover_card
   ind = card2
   cover_card
   card1 = 0
   card2 = 0
.
subr search_card
   c = mouse_x div 25
   r = mouse_y div 25
   ind = r * 4 + c + 1
   if open[ind] = 0
      open
   .
.
on mouse_down
   if opencards = 16
      # new game
      init
   elif card2 = 0
      search_card
   .
.
init

-`
