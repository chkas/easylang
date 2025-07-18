txt_tutor = String.raw`+ Documentation - Code snippets

-

+ The program can be started with the "Run" button, with Ctrl+R, with Shift+Enter or with a double press on Enter.

+ The tab key can be used for auto-completion of commands and parameters.

i = 1
while i <= 10
   print i * i
   i += 1
.

+ Blocks end with *end* or with a dot. A newline has no other meaning than a space. Variables do not have to be declared.

-

+ Play 10000 times roulette betting on 13

cash = 0
for i = 1 to 10000
   cash -= 10
   numb = random 37 - 1
   if numb = 13
      cash += 350
   .
.
print "Your cash: " & cash

+ *random 37* returns a random integer between 1 and 37 inclusive.

* Arrays

f[] = [ 27 44 -4 51 36 ]
#
max = f[1]
for i = 2 to len f[]
   if f[i] > max
      max = f[i]
   .
.
print "Max: " & max

+ Array indices start at 1. *len* returns the array length.

-

+ Get primes using the Sieve of Eratosthenes

len sieve[] 100
max = sqrt len sieve[]
for i = 2 to max
   if sieve[i] = 0
      j = i * i
      while j <= len sieve[]
         sieve[j] = 1
         j += i
      .
   .
.
for i = 2 to len sieve[]
   if sieve[i] = 0
      print i
   .
.

+ With *len* you can set the array length. The numeral array elements are initialized with *0*, for string array elements with *""*.

* Floating point

+ Calculate PI using the Leibniz formula

numfmt 0 4
i = 1
while i < 1000
   s += 1 / i
   i += 2
   s -= 1 / i
   i += 2
.
s += 1 / i / 2
print "PI: " & s * 4

+ *numfmt* sets the fill space and the number of decimal places when a number is converted to a string. The default values are *0 2*.

-

+ Calculate PI using  Monte Carlo method

for i = 1 to 100000
   x = randomf
   y = randomf
   if x * x + y * y < 1
      hit += 1
   .
.
print "PI: " & 4.0 * hit / 100000

+ *randomf* returns a random float value between 0 and 1 (exclusive).

* Strings

a$ = input
a = number a$
if error <> 0
   print a$ & " is not a number"
else
   print a & " * " & a & " = " & a * a
.

+ String variables end with the *$* character. *input* requests an input from the user. *number* converts a string to an integer. *error* indicates a conversion error. Strings are concatenated with the *&* character.

+ *print* (or *pr*) outputs a string to the text console with a line feed. Numbers are converted to strings.

* Subroutines, Functions

+ Subroutines are defined with *subr*. Global variables are used for parameters and return values.

subr gcd
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   res = a
.
a = 120
b = 35
gcd
print res

-

+ Procedures are defined with *proc*. Value and reference parameters are specified after the procedure name. Variables that occur for the first time within a procedure are local to that procedure.

proc gcd a b &res .
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   res = a
.
gcd 120 35 r
print r

-

+ Functions are defined with *func*. *return* exits the function and returns the specified value.

func gcd a b.
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   return a
.
print gcd 120 35

* Sound

+ Morse code

txt$ = "sos sos"
#
chars$ = "abcdefghijklmnopqrstuvwxyz "
code$[] = [ ".-" "-..." "-.-." "-.." "." "..-." "--." "...." ".." ".---" "-.-" ".-.." "--" "-." "---" ".--." "--.-" ".-." "..." "-" "..-" "...-" ".--" "-..-" "-.--" "--.." " " ]
#
proc morse ch$ .
   ind = strpos chars$ ch$
   if ind > 0
      write ch$ & " "
      sleep 0.4
      for c$ in strchars code$[ind]
         write c$
         if c$ = "."
            sound [ 440 0.2 ]
            sleep 0.4
         elif c$ = "-"
            sound [ 440 0.6 ]
            sleep 0.8
         elif c$ = " "
            sleep 0.8
         .
      .
      print ""
   .
.
for ch$ in strchars txt$
   morse ch$
.

+ *sound* plays a list of tones defined by their frequency and duration. The duration in *sound* and in *sleep* is specified in seconds.

+ *strchars* creates from a string a string array containing the individual characters.

+ *strpos* finds the first position of the second string argument within the first argument.

+ The *for in loop* iterates over each item in an array

+ *write* prints a string without line feed.

* Graphics

+ Drawing a house

gcolor 993
grect 20 0 60 45
gcolor 722
gpolygon [ 50 70 15 45 85 45 ]
gcolor 444
grect 30 10 10 10
grect 30 30 10 10
grect 60 30 10 10
gtextsize 8
gtext 5 85 "MY HOUSE"

+ Graphic coordinates: 0/0 is bottom left, 100/100 is top right.

+ The colors are coded from 0 to 999, with the left digit specifying the red component, the middle digit the green component and the right digit the blue component.

+ *gcolor -1* sets the foreground color and *gcolor -2* the background color as drawing color.

+ *grect* draws a filled rectangle. *gpolygon* draws a filled polygon.

-

+ Sine wave

glinewidth 0.1
gline 0 50 100 50
#
gcolor 800
glinewidth 0.5
gpenup
for x = 0 step 0.5 to 100
   deg = x / 100 * 360
   y = 50 + 30 * sin deg
   glineto x y
.

+ *glinewidth* sets the line width. *glineto* draws a line from the current position to the specified position and updates the current position. *gpenup* lifts the drawing pen for the next *glineto*, so that the next *glineto* does not draw a line, but only updates the current position.

+ Coordinates are specified in floating point values and can also take intermediate values.

-

+ Turtle graphics

deg = 0
x = 50
y = 50
down = 0
#
proc forward n .
   x0 = x
   y0 = y
   x += cos deg * n
   y += sin deg * n
   if down = 1
      gline x0 y0 x y
   .
.
proc turn a .
   deg -= a
.
#
forward 35
turn 90
down = 1
for i = 1 to 18
   forward 12
   sleep 0.1
   turn 20
.

-

+ Visualization of the Monte Carlo algorithm

n = 300000
for i = 1 to n
   x = randomf
   y = randomf
   if x * x + y * y < 1
      hit += 1
      gcolor 900
   else
      gcolor 000
   .
   gcircle x * 100 y * 100 0.2
   if i mod 1000 = 0
      sleep 0.01
   .
.
gcolor 000
gtext 10 10 "PI: " & 4.0 * hit / n

+ The drawing area is updated when *sleep* is called.

* Event-drivern programming

+ Watching your drawing

gbackground 777
gclear
col = 0
proc eye x y .
   gcolor 999
   gcircle x y 6.5
   gcolor col
   cx = mouse_x - x
   cy = mouse_y - y
   f = sqrt (cy * cy + cx * cx) / 2
   gcircle x + cx / f y + cy / f 3
.
subr eyes
   eye 20 80
   eye 40 80
.
glinewidth 2
on mouse_move
   eyes
   if down = 1
      gline mx my mouse_x mouse_y
      mx = mouse_x
      my = mouse_y
   .
.
on mouse_down
   down = 1
   eyes
   mx = mouse_x
   my = mouse_y
   gcircle mx my 1
.
on mouse_up
   down = 0
.
on key_down
   if keybkey = "r"
      col = 900
   else
      col = 000
   .
   eyes
.
eyes

+ The *mouse* events are triggered after the corresponding mouse actions. *mouse_x* and *mouse_y* return the mouse position as floating point numbers.

+ The *key_down* event is triggered when a keyboard key is pressed. *keybkey* returns the key value.

-

+ Color picker

c[] = [ 9 0 0 ]
proc picker .
   for i = 0 to 9
      f = 1
      for j = 0 to 2
         gcolor i * f
         grect i * 10 j * 10 10 10
         f *= 10
      .
   .
   gcolor 666
   for i = 0 to 2
      gcircle c[i + 1] * 10 + 5 10 * (2 - i) + 5 1.5
      col = col * 10 + c[i + 1]
   .
   gcolor col
   grect 0 30 100 70
   gcolor 000
   if c[1] + c[2] + c[3] < 15
      gcolor 888
   .
   gtext 30 60 "color " & c[1] & c[2] & c[3]
.
on mouse_down
   if mouse_y < 30
      c[3 - mouse_y div 10] = mouse_x div 10
      picker
   .
.
picker

*div* is an integer division. The number is rounded down after the division.

* Timer, Animation

+ Simple clock

on timer
   if t <> floor systime
      t = floor systime
      gclear
      h$ = timestr t
      gtext 10 58 substr h$ 1 10
      gtext 15 38 substr h$ 12 8
   .
   timer 0.1
.
for i = 0 to 100
   gcolor3 0 (100 - i) 0
   gline 0 i 100 i
.
gbackground -1
gtextsize 12
timer 0

+ The timer event is triggered with a selectable delay by the *timer* command.

+ *systime* returns the time in seconds since 1/1/1970. *timestr* creates a time-date string for the specified seconds.

+ *substr* returns a substring from the specified position and length.

+ With *gcolor3* you can set the intensity (0 to 100) of the red, green and blue color components.

+ With *gbackground -1* the current display is set as background, which can be displayed again with *gclear*. You can also set a background color with this function.

-

+ Bouncing ball

rad = 12
x = 50
y = 50
vx = 1.5
vy = 2
#
on animate
   if systime > timeout
      # every 4 seconds
      timeout = systime + 4
      gcolor random 999 - 1
   .
   gclear
   gcircle x y rad
   x += vx
   y += vy
   if x > 100 - rad or x < rad : vx = -vx
   if y > 100 - rad or y < rad : vy = -vy
.

+ The *animate* event is triggered after each screen update (usually 60 times per second). *systime* returns the time in seconds since program start.

+ A colon *:* can be used to indicate that the following sequence consists of only one instruction. This instruction is then written in the same line and the sequence is implicitly ended.

* More about arrays

a[] = [ 3 4 8 ]
print a[]
# arrays can grow
a[] &= 9
print a[]
# and shrink
len a[] 3
print a[]
for i = 1 to len a[] : print a[i]
# with strings
a$[] = [ "zero" "one" "two" "three" ]
print a$[]
# with floats
a[] = [ 1.1 2.2 3.3 ]
print a[]
# 2-dimensional arrays are arrays of arrays
# this defines 3 arrays with length 4
len a[][] 3
for i = 1 to len a[][] : len a[i][] 4

a[1][2] = 99
print a[][]
a[1][] &= 12
print a[][]
a[][] &= [ 40 41 42 ]
print a[][]

+ Selection sort

proc sort &d[] .
   for i = 1 to len d[] - 1
      for j = i + 1 to len d[]
         if d[j] < d[i] : swap d[j] d[i]
      .
   .
.
d[] = [ 29 4 72 44 55 26 27 77 92 5 ]
sort d[]
print d[]

+ Name ID mapping

name$[] = [ ]
func name2id n$ .
   for id = 1 to len name$[]
      if name$[id] = n$ : return id
   .
   name$[] &= n$
   return id
.
for s$ in [ "alice" "bob" "trudy" "bob" ]
   print s$ & ": " & name2id s$
.

* More about loops, input data

+ With *input_data* a text section is defined whose lines can be read with *input*.

sum = 0
repeat
   s$ = input
   until error = 1
   sum += number s$
.
print sum
#
input_data
10
-2
6

+ With *repeat* you can make loops, which you can leave in the loop body using *until*.

-

+ With *break n* you can leave nested loops.

sum = 80036
for i = 0 to 50
   for j = 0 to 50
      if i * i + j * j * j = sum
         print i & "² + " & j & "³ = " & sum
         break 2
      .
   .
.

* Namespaces

+ Namespaces are implemented with the *prefix* directive. All names - variables, procedures, subroutines - within the range specified are prefixed with the specified string.

pos = 12345
#
prefix st_
#
len stack[] 100
pos = 1
proc push v .
   if pos < len stack[] - 1
      pos += 1
      stack[pos] = v
   .
.
func pop .
   v = stack[pos]
   if pos >= 1 : pos -= 1
   return v
.
prefix
#
st_push 200
st_push 100
print st_pop
print st_pop
print pos

* Builtin functions

print "--- operators ---"
print 7 + 3
print 7 - 3
print 7 * 3
print 7 / 3
print 7 div 3
print 7 mod 3
print "--- number functions ---"
print pow 2 10
print pow 2 0.5
print sqrt 2
print log10 1000
print sin 45
print asin 0.707
print cos 45
print acos 0.707
print tan 45
print atan 1
print atan 100
print atan2 100 0
print pi
print abs -21.34
print floor 2.15
print number "114.2"
print systime
print randomf
print random 10
print number "123"
print strcode "A"
print error
a[] = [ 1 2 3 ]
print len a[]
print len "Hello"
print "--- string functions ---"
print timestr systime
print strchar 65
print substr "Hello world" 7 3
print ""
a$[] = strchars "abc"
print a$[]
print strjoin a$[] " "
a$[] = strsplit "10,15,22" ","
print a$[]
a[] = number strtok "10, 15, 22" ", "
print a[]

* What else is there

+ *arrbase* changes the array index base, which is 1 by default, for an array. *range0* is used for a for-loop with 0 start value and exclusive end.

a[] = [ 10 20 30 ]
arrbase a[] 0
print a[0]
print ""
#
for i range0 len a[] : print a[i]

-

+ With the configuration command *sysconf topleft* you can set the origin of the coordinate system to top left.

sysconf topleft
gtextsize 4
gtext 5 5 "This is top left"

-

if sysfunc "lang" = "de"
    print "Die Systemsprache ist Deutsch."
else
   print "The system language is not German."
.
`

