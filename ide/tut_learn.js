txt_locale = "de"
txt_tutor=`+ Programming basics

+de Programmier-Grundlagen

-

+ When programming, you tell the computer with a special code what to do.

+de Beim Programmieren sagst du dem Computer mit einem speziellen Code, was er machen soll.

##21
x = 20
linewidth 8
color 333
move x + 9 96
line x + 13 96
color 900
move x + 4 91
line x + 18 91
color 333
move x + 5 85
circle 3.5
move x + 16 85
circle 3.5

+ You can tell the computer to draw two black circles at certain positions, and then a few thick round strokes in a certain color - and there you have a car on the screen.

+ If this is done with a short pause at slightly shifted positions, the car will drive. How to program this and other things you can learn here.

+de Man kann den Computer anweisen, zwei schwarze Kreise an bestimmten Positionen zu zeichnen und dann ein paar dicke runde Striche in einer bestimmten Farbe - und schon hat man ein Auto auf dem Bildschirm.

+de Wenn dies mit einer kurzen Pause bei leicht verschobenen Positionen gemacht wird, fährt das Auto. Wie man dies und andere Dinge programmiert, erfährst du hier.

* Graphics

*de Grafik

+ First we look at the commands that can be used to create graphics on the screen.

+de Zuerst schauen wir uns die Befehle an, mit denen Grafiken auf dem Bildschirm erstellt werden können.

move 10 30
line 50 50

+ We set the drawing pen with *move* to position (10 30), that is 10 from the left and 30 from the bottom. From there, we draw with *line* a line to position (50 50) - to the center of the drawing area.

+de Wir setzen mit *move* den Zeichenstift auf die Position (10 30), das ist 10 von links und 30 von unten. Von dort ziehen wir dann mit *line* eine Linie auf die Position (50 50) - zur Mitte der Zeichenfläche.

##
color 555
textsize 4
move 6 5
text "0/0"
move 82 5
text "100/0"
move 82 91.5
text "100/100"
move 6 91.5
text "0/100"
linewidth 0.5
x = 18
while x < 90
  move x 10
  line x 90
  move 10 x
  line 90 x
  x += 8
.
linewidth 0.8
move 10 10
line 90 10
line 90 90
line 10 90
line 10 10
move 12 28
text "10/30"
move 44 52
text "50/50"
color 833
linewidth 2
move 18 34
line 50 50

+ The drawing area is 100 times 100 units. The origin is bottom left. The first value (the X coordinate) is the distance from the left edge, the second value (the Y coordinate) is the distance from the bottom edge.

+de Die Zeichenfläche beträgt 100 mal 100 Einheiten. Der Ursprung ist links unten. Der erste Wert (die X-Koordinate) ist der Abstand vom linken Rand, der zweite Wert (die Y-Koordinate) ist der Abstand vom unteren Rand.

-

+ *drawgrid* draws a grid. This makes it easier to determine the x and y positions for the graphics commands. In the finished program you can then omit this command.

+ 🤔 Try to finish drawing the square!

+de *drawgrid* zeichnet ein Raster. Damit lassen sich die x- und y-Positionen für die Grafikbefehle leichter bestimmen. Im fertigen Programm kannst du diesen Befehl dann weglassen.

+de 🤔 Versuche das Quadrat fertig zu zeichnen!

drawgrid
move 10 30
line 30 30
line 30 50

+ You can start the program with the *Run* button, with *Ctrl+R* or with *Shift+Enter*.

+de Das Programm kann mit dem *Run*-Button, mit *Strg+R* oder *Shift+Enter* gestartet werden.

-

+ With the command *rect* you can draw filled rectangles. The parameters specify the width and height.

+de Mit dem Befehl *rect* kann man gefüllte Rechtecke zeichnen. Die Parameter geben die Breite und die Höhe an.

+ *color* sets the drawing color. *color 900*, for example, is a rich red color.

+de *color* setzt die Zeichenfarbe. *color 900* ist zum Beispiel eine satte rote Farbe.

color 900
move 10 15
rect 20 20
#
color 990
move 30 45
rect 50 30

+ There are 1000 possible colors - from 000 to 999, mixed from the primary colours red, green and blue. The left digit specifies the red component, the middle digit the green component and the right digit the blue component. These are some possible colors.

+de Es gibt 1000 mögliche Farben - und zwar von 000 bis 999. Die Farben werden dabei aus den Grundfarben Rot, Grün und Blau gemischt. Die linke Ziffer gibt den Rotanteil, die mittlere den Grünanteil und die rechte den Blauanteil an. Dies sind einige mögliche Farben.

##
col[] = [ 900 700 966 990 995 960 090 070 696 099 599 690 009 007 669 909 959 609 777 444 000 999 432 765 ]
textsize 6
for i to len col[]
   y = 100 - i mod1 6 * 16.5
   x = (i - 1) div 6 * 25
   move x y
   color col[i]
   rect 25 16.5
   move x + 7 y + 5
   s$ = col[i]
   if col[i] <= 9
      s$ = "00" & s$
   elif col[i] <= 99
      s$ = "0" & s$
   .
   color 000
   if col[i] = 0 or col[i] = 432
      color 888
   .
   text s$
.

+ 🤔 Draw a dark green square in the lower right area. Dark green is not present in the color palette shown. You can just take a green and lower the green component - the middle digit of the number.

+de 🤔 Zeichne ein dunkelgrünes Quadrat im unteren rechten Bereich. Dunkelgrün ist in der abgebildeten Farbpalette nicht vorhanden. Du kannst einfach ein Grün nehmen und die Grün-Komponente - die mittlere Ziffer der Zahl - verringern.

-

+ Drawing a house

+de Wir zeichnen ein Haus

# facade
color 993
move 20 0
rect 60 45
# roof
color 722
polygon [ 50 70 15 45 85 45 ]
# windows
color 444
move 30 10
rect 10 10
#
move 30 30
rect 10 10
#
move 60 30
rect 10 10
# text
move 5 85
textsize 8
text "MY HOUSE"

+ *text* writes a text to the drawing area. *polygon [x1 y1 x2 y2 ..]* draws a filled polygon, for example a triangle, with the specified coordinates.

+de *text* schreibt einen Text auf die Zeichenfläche. *polygon [x1 y1 x2 y2 ..]* zeichnet ein gefülltes Polygon, zum Beispiel ein Dreieck, mit den angegebenen Koordinaten.

+ The *#* character allows you to insert comments into the program.

+de Das *#*-Zeichen erlaubt es, Kommentare in das Programm einzufügen.

+ 🤔 Draw the missing door.

+ 🤔🤔 If you want, you can use a blue background as a sky and let a sun (*circle*) shine.

+de 🤔 Zeichne die fehlende Tür.

+de 🤔🤔 Wenn du willst, kannst du einen blauen Hintergrund als Himmel verwenden und eine Sonne (*circle*) scheinen lassen.

+ In *Trace* mode, you can watch the computer execute its instructions one by one.

+de Im *Trace*-Modus kannst du dem Computer zuschauen, wie er nacheinander seine Anweisungen ausführt.

-

+ The command *circle* draws a filled circle on the current position.

+ *linewidth* sets the line width. The lines are rounded at the ends.

+de Mit dem Befehl *circle* wird ein gefüllter Kreis an der aktuellen Position gezeichnet.

+de *linewidth* stellt die Linienstärke ein. Die Linien sind an den Enden abgerundet.

move 10 80
circle 4
move 30 80
circle 6
#
linewidth 3
move 10 60
line 30 60
#
linewidth 8
color 900
move 10 40
line 25 40
#
color 333
move 10 20
line 15 20

+ 🤔 Try to draw this car.

+de 🤔 Versuche dieses Auto zu zeichnen.

##24
linewidth 8
color 333
move 29 96
line 33 96
color 900
move 24 91
line 38 91
color 333
move 25 85
circle 3.5
move 36 85
circle 3.5

* Calculating, variable

*de Rechnen, Variable

+ With *print* (or *pr*) you can print numbers and text in the text output window.

+de Mit *print* (oder *pr*) kann man Zahlen und Texte im Textausgabefenster ausgeben.

print 7 * 8 + 2
pr 13 * 7

-

+ You can store a number in a variable and then work with this variable. The *=* here is an assignment command, not an equality expression.

+de Eine Zahl kann man in einer Variablen speichern und dann mit dieser Variablen arbeiten. Das *=* hier ist ein Zuweisungsbefehl, kein Gleichheitsausdruck.

l = 4
w = 5
a = l * w
print a

+ 🤔 This small program calculated the area of a rectangle. Can you also calculate the circumference?

+de 🤔 Dieses kleine Programm hat die Fläche eines Rechtecks berechnet. Kannst du auch den Umfang berechnen?

-

+ A variable can easily be incremented by a value: *a = a + 1*

+de Eine Variable kann man ganz einfach um einen Wert erhöhen: *a = a + 1*

a = 1
a = a + 1
print a

* Strings

*de Strings

+ Strings are texts enclosed in quotation marks.

+de Strings sind in Anführungszeichen eingeschlossene Texte.

print "What is your name?"
n$ = input
print "Hello " & n$

+ *input* reads a string from the keyboard.

+de *input* liest einen String von der Tastatur ein.

+ You can also store strings in variables. The variable name then ends with a "$" character. The *&* character can be used to join strings.

+de Du kannst auch Strings in Variablen speichern. Der Variablenname endet dann mit einem "$"-Zeichen. Mit dem *&*-Zeichen kann man Strings zusammenfügen.

-

print "Area of a square"
print "----------------"
write "Side: "
s = number input
print s
a = s * s
print "Area: " & a

+ *number* converts a string to a number. *write* is like *print* except that it does not jump to a new line after output. With *&* you can also join strings and numbers.

+de *number* konvertiert einen String in eine Zahl. *write* ist wie *print*, nur dass es nach der Ausgabe nicht in eine neue Zeile springt. Mit *&* kannst du auch Strings und Zahlen verbinden.

* Conditional statement

*de Bedingte Anweisung

+ With *if* you can instruct the computer to execute a block of commands only if a condition is met. The end of the block is indicated by *end*.

+de Mit *if* kannst du dem Computer sagen, dass er einen Block von Befehlen nur ausführen soll, wenn eine Bedingung erfüllt ist. Das Ende des Blocks wird durch *end* angezeigt.

a = 7
a = 9 * a
if a > 20
   print "WOW!"
   print "a is large."
end
print "a: " & a

##
color 543
textsize 6
linewidth 0.5
y = 75
func cod n$ v v$ . .
   move 5 y + 2
   line 80 y + 2
   line 80 y + 22
   line 5 y + 22
   line 5 y + 2
   move 12 y + 11
   text n$
   move 52 y + 7
   if v >= 0
      text "a"
      move 59 y + 6
      line 72 y + 6
      line 72 y + 13.5
      line 59 y + 13.5
      line 59 y + 6
      move 62 y + 8
      text v
   else
      text v$
   .
   y -= 25
.
call cod "a ← 7 " 7 ""
call cod "a ← 10 * a " 70 ""
call cod "a > 20 ?" -1 "YES"
call cod "\\"a is large\\"" -1 ""

-

+ The block after *else* is executed if the condition is not fulfilled.

+de Der Block nach *else* wird ausgeführt, wenn die Bedingung nicht erfüllt ist.

a = 7
if a > 20
   print "a is large."
else
   print "a is not large."
end
print "a: " & a

* Loop

*de Schleife

+ *while* works similar to *if*, except that the conditional actions are executed again and again as long as the condition is fulfilled. This is called a *loop*.

+de *while* funktioniert ähnlich wie *if*, nur dass die bedingten Aktionen immer wieder ausgeführt werden, solange die Bedingung erfüllt ist. Das nennt man eine *Schleife*.

i = 1
while i <= 4
   print i
   i = i + 1
end

+ 🤔 Write a program that prints the square numbers up to 10 (1, 4, 9 ...)

+ 🤔🤔 Write a program that adds up the numbers from 1 to 10. (Result: 55)

+de 🤔 Schreibe ein Programm, das die Quadratzahlen bis 10 ausgibt (1, 4, 9 ...).

+de 🤔🤔 Schreibe ein Programm, das die Zahlen von 1 bis 10 zusammenzählt. (Ergebnis: 55)

-

move 10 10
line 90 10
#
move 10 20
line 90 20
#
move 10 30
line 90 30
#
move 10 40
line 90 40
#
move 10 50
line 90 50
#
move 10 60
line 90 60
#
move 10 70
line 90 70
#
move 10 80
line 90 80
#
move 10 90
line 90 90

+ 🤔 Quite a lot of code. Two lines of code occur repeatedly in a very similar form. You can certainly make it shorter with a loop.

+ 🤔 Create a box pattern with additional vertical lines.

+de 🤔 Ziemlich viel Code. Zwei Codezeilen kommen in sehr ähnlicher Form immer wieder vor. Mit einer Schleife kannst du das sicher kürzer machen.

+de 🤔 Erzeuge mit zusätzlichen vertikalen Linien ein Kästchenmuster.

+ 🤔🤔 Can you create this pattern? With a loop you only need a few lines of code.

+de 🤔🤔 Kannst du dieses Muster erzeugen? Mit einer Schleife brauchst du dazu nur ein paar Zeilen Code.

##
color 555
linewidth 0.7
while i <= 100
   move i 0
   line 100 i
   i += 10
.

-

+de Celsius in Fahrenheit umrechnen

+ Convert Celsius to Fahrenheit

c = 10
f = c * 1.8 + 32
print c & "°C = " & f & "°F"

+ 🤔 Extend the program with a loop so that it outputs the values in Fahrenheit from 0°C to 30°C.

+de 🤔 Erweitere das Programm mit einer Schleife so, dass es von 0°C bis 30°C die Werte in Fahrenheit ausgibt.

-

+ A little game - number guessing

+de Ein kleines Spiel - Zahlenraten

n = random 10
print "------------------------------------"
print " I chose a number between 1 and 10"
print "------------------------------------"
#
write "Guess: "
g = number input
write g
sleep 1
if g < n
   print " - is too low"
end
if g > n
   print " - is too high"
end
if g = n
   print " - great, you guessed the number"
end
sleep 1
print "The number was " & n

+ *random 10* returns a random number from 1 - 10. *sleep 1* puts a pause of one second.

+de *random 10* liefert eine Zufallszahl von 1 - 10. *sleep 1* legt eine Pause von einer Sekunde ein.

+ 🤔🤔 Just one try and that's it - it's no fun. You should be able to guess until you have guessed the number. For this you need .... - yeah right - a loop. Hint: *<>* stands for not equal.

+de 🤔🤔 Nur ein Versuch und das war's - das macht keinen Spaß. Man sollte so lange raten können, bis man die Zahl erraten hat. Hierfür brauchst du .... - ja richtig - eine Schleife. Hinweis: *<>* steht für nicht gleich.

-

+ With a loop within a loop (nested loop) you can make even more interesting patterns.

+de Mit einer Schleife innerhalb einer Schleife (verschachtelte Schleife) kannst du noch interessantere Muster erzeugen.

background 990
clear
y = 5
while y < 100
   x = 5
   while x < 100
      move x y
      circle 3
      x += 10
   end
   y += 10
end

+ With each loop cycle of the outer loop, the inner loop is executed completely. *i += 10* is short for *i = i + 10* and means: increment *i* by 10. With *background* you can set the color that *clear* uses when clearing the drawing area.

+de Mit jedem Schleifenzyklus der äußeren Schleife wird die innere Schleife vollständig ausgeführt. *i += 10* ist die Kurzform für *i = i + 10* und bedeutet: erhöhe *i* um 10. Mit *background* kannst du die Farbe festlegen, die *clear* beim Löschen der Zeichenfläche verwendet.

+ 🤔 Change the program a little to make the pattern even more beautiful.

+de 🤔 Verändere das Programm ein wenig, um das Muster noch schöner zu machen.

-

+ Certain while-loops can be replaced by simpler *for-loops*.

+de Bestimmte while-Schleifen kann man durch einfachere *for-Schleifen* ersetzen.

i = 1
while i <= 5
   print i
   i += 1
end

for i = 1 to 5
   print i
end

* Animation

*de Animation

+ A rolling ball - how does it work?

+ Draw the ball, w
ait briefly, clear the screen, move the position slightly, draw again, and so on. This creates the impression of movement.

+de Ein rollender Ball - wie funktioniert das?

+de Den Ball zeichnen, kurz warten, Bildschirm löschen, die Position leicht verändern, und wieder zeichnen, und so fort. So entsteht der Eindruck einer Bewegung.

color 900
x = -9
while x < 120
   # clear the drawing area
   clear
   # draw the ball at position x
   move x 10
   circle 10
   # wait half a second
   sleep 0.5
   # change drawing position
   x = x + 5
end

+ 🤔 Try to make the animation smoother by increasing the x-position of the circle only by 1 or 0.5 each time and shortening the pause to the next frame.

+ 🤔 Stop the ball when it touches the right edge.

+ 🤔🤔 Let the ball roll back again.

+de 🤔 Versuche, die Animation flüssiger zu machen, indem du die x-Position des Kreises jedes Mal nur um 1 oder 0.5 erhöhst und die Pause zum nächsten Bild verkürzt.

+de 🤔 Halte den Ball an, wenn er die rechte Kante berührt.

+de 🤔🤔 Lass den Ball wieder zurückrollen.

-

+ A moving car.

+de Ein fahrendes Auto.

subr drawcar
   clear
   linewidth 8
   color 333
   move x + 9 14
   line x + 13 14
   color 900
   move x + 4 9
   line x + 18 9
   color 333
   move x + 5 3
   circle 3.5
   move x + 16 3
   circle 3.5
   sleep 0.5
end
# 
call drawcar
x += 10
call drawcar
x += 10
call drawcar

+ With *subr* you can combine actions that can be called from different places using *call*. This is called a *subroutine*.

+de Mit *subr* können Aktionen zusammengefasst werden, die von verschiedenen Stellen aus mittels *call* aufgerufen werden können. Das nennt man *Unterprogramm* oder *Subroutine*.

+ With *func* you can also create *functions* with parameters and local variables, but this is not covered in this beginner course.

+de Mit *func* kann man auch *Funktionen* mit Parametern und lokalen Variablen erstellen, das wird aber in diesem Einsteiger-Kurs nicht behandelt.

+ 🤔 Let the car move.

+de 🤔 Lass das Auto fahren.

+ 🤔🤔 Let the car move back and forth three times.

+de 🤔🤔 Lass das Auto dreimal hin und her fahren.

+ 🤔🤔 Draw the house from above as background.

+de 🤔🤔 Zeichne das Haus von oben als Hintergrund.

* Event-driven programming

*de Ereignisgesteuerte Programmierung

+ In event-driven programming, a program routine is executed when a specific event, such as pressing the mouse button, occurs.

+de Bei der ereignisgesteuerten Programmierung wird dann eine Programm-Routine ausgeführt, wenn ein bestimmtes Ereignis, wie das Drücken der Maustaste, auftritt.

+ We create a simple painting program.

+de Wir erstellen ein einfaches Malprogramm.

linewidth 4
color 900
#
on mouse_down
   down = 1
   move mouse_x mouse_y
   circle 2
end
on mouse_up
   down = 0
end
on mouse_move
   if down = 1
      line mouse_x mouse_y
   end
end

+ The *mouse* events are triggered after the corresponding mouse actions. *mouse_x* and *mouse_y* return the mouse position.

+de Die *mouse*-Ereignisse werden nach den entsprechenden Maus-Aktionen ausgelöst. *mouse_x* und *mouse_y* liefern die Maus-Position.

-

+ You can also handle keyboard events.

+de Du kannst auch Tastatur-Ereignisse verarbeiten.

on key
   if keybkey = "r"
      background 900
   elif keybkey = "g"
      background 090
   else
      background 777
   end
   clear
   move 5 5
   text keybkey
end

+ 🤔 Use the keyboard keys to change the colors of the previous painting program!

+de 🤔 Verwende die Keyboard-Tasten, um die Farben des vorherigen Malprogramms zu ändern!

-

+ The *animate* event occurs after each screen refresh. Perfect for letting the car drive. Oops - something is missing!

+de Das *animate*-Ereignis tritt nach jeder Bildschirmaktualisierung auf. Perfekt, um das Auto fahren zu lassen. Ups... da fehlt etwas!

v = 0.4
on animate
   if x > 79 or x < 0
      # change direction
      v = -v
   end
   clear
   # here is something missing
   move x + 5 3
   circle 3.5
   move x + 16 3
   circle 3.5
   x += v
end

+ 🤔 Fix the car!

+ 🤔🤔 Try to control the speed with the keyboard keys!

+de 🤔 Repariere das Auto!

+de 🤔🤔 Versuche mit den Keyboard-Tasten die Geschwindigkeit zu steuern!

* Array

*de Array (Feld)

+ We draw a starry sky. The position and magnitude (brightness) of the stars are generated randomly.

+de Wir zeichnen einen Sternenhimmel. Die Position und die Helligkeit der Sterne werden zufällig erzeugt.

background 000
clear
color 999
for i = 1 to 50
   x = random 101 - 1
   y = random 101 - 1
   mag = random 50
   move x y
   circle mag / 100
end

-

+ Now let's draw a starry sky from a star map. For this we need something like a list.

+ We use an *array* for this. The field elements can be accessed using square brackets and a position specification, also called index. The first element is at position 1, *len* returns the number of elements in the array.

+de Jetzt wollen wir einen Sternenhimmel nach einer Sternenkarte zeichnen. Dazu brauchen wir so etwas wie eine Liste.

+de Wir verwenden dazu ein *Feld* (engl. *Array*). Auf die Feldelemente kann über eckige Klammern und eine Positionsangabe, auch Index genannt, zugegriffen werden. Das erste Element steht an der Position 1. *len* gibt die Anzahl der Elemente im Array zurück.

a[] = [ 3 7 2 8 ]
print len a[]
print a[1]
print a[2]
#
print ""
for i = 1 to len a[]
   print a[i]
end

##85
sys topleft
color 543
textsize 6
linewidth 0.8
move 25 5
line 60 5
line 60 80
line 25 80
line 25 5
y = 10
func dr ind v . .
  move 31 y + 3
  text ind
  move 43 y + 3
  text v
  move 40 y
  line 50 y
  line 50 y + 11
  line 40 y + 11
  line 40 y
  y += 18
.
a[] = [ 3 7 2 8 ]
for i = 1 to len a[]
  call dr i a[i]
.
textsize 9
move 4 10
text "a[]"

+ How can you find the smallest number in this array?

+ First take the first element as the smallest number. Then go through all the numbers and compare them to the current smallest number. If a number is smaller, it is the new smallest number.

+de Wie kann man die kleinste Zahl in diesem Array finden?

+de Nimm zuerst das erste Element als kleinste Zahl. Gehe dann alle Zahlen durch und vergleiche sie mit der aktuellen kleinsten Zahl. Wenn eine Zahl kleiner ist, ist das die neue kleinste Zahl.

a[] = [ 3 7 2 8 ]
min = a[1]
for i = 2 to len a[]
   if a[i] < min
      min = a[i]
   end
end
print min

+ 🤔 We now also want to know what the biggest number is.

+de 🤔 Wir wollen nun auch wissen, was die größte Zahl ist.

+🤔🤔 Can you find the mean (average) of these numbers? The mean is the sum of all elements divided by the number of elements.

+de 🤔🤔 Kannst du den Mittelwert (Durchschnitt) dieser Zahlen ermitteln? Der Mittelwert ist die Summe aller Elemente geteilt durch die Anzahl der Elemente.

-

+ Back to the starry sky: the X and Y positions and the magnitudes of the stars are placed in one array each.

+de Zurück zum Sternenhimmel: Die X- und Y-Positionen und die Helligkeiten der Sterne stehen in jeweils einem Feld.

x[] = [ 7 81 86 76 50 55 23 77 17 23 16 93 91 13 27 44 29 93 1 53 26 38 35 23 54 85 33 87 7 13 2 20 18 ]
#
y[] = [ 13 29 50 15 65 42 91 24 92 19 86 48 37 58 95 25 17 13 31 39 44 32 72 61 21 36 94 75 66 52 11 92 72 ]
#
mag[] = [ 55 37 37 36 35 34 33 33 33 33 32 32 31 30 28 28 27 27 26 25 24 23 23 23 22 22 22 22 21 21 20 20 20 ]
#
background 000
clear
color 999
for i = 1 to len x[]
   move x[i] y[i]
   circle mag[i] / 100
end

-

+ 🤔🤔 On the starry sky you can see the constellation *Big Dipper*. If you draw connected lines through the stars 4, 8, 2, 26, 13, 12, 3 and 26 (position in the array), you can make it visible. The star at position 5 is the Pole Star (Polaris).

+de 🤔🤔 Auf dem Sternenhimmel gibt es das Sternbild *Großer Wagen* zu sehen. Wenn man verbundene Linien durch die Sterne 4, 8, 2, 26, 13, 12, 3 und 26 (Position im Array) zieht, kann man es sichtbar machen. Der Stern an der Position 5 ist der Polarstern (Polaris).

+ 🤔🤔 Connect the stars of the constellation *Cassiopeia*, which can easily be recognized by its W-shape. To find the indices of the stars, output them using *text i* when drawing the star map.

+de 🤔🤔 Verbinde die Sterne des Sternbildes *Cassiopeia*, welches man leicht an seiner W-Form erkennen kann. Um die Indizes der Sterne zu ermitteln, gibst du diese beim Zeichnen der Sternkarte einfach mittels *text i* aus.

##
x[] = [ 7 81 86 76 50 55 23 77 17 23 16 93 91 13 27 44 29 93 1 53 26 38 35 23 54 85 33 87 7 13 2 20 18 ]
y[] = [ 13 29 50 15 65 42 91 24 92 19 86 48 37 58 95 25 17 13 31 39 44 32 72 61 21 36 94 75 66 52 11 92 72 ]
m[] = [ 55 37 37 36 35 34 33 33 33 33 32 32 31 30 28 28 27 27 26 25 24 23 23 23 22 22 22 22 21 21 20 20 20 ]
background 000
clear
color 999
for i = 1 to len x[]
  move x[i] y[i]
  circle m[i] / 100
.
textsize 3
move x[5] y[5]
text "Polaris"
color 444
linewidth 0.2
si[][] &= [ 4 8 2 26 13 12 3 26 ]
si[][] &= [ 11 9 7 15 27 ]
for s = 1 to len si[][]
  for i = 1 to len si[s][]
    h = si[s][i]
    if i = 1
      move x[h] y[h]
    else
      line x[h] y[h]
    .
  .
.

* Working with an array, sorting

*de Mit einem Array arbeiten, Sortieren

+ We want to put the smallest number on the first position. For this we remember the position of the smallest element. Then we just have to copy the first element to the position of the smallest element and put the smallest number to the first position.

+de Wir wollen die kleinste Zahl auf die erste Position setzen. Dazu merken wir uns die Position des kleinsten Elements. Dann müssen wir nur noch das erste Element an die Position des kleinsten Elements kopieren und die kleinste Zahl an die erste Position setzen.

data[] = [ 44 72 55 26 27 4 99 7 ]
min = data[1]
min_pos = 1
for i = 2 to len data[]
   if data[i] < min
      min = data[i]
      min_pos = i
   end
end
data[min_pos] = data[1]
data[1] = min
print data[]

-

+ 🤔🤔 We can move the smallest element to the first place. With the same procedure we can move the smallest element starting from the second position to the second position. When we did that for all positions, the array is sorted.

+de 🤔🤔 Wir können das kleinste Element an die erste Stelle befördern. Mit dem gleiche Verfahren können wir das kleinste Elemente ab der zweiten Stelle an die zweite Position bringen. Wann wir das für alle Positionen gemacht haben, ist das Array sortiert.

data[] = [ 44 72 55 26 27 4 99 7 ]
for pos = 1 to len data[] - 1
   #
   # TODO: search minimum starting from
   #       pos and move it to pos
   #
end
print data[]
`
