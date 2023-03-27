txt_tutor=`+ Programming a letter memory game

-

+ We program a simple letter memory game.

##50
func square ind col s$ . .
  ind -= 1
  x = ind mod 4 * 12 + 2
  y = ind div 4 * 12 + 2
  color col
  move x y
  rect 11 11
  move x + 3 y + 2
  color 000
  text s$
end
textsize 8
for i = 1 to 16
  call square i 353 ""
end
call square 3 575 "A"
call square 6 575 "A"
call square 7 575 "D"
call square 16 575 "D"
call square 9 575 "E"

+ We have 16 cards, which we arrange line by line. These cards and also the positions are numbered from 1 to 16.

##50
func square ind col n . .
  ind -= 1
  x = ind mod 4 * 12 + 2
  y = ind div 4 * 12 + 2
  color col
  move x y
  rect 11 11
  if n < 10
    x += 1.7
  .
  move x + 1.6 y + 3
  color 000
  text n
.
textsize 6
for i = 1 to 16
  call square i 353 i
.

+ At first we create a function that draws a square at a position (0-15) in a certain color and a label.

+ The drawing area is 100 times 100 units. The origin is top left. There are 1000 possible colors - from 000 to 999, mixed from the primary colours red, green and blue. The left digit specifies the red component, the middle digit the green component and the right digit the blue component (*900* is a deep red).

func draw_square ind col s$ . .
  ind -= 1
  x = ind mod 4 * 24 + 3
  y = ind div 4 * 24 + 3
  color col
  move x y
  rect 22 22
  move x + 5 y + 4
  color 000
  text s$
end
#
textsize 16
call draw_square 1 353  ""
call draw_square 8 575  "A"

+ *func* defines a function. The variables up to the first point are the in-parameters, followed by the in-out- parameters. Variables that appear in a function for the first time are local.

+ *ind mod 4* calculates the rest of the division by 4 and gives the column of the card. *ind div 4* calculates the integer part of the division and gives the row. *x* and *y* are then calculated and a small square is drawn, leaving an edge free. The text is indented, written in black color.

+ We need an array of size 16 containing the letters.

cards$[] = strchars "AABBDDEEFFGGHHII"
print cards$[]

+ Now we shuffle the cards (this array) and display them.

func draw_square ind col s$ . .
  ind -= 1
  x = ind mod 4 * 24 + 3
  y = ind div 4 * 24 + 3
  color col
  move x y
  rect 22 22
  move x + 5 y + 4
  color 000
  text s$
end
# 
textsize 16
cards$[] = strchars "AABBDDEEFFGGHHII"
# shuffle
for i = 2 to 16
  r = random i
  swap cards$[r] cards$[i]
end
# display
for i = 1 to 16
  call draw_square i 575 cards$[i]
end

+ On mouse-click we search for the card under the mouse pointer and uncover it.

func draw_square ind col s$ . .
  ind -= 1
  x = ind mod 4 * 24 + 3
  y = ind div 4 * 24 + 3
  color col
  move x y
  rect 22 22
  move x + 5 y + 4
  color 000
  text s$
end
cards$[] = strchars "AABBDDEEFFGGHHII"
func init . .
  # display covered cards
  for i = 1 to 16
    call draw_square i 353 ""
  end
  # shuffle
  for i = 2 to 16
    r = random i
    swap cards$[r] cards$[i]
  end
end
on mouse_down
  c = mouse_x div 25
  r = mouse_y div 25
  ind = r * 4 + c + 1
  # uncover card 
  call draw_square ind 575 cards$[ind]
end
textsize 16
call init

-

+ Now to another program - a reaction tester - to demonstrate *timer* and *systime*.

# Reaction test
# 
background 000
subr wait
  clear
  color 733
  text "WAIT"
  timer 1 + 2 * randomf
end
on timer
  clear
  color 373
  text "PRESS"
  time0 = systime
end
on mouse_down
  if time0 <> 0
    clear
    color 555
    text systime - time0
    time0 = 0
  else
    call wait
  end
end
textsize 20
move 20 30
call wait

+ *systime* returns the seconds since 1.1.1970 00:00 as a floating point number. The timer event is triggered with a selectable delay by the *timer* command. *randomf* returns a random float value between 0 and 1.

-

+ Now we have everything we need to finish programming the game. 

+ We need the *timer* to automatically close the face-up cards. And *systime* to measure how much time it takes the player to find all matches.

# Letter memory
# 
func draw_square ind col s$ . .
  ind -= 1
  x = ind mod 4 * 24 + 3
  y = ind div 4 * 24 + 3
  color col
  move x y
  rect 22 22
  move x + 5 y + 4
  color 000
  text s$
end
subr init_vars
  card1 = 0
  card2 = 0
  opencards = 0
  time0 = systime
end
cards$[] = strchars "AABBDDEEFFGGHHII"
len open[] 16
background 000
func init . .
  call init_vars
  clear
  # display covered cards
  for i = 1 to 16
    open[i] = 0
    call draw_square i 353 ""
  end
  # shuffle
  for i = 2 to 16
    r = random i
    swap cards$[r] cards$[i]
  end
end
func open ind . .
  open[ind] = 1
  call draw_square ind 575 cards$[ind]
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
        move 5 20
        color 575
        text "Time: " & floor (systime - time0)
      end
    end
  end
end
on timer
  # cover cards
  open[card1] = 0
  call draw_square card1 353 ""
  card1 = 0
  open[card2] = 0
  call draw_square card2 353 ""
  card2 = 0
end
func search_card . .
  c = mouse_x div 25
  r = mouse_y div 25
  ind = r * 4 + c + 1
  if open[ind] = 0
    call open ind
  end
end
on mouse_down
  if opencards = 16
    # new game
    call init
  elif card2 = 0
    call search_card
  end
end
textsize 16
call init

-`

