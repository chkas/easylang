txt_locale = "de"
txt_tutor=`+ Learn programming

+de Programmieren lernen

-

+ When programming, you tell the computer with a special code what to do.

+de Beim Programmieren sagst du dem Computer mit einem speziellen Code, was er machen soll.

* Graphics

*de Grafik

+ First we look at the commands that can be used to create graphics on the screen.

+de Zuerst schauen wir uns die Befehle an, mit denen Grafiken auf dem Bildschirm erstellt werden können.

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

+ The drawing area is 100 times 100 units. The origin is top left. The first value (the X coordinate) is the distance from the left edge, the second value (the Y coordinate) is the distance from the top edge.

+de Die Zeichenfläche beträgt 100 mal 100 Einheiten. Der Ursprung ist oben links. Der erste Wert (die X-Koordinate) ist der Abstand vom linken Rand, der zweite Wert (die Y-Koordinate) ist der Abstand vom oberen Rand.

move 10 30
line 50 50

+ We set the drawing pen with *move* to position (10 30), that is 10 from the left and 30 from above. From there, we draw with *line* a line to position (50 50) - to the center of the drawing area.

+de Wir setzen mit *move* den Zeichenstift auf die Position (10 30), das ist 10 von links und 30 von oben. Von dort ziehen wir dann mit *line* eine Linie auf die Position (50 50) - zur Mitte der Zeichenfläche.

-

+ 🤔 Try to finish drawing the square!

+de 🤔 Versuche das Quadrat fertig zu zeichnen!

move 10 20
line 30 20
line 30 40

+ You can start the program with the *Run* button, with *Ctrl+R* or with *Shift+Enter*.

+de Das Programm kann mit dem *Run*-Button, mit *Strg+R* oder *Shift+Enter* gestartet werden.

-

+ With the command *rect* you can draw filled rectangles. The parameters specify the width and height.

+de Mit dem Befehl *rect* kann man gefüllte Rechtecke zeichnen. Die Parameter geben die Breite und die Höhe an.

+ *color* sets the drawing color. *color 900*, for example, is a rich red color.

+de *color* setzt die Zeichenfarbe. *color 900* ist zum Beispiel eine satte rote Farbe.

color 900
move 10 10
rect 20 20
# 
color 990
move 30 50
rect 50 30

+ There are 1000 possible colors - from 000 to 999, mixed from the primary colours red, green and blue. The left digit specifies the red component, the middle digit the green component and the right digit the blue component. These are some possible colors.

+de Es gibt 1000 mögliche Farben - und zwar von 000 bis 999. Die Farben werden dabei aus den Grundfarben Rot, Grün und Blau gemischt. Die linke Ziffer gibt den Rotanteil, die mittlere den Grünanteil und die rechte den Blauanteil an. Dies sind einige mögliche Farben.

##
col[] = [ 900 700 966 990 995 960 090 070 696 099 599 690 009 007 669 909 959 609 777 444 000 999 432 765 ]
textsize 6
for i range len col[]
  y = i mod 6 * 16.5
  x = i div 6 * 25
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

+ 🤔 Can you place a small green square at top right?

+de 🤔 Kannst du oben rechts ein kleines grünes Quadrat platzieren?

-

+ Drawing a house

+de Wir zeichnen ein Haus

move 5 5
textsize 8
text "MY HOUSE"
# fassad
color 993
move 15 55
rect 60 45
# roof
color 722
polygon [ 45 30 10 55 80 55 ]
# windows
color 444
move 25 60
rect 10 10
move 25 80
rect 10 10
move 55 60
rect 10 10

+ *text* writes a text to the drawing area. *polygon [x1 y1 x2 y2 ..]* draws a filled polygon, for example a triangle, with the specified coordinates.

+de *text* schreibt einen Text auf die Zeichenfläche. *polygon [x1 y1 x2 y2 ..]* zeichnet ein gefülltes Polygon, zum Beispiel ein Dreieck, mit den angegebenen Koordinaten.

+ The *#* character allows you to insert comments into the program.

+de Das *#*-Zeichen erlaubt es, Kommentare in das Programm einzufügen.

+ 🤔 Draw the missing door.

+ 🤔 If you want, you can use a blue background as a sky and let a sun shine.

+de 🤔 Zeichne die fehlende Tür.

+de 🤔 Wenn du willst, kannst du einen blauen Hintergrund als Himmel verwenden und eine Sonne scheinen lassen.

+ In *Trace* mode, you can watch the computer execute its instructions one by one.

+de Im *Trace*-Modus kannst du dem Computer zuschauen, wie er nacheinander seine Anweisungen ausführt.

-

+ The command *circle* draws a filled circle on the current position.

+ *linewidth* sets the line width. The lines are rounded at the ends.

+de Mit dem Befehl *circle* wird ein gefüllter Kreis an der aktuellen Position gezeichnet. 

+de *linewidth* stellt die Linienstärke ein. Die Linien sind an den Enden abgerundet.

move 10 20
circle 4
move 30 20
circle 6
# 
linewidth 3
move 10 40
line 30 40
#
linewidth 8
color 900
move 10 60
line 25 60
# 
color 333
move 10 80
line 15 80

+ 🤔 Draw this car.

+de 🤔 Zeichne dieses Auto.

##24
linewidth 8
color 333
move 29 6
line 33 6
color 900
move 24 11
line 38 11
color 333
move 25 17
circle 3.5
move 36 17
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

-

+ Strings are texts enclosed in quotation marks. The *&* character can be used to join strings. Numbers are thereby automatically converted to strings.

+de Zeichenketten (Strings) sind in Anführungszeichen eingeschlossene Texte. Mit dem *&*-Zeichen kann man Zeichenketten zusammenfügen. Zahlen werden dabei automatisch in Strings umgewandelt.

s = 5
a = s * s
print s & "² = " & a

-

+ A variable can easily be incremented by a value: *a = a + 1*

+de Eine Variable kann man ganz einfach um einen Wert erhöhen: *a = a + 1*

a = 1
a = a + 1
print a

* Conditional statement

*de Bedingte Anweisung

+ With *if* you can make the execution of actions dependent on a comparison. *end* marks the end of the dependent actions.

+de Mittels *if* kann man die Ausführung von Aktionen von einem Vergleich abhängig machen. *end* markiert das Ende der abhängigen Aktionen.

a = 7
a = 10 * a
if a > 20
  print "WOW!"
  print "a is large."
end
print "a: " & a

##
color 555
textsize 6
linewidth 0.5
y = 0
func cod n$ v v$ . .
  move 5 y + 2
  line 80 y + 2
  line 80 y + 22
  line 5 y + 22
  line 5 y + 2
  move 12 y + 7
  text n$
  move 52 y + 12
  if v >= 0
    text "a"
    move 59 y + 11
    line 72 y + 11
    line 72 y + 18.5
    line 59 y + 18.5
    line 59 y + 11
    move 62 y + 12
    text v
  else
    text v$
  .
  y += 25
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

+ 🤔 Write a program that adds up the numbers from 1 to 10. (Result: 55)

+de 🤔 Schreibe ein Programm, das die Quadratzahlen bis 10 ausgibt (1, 4, 9 ...). 

+de 🤔 Schreibe ein Programm, das die Zahlen von 1 bis 10 zusammenzählt. (Ergebnis: 55)

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

n = random 10 + 1
print "I chose a number between 1 and 10"
#
write "Guess: "
g = number input
write g
sleep 1
if g < n
  print " - is too low"
elif g > n
  print " - is too high"
else
  print " - great, you guessed the number"
end
sleep 1
print "The number was " & n

+ *random 10* returns a random number from 0 - 9. *input* reads a string from the keyboard, which is then converted to a number with *number*. *write* is like *print* except that after output it does not jump to a new line. *sleep 1* puts a pause of one second. *elif* is a combination of *else* and *if*.

+de *random 10* liefert eine Zufallszahl von 0 - 9. *input* liest einen String von der Tastatur ein, der dann mit *number*  in eine Zahl umgewandelt wird. *write* ist wie *print* nur dass nach der Ausgabe nicht in eine neue Zeile gesprungen wird. *sleep 1* legt eine Pause von einer Sekunde ein. *elif* ist eine Kombination von *else* und *if*.

+ 🤔 Just one try and that's it - it's no fun. You should be able to guess until you have guessed the number. For this you need .... - yeah right - a loop. Hint: *<>* stands for not equal.

+de 🤔 Nur ein Versuch und das war's - das macht keinen Spaß. Man sollte so lange raten können, bis man die Zahl erraten hat. Hierfür brauchst du .... - ja richtig - eine Schleife. Hinweis: *<>* steht für nicht gleich.

-

+ A simple pattern

+de Ein einfaches Muster

+ The waiting time in *sleep* is specified in seconds.

+de Die Wartezeit in *sleep* wird in Sekunden angegeben.

while i < 10
  color i * 10
  move 0 i * 10
  rect 100 10
  sleep 0.2
  i = i + 1
end

+ 🤔 Can you create another pattern using a loop?

+de 🤔 Kannst du ein anderes Muster mit Hilfe einer Schleife erstellen?

* Animation

*de Animation

+ A rolling ball - how does it work?

+ Draw the ball, wait briefly, clear the screen, move the position slightly, draw again, and so on. This creates the impression of movement.

+de Ein rollender Ball - wie funktioniert das?

+de Den Ball zeichnen, kurz warten, Bildschirm löschen, die Position leicht verändern, und wieder zeichnen, und so fort. So entsteht der Eindruck einer Bewegung.

color 900
x = -10
while x <= 110
  # clear the drawing area
  clear
  # draw the ball at position x
  move x 90
  circle 10
  # wait half a second
  sleep 0.5
  # change drawing position
  x = x + 5
end

+ 🤔 Try to make the animation smoother by increasing the x-position of the circle only by 1 or 0.5 each time and shortening the pause to the next frame.

+ 🤔 Stop the ball when it touches the right edge.

+ 🤔 Let the ball roll back again.

+ 🤔 Let the ball roll back and forth three times.

+de 🤔 Versuche, die Animation flüssiger zu machen, indem du die x-Position des Kreises jedes Mal nur um 1 oder 0,5 erhöhst und die Pause zum nächsten Bild verkürzt.

+de 🤔 Halte den Ball an, wenn er die rechte Kante berührt.

+de 🤔 Lass den Ball wieder zurückrollen.

+de 🤔 Lass den Ball dreimal hin und her rollen.

-

+ 🤔 Let the car drive

+de 🤔 Lass das Auto fahren

x = 0
linewidth 8
color 333
move x + 9 86
line x + 13 86
color 900
move x + 4 91
line x + 18 91
color 333
move x + 5 97
circle 3.5
move x + 16 97
circle 3.5

+ 🤔 Draw the house from above as background.

+de 🤔 Zeichne das Haus von oben als Hintergrund.

* Event-driven programming

*de Ereignisgesteuerte Programmierung

+ In event-driven programming, a program routine is executed when a specific event, such as pressing the mouse button, occurs.

+de Bei der ereignisgesteuerte Programmierung wird dann eine Programm-Routine ausgeführt, wenn ein bestimmtes Ereignis, wie das Drücken der Maustaste, auftritt.

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

+de Du kannst auch Tastatur-Ereignisse behandeln.

on key
  if keybkey = "r"
    color 900
  elif keybkey = "g"
    color 090
  else
    color 777
  end
  rect 100 100
  color 000
  text keybkey
end

+ 🤔 Use the keyboard keys to change the colors of the previous painting program!

+de 🤔 Verwende die Keyboard-Tasten, um die Farben des vorherigen Malprogramms zu ändern!

-

+ The *animate* event occurs after each screen refresh. Perfect for letting the car drive. Oops - something is missing!

+de Das *animate*-Ereignis tritt nach jeder Bildschirmaktualisierung auf. Perfekt, um das Auto fahren zu lassen. Ups... da fehlt etwas!

dir = 1
on animate
  if x > 79 or x < -1
    # change direction
    dir *= -1
  end
  clear
  # here is something missing
  move x + 5 97
  circle 3.5
  move x + 16 97
  circle 3.5
  x = x + 0.4 * dir
end

+ 🤔 Insert the missing code!

+ 🤔 Try to control the speed with the keyboard keys!

+de 🤔 Füge den fehlenden Code ein!

+de 🤔 Versuche mit den Keyboard-Tasten die Geschwindigkeit zu steuern!

* Array

*de Array (Feld)

+ We draw a starry sky. The position and magnitude (brightness) of the stars are generated randomly.

+de Wir zeichnen einen Sternenhimmel. Die Position und die Helligkeit der Sterne werden zufällig erzeugt.

color 000
rect 100 100
color 999
while i < 50
  x = random 100
  y = random 100
  mag = random 50
  move x y
  circle mag / 100
  i += 1
end

+ *random 100* returns a random integer from 0 to 99. *i += 1* is short for *i = i + 1*.

+de *random 100* liefert eine zufällige Ganzzahl von 0 bis 99. *i += 1* ist die Kurzform für *i = i + 1*.

-

+ Now let's draw a starry sky from a star map. For this we need something like a list. We use an *array* for this. The field elements can be accessed using square brackets and a position specification, also called index. The first element is at position 0, *len* returns the number of elements in the array.

+de Jetzt wollen wir einen Sternenhimmel nach einer Sternenkarte zeichnen. Dazu brauchen wir so etwas wie eine Liste. Wir verwenden dazu ein *Feld* (engl. *Array*). Auf die Feldelemente kann über eckige Klammern und eine Positionsangabe, auch Index genannt, zugegriffen werden. Das erste Element steht an der Position 0. *len* gibt die Anzahl der Elemente im Array zurück.

data[] = [ 4 7 1 13 8 ]
i = 0
while i < len data[]
  print i & ": " & data[i]
  i += 1
.

+ Back to the starry sky: the X and Y positions and the magnitudes of the stars are placed in one array each.

+de Zurück zum Sternenhimmel: Die X- und Y-Positionen und die Helligkeiten der Sterne stehen in jeweils einem Feld.

x[] = [ 7 81 86 76 50 55 23 77 17 23 16 93 91 13 27 44 29 93 1 53 26 38 35 23 54 85 33 87 7 13 2 20 18 ]
#
y[] = [ 87 71 50 85 35 58 9 76 8 81 14 52 63 42 5 75 83 87 69 61 56 68 28 39 79 64 6 25 34 48 89 8 28 ]
#
mag[] = [ 55 37 37 36 35 34 33 33 33 33 32 32 31 30 28 28 27 27 26 25 24 23 23 23 22 22 22 22 21 21 20 20 20 ]
#
color 000
rect 100 100
color 999
i = 0
while i < len x[]
  move x[i] y[i]
  circle mag[i] / 100
  i += 1
end

-

+ 🤔 On the starry sky you can see the constellation *Big Dipper*. If you draw connected lines through the stars 3, 7, 1, 25, 12, 11, 2 and 25 (position in the array), you can make it visible. The star at position 4 is the Pole Star (Polaris).

+de 🤔 Auf dem Sternenhimmel gibt es das Sternbild *Großer Wagen* zu sehen. Wenn man verbundene Linien durch die Sterne 3, 7, 1, 25, 12, 11, 2 and 25 (Position im Array) zieht, kann man es sichtbar machen. Der Stern an der Position 4 ist der Polarstern (Polaris).

+ 🤔 Connect the stars of the constellation *Cassiopeia*, which can easily be recognized by its W-shape. To find the indices of the stars, output them using *text i* when drawing the star map.

+de 🤔 Verbinde die Sterne des Sternbildes *Cassiopeia*, welches man leicht an seiner W-Form erkennen kann. Um die Indizes der Sterne zu ermitteln, gibst du diese beim Zeichnen der Sternkarte einfach mittels *text i* aus.

##
x[] = [ 7 81 86 76 50 55 23 77 17 23 16 93 91 13 27 44 29 93 1 53 26 38 35 23 54 85 33 87 7 13 2 20 18 ]
y[] = [ 87 71 50 85 35 58 9 76 8 81 14 52 63 42 5 75 83 87 69 61 56 68 28 39 79 64 6 25 34 48 89 8 28 ]
m[] = [ 55 37 37 36 35 34 33 33 33 33 32 32 31 30 28 28 27 27 26 25 24 23 23 23 22 22 22 22 21 21 20 20 20 ]
color 000
rect 100 100
color 999
for i range len x[]
  move x[i] y[i]
  circle m[i] / 100
.
textsize 3
move x[4] y[4]
text "Polaris"
color 444
linewidth 0.2
si[][] &= [ 3 7 1 25 12 11 2 25 ]
si[][] &= [ 10 8 6 14 26 ]
for s range len si[][]
  for i range len si[s][]
    h = si[s][i]
    if i = 0
      move x[h] y[h]
    else
      line x[h] y[h]
    .
  .
.

* Working with an array, sorting

*de Mit einem Array arbeiten, Sortieren

+ How can you find the smallest number in an array?

+ First take the first element as the smallest number. Then go through all the numbers and compare them to the current smallest number. If a number is smaller, it is the new smallest number.

+de Wie kann man die kleinste Zahl in einem Array finden?

+de Nimm zuerst das erste Element als kleinste Zahl. Gehe dann alle Zahlen durch und vergleiche sie mit der aktuellen kleinsten Zahl. Wenn eine Zahl kleiner ist, ist das die neue kleinste Zahl.

data[] = [ 44 72 55 26 27 4 99 7 ]
min = data[0]
i = 1
while i < len data[]
  if data[i] < min
    min = data[i]
  end
  i += 1
end
print min

+ 🤔 We now also want to know what the biggest number is.

+de 🤔 Wir wollen nun auch wissen, was die größte Zahl ist.

-

+ Now we want to put the smallest number on the first position. For this we additionally remember the position of the smallest element. Then we just have to copy the first element to the position of the smallest element and put the smallest number to the first position.

+de Nun wollen wir die kleinste Zahl auf die erste Position setzen. Dazu merken wir uns zusätzlich die Position des kleinsten Elements. Dann müssen wir nur noch das erste Element an die Position des kleinsten Elements kopieren und die kleinste Zahl an die erste Position setzen.

data[] = [ 44 72 55 26 27 4 99 7 ]
min = data[0]
min_pos = 0
i = 1
while i < len data[]
  if data[i] < min
    min = data[i]
    min_pos = i
  end
  i += 1
end
data[min_pos] = data[0]
data[0] = min
print data[]

-

+ 🤔 We can move the smallest element to the first place. With the same procedure we can move the smallest element starting from the second position to the second position. When we did that for all positions, the array is sorted.

+de 🤔 Wir können das kleinste Element an die erste Stelle befördern. Mit dem gleiche Verfahren können wir das kleinste Elemente ab der zweiten Stelle an die zweite Position bringen. Wann wir das für alle Positionen gemacht haben, ist das Array sortiert.

data[] = [ 44 72 55 26 27 4 99 7 ]
pos = 0
while pos < len data[] - 1
  # 
  # TODO: search minimum starting from
  #       pos and move it to pos
  #   
  pos += 1
end
print data[]`

