txt_locale = "de"
txt_tutor = String.raw`+ Learn programming 1

+de Programmieren lernen 1

-

+ When programming, you tell the computer what to do with a sequence of special commands.

+de Beim Programmieren sagst du dem Computer mit einer Folge von speziellen Befehlen, was er machen soll.

##19
#
x = 20
glinewidth 8
gcolor 333
gline x + 9 96 x + 13 96
gcolor 900
gline x + 4 91 x + 18 91
gcolor 333
gcircle x + 5 85 3.5
gcircle x + 16 85 3.5

+ You can tell the computer to draw two thick round lines in different colors at certain positions and then two black circles - and there you have a car on the screen.

+ If this is done repeatedly with a short pause at slightly shifted positions, the car will drive. How to program this and other things you can learn here.

+de Man kann den Computer anweisen, zwei dicke runde Striche in verschiedenen Farben an bestimmten Positionen zu zeichnen und dann noch zwei schwarze Kreise  - und schon hat man ein Auto auf dem Bildschirm.

+de Wenn dies wiederholend mit einer kurzen Pause bei leicht verschobenen Positionen gemacht wird, fährt das Auto. Wie man dies und andere Dinge programmiert, erfährst du hier.

* Graphics

*de Grafik

+ First we look at the commands that can be used to create graphics on the screen.

+de Zuerst schauen wir uns die Befehle an, mit denen Grafiken auf dem Bildschirm erstellt werden können.

gcircle 10 30 1
gcircle 50 50 1

+ We draw a small circle (size 1) at the position (10 30), which is 10 from the left and 30 from the bottom, and one at the position (50 50) - this is in the middle of the drawing area.

+de Wir zeichnen einen kleinen Kreis (Größe 1) an der Position (10 30), das ist 10 von links und 30 von unten, und einen an der Position (50 50) - das ist in der Mitte der Zeichenfläche.

+ Then we connect these two points with a line.

+de Dann verbinden wir diese beiden Punkte mit einer Linie.

gcircle 10 30 1
gcircle 50 50 1
gline 10 30 50 50

##
gcolor 555
gtextsize 4
gtext 6 5 "0/0"
gtext 82 5 "100/0"
gtext 82 91.5 "100/100"
gtext 6 91.5 "0/100"
glinewidth 0.5
x = 10
while x <= 90
   gline x 10 x 90
   gline 10 x 90 x
   x += 8
.
gtext 12 28 "10/30"
gtext 44 52 "50/50"
gcolor 833
gcircle 18 34 1.2
gcircle 50 50 1.2
glinewidth 1
gline 18 34 50 50

+ The drawing area is 100 times 100 units. The origin is bottom left. The first value (the X coordinate) is the distance from the left edge, the second value (the Y coordinate) is the distance from the bottom edge.

+de Die Zeichenfläche beträgt 100 mal 100 Einheiten. Der Ursprung ist links unten. Der erste Wert (die X-Koordinate) ist der Abstand vom linken Rand, der zweite Wert (die Y-Koordinate) ist der Abstand vom unteren Rand.

-

+ *drawgrid* draws a grid. This makes it easier to determine the x and y positions for the graphics commands. In the finished program you can then omit this command.

+ 🤔 Try to finish drawing the square!

+de *drawgrid* zeichnet ein Raster. Damit lassen sich die x- und y-Positionen für die Grafikbefehle leichter bestimmen. Im fertigen Programm kannst du diesen Befehl dann weglassen.

+de 🤔 Versuche das Quadrat fertig zu zeichnen!

drawgrid
gline 10 20 30 20
gline 30 20 30 40

+ You can start the program with the *Run* button, with *Ctrl+R* or with *Shift+Enter*.

+de Das Programm kann mit dem *Run*-Button, mit *Strg+R* oder *Shift+Enter* gestartet werden.

-

+ With the command *grect* you can draw filled rectangles. The parameters specify the *x* and *y* position, the *width* and the *height*.

+ Most graphic commands begin with a *g* for *graphic*, so *grect* therefore stands for *graphic rectangle*.

+de Mit dem Befehl *grect* kann man gefüllte Rechtecke zeichnen. Die Parameter geben die *x*- und *y*-Position, die *Breite* und die *Höhe* an.

+de Die meisten Grafikbefehle beginnen mit einem *g* für *Grafik*, *grect* steht also für *Grafisches Rechteck*.

gcolor 900
grect 10 20 50 30

##
gcolor 555
gtextsize 4
gtext 6 5 "0/0"
gtext 82 5 "100/0"
gtext 82 91.5 "100/100"
gtext 6 91.5 "0/100"
glinewidth 0.5
x = 10
while x <= 90
   gline x 10 x 90
   gline 10 x 90 x
   x += 8
.
gtext 12 22 "10/20"
gcolor 833
grect 18 26 40 24
gcolor 555
gcircle 18 26 1
gtext 35 22 "50"
gtext 59 37 "30"

+ *gcolor* sets the drawing color. *900*, for example, is red, *990* yellow and *444* grey.

+de *gcolor* setzt die Zeichenfarbe. *900* ist zum Beispiel rot, *990* gelb und *444* grau.

gcolor 990
gcircle 70 80 10
#
gcolor 444
grect 10 5 40 30

+ There are 1000 possible colors - from 000 to 999, mixed from the primary colours red, green and blue. The left digit specifies the red component, the middle digit the green component and the right digit the blue component. These are some possible colors.

+de Es gibt 1000 mögliche Farben - und zwar von 000 bis 999. Die Farben werden dabei aus den Grundfarben Rot, Grün und Blau gemischt. Die linke Ziffer gibt den Rotanteil, die mittlere den Grünanteil und die rechte den Blauanteil an. Dies sind einige mögliche Farben.

##84
col[] = [ 900 700 966 990 995 960 090 070 696 099 599 690 009 007 669 909 959 609 777 444 000 999 432 765 ]
gtextsize 7
for i to len col[]
   y = 100 - (i - 1) mod 6 * 14 - 14
   x = (i - 1) div 6 * 22
   gcolor col[i]
   grect x y 21 13
   s$ = col[i]
   if col[i] <= 9
      s$ = "00" & s$
   elif col[i] <= 99
      s$ = "0" & s$
   .
   gcolor 000
   if col[i] = 0 or col[i] = 432 : gcolor 888
   gtext x + 4 y + 4 s$
.

+ 🤔 Draw a dark green square in the lower right area. Dark green is not present in the color palette shown. You can just take a green and lower the green component - the middle digit of the number.

+de 🤔 Zeichne ein dunkelgrünes Quadrat im unteren rechten Bereich. Dunkelgrün ist in der abgebildeten Farbpalette nicht vorhanden. Du kannst einfach ein Grün nehmen und die Grün-Komponente - die mittlere Ziffer der Zahl - verringern.

-

+ The *tab* key - normally found to the left of the *Q* - helps you to complete commands. For example, to write *gcircle*, simply enter *g* or *gc* and then press the tab key repeatedly until *gcircle* appears on the screen.

+de Die *Tab*-Taste - normalerweise links neben dem *Q* zu finden - hilft dir dabei, Befehle zu vervollständigen. Um zum Beispiel *gcircle* zu schreiben, gib einfach *g* oder *gc* ein und drücke dann wiederholt die Tab-Taste, bis *gcircle* auf dem Bildschirm erscheint.

-

+ Drawing a house

+de Wir zeichnen ein Haus

# My house
gcolor 993
grect 20 0 60 45
# roof
gcolor 722
gpolygon [ 50 70 15 45 85 45 ]
# windows
gcolor 444
grect 30 10 10 10
grect 30 30 10 10
grect 60 30 10 10
# text
gtextsize 8
gtext 5 85 "MY HOUSE"

+ *gtext* writes a text at the specified position on the drawing area. *gpolygon [x1 y1 x2 y2 ..]* draws a filled polygon, for example a triangle, with the specified coordinates.

+de *gtext* schreibt einen Text an die angegebene Position auf der Zeichenfläche. *gpolygon [x1 y1 x2 y2 ..]* zeichnet ein gefülltes Polygon, zum Beispiel ein Dreieck, mit den angegebenen Koordinaten.

+ The *#* character allows you to insert comments into the program.

+de Das *#*-Zeichen erlaubt es, Kommentare in das Programm einzufügen.

+ 🤔 Draw the missing door. With the help of *drawgrid* it is easier to find the right positions.

+ 🤔🤔 You can use a blue background as a sky and let a sun (*gcircle*) shine.

+de 🤔 Zeichne die fehlende Tür. Mit Hilfe von *drawgrid* ist es einfacher, die richtigen Positionen zu finden.

+de 🤔🤔 Du kannst einen blauen Hintergrund als Himmel verwenden und eine Sonne (*gcircle*) scheinen lassen.

+ In *Debug* mode, you can watch the computer execute its instructions one by one.

+de Im *Debug*-Modus kannst du dem Computer zuschauen, wie er nacheinander seine Anweisungen ausführt.

-

+ The command *gcircle* draws a filled circle at the specified position with the specified radius.

+ *glinewidth* sets the line width. The lines are rounded at the ends.

+de Der Befehl *gcircle* zeichnet einen gefüllten Kreis an der angegebenen Position mit dem angegebenen Radius.

+de *glinewidth* stellt die Linienstärke ein. Die Linien sind an den Enden abgerundet.

gcircle 10 80 2
#
gcolor 990
gcircle 60 80 8
#
gcolor 060
glinewidth 2
gline 15 60 40 80
#
glinewidth 10
gcolor 900
gline 10 40 25 40
#
gcolor 333
gline 50 50 55 50

-

+ Now we can build a car using these parts.

+de Mit diesen Teilen können wir jetzt ein Auto bauen..

glinewidth 8
gcolor 333
gline 9 14 13 14
gcolor 900
gline 4 9 18 9
gcolor 333
gcircle 5 3 3.5

+ 🤔 Something is missing ...

+de 🤔 Da fehlt noch was ...

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

##
gcolor 543
gtextsize 6
glinewidth 0.5
y = 75
proc xrect x y w h .
   gline x y x + w y
   gline x + w y x + w y + h
   gline x + w y + h x y + h
   gline x y + h x y
.
proc cod n$ v v$ .
   xrect 5 y + 2 75 20
   gtext 12 y + 11 n$
   if v >= 0
      gtext 52 y + 7 "a"
      xrect 59 y + 6 13 7.5
      gtext 62 y + 8 v
   else
      gtext 52 y + 7 v$
   .
   y -= 25
.
cod "a ← 7 " 7 ""
cod "a ← 9 * a " 63 ""
cod "a > 20 ?" -1 "YES"
cod "\"a is large\"" -1 ""

-

+ The block after *else* is executed if the condition is not fulfilled.

+de Der Block nach *else* wird ausgeführt, wenn die Bedingung nicht erfüllt ist.

a = random 10
b = random 10
print "What is " & a & " * " & b & " ?"
x = number input
print x
if a * b = x
   print "Thats wright 🙂"
else
   print "Thats wrong 🙁"
end

+ *random 10* returns a random number from 1 to 10. *number input* reads a number from the keyboard.

+de *random 10* liefert eine zufällige Zahl von 1 bis 10. *number input* liest eine Zahl von der Tastatur ein.

* Loop

*de Schleife

+ *while* works similar to *if*, except that the conditional actions are executed again and again as long as the condition is fulfilled. This is called a *loop*.

+de *while* funktioniert ähnlich wie *if*, nur dass die bedingten Aktionen immer wieder ausgeführt werden, solange die Bedingung erfüllt ist. Das nennt man eine *Schleife*.

i = 1
while i <= 4
   print i
   i = i + 1
end

+ 🤔 Write a program that outputs the square of the numbers 1 to 10 (1, 4, 9 ...).

+ 🤔🤔 Write a program that adds up the numbers from 1 to 10. (Result: 55)

+de 🤔 Schreibe ein Programm, das das Quadrat der Zahlen 1 bis 10 ausgibt (1, 4, 9 ...).

+de 🤔🤔 Schreibe ein Programm, das die Zahlen von 1 bis 10 zusammenzählt. (Ergebnis: 55)

-

gline 10 10 90 10
gline 10 20 90 20
gline 10 30 90 30
gline 10 40 90 40
gline 10 50 90 50
gline 10 60 90 60
gline 10 70 90 70
gline 10 80 90 80
gline 10 90 90 90

+ 🤔 Quite a lot of code. The lines of code appear repeatedly in a very similar form. You can certainly shorten the code using a loop.

+ 🤔 Create a box pattern with additional vertical lines.

+de 🤔 Ziemlich viel Code. Die Codezeilen erscheinen wiederholt in sehr ähnlicher Form. Du kannst den Code sicherlich mit einer Schleife kürzer machen.

+de 🤔 Erzeuge mit zusätzlichen vertikalen Linien ein Kästchenmuster.

+ 🤔🤔 Can you create this pattern? With a loop you only need a few lines of code.

+de 🤔🤔 Kannst du dieses Muster erzeugen? Mit einer Schleife brauchst du dazu nur ein paar Zeilen Code.

##
gcolor 555
glinewidth 0.7
while i <= 100
   gline i 0 100 i
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

+ With a loop within a loop (nested loop) you can make even more interesting patterns.

+de Mit einer Schleife innerhalb einer Schleife (verschachtelte Schleife) kannst du noch interessantere Muster erzeugen.

gbackground 477
gclear
y = 5
while y < 100
   x = 5
   while x < 100
      gcircle x y 2.5
      sleep 0.02
      x += 10
   end
   y += 10
end

+ With each loop cycle of the outer loop, the inner loop is executed completely. *x += 10* is short for *x = x + 10* and means: increment *x* by 10.

+de Mit jedem Schleifenzyklus der äußeren Schleife wird die innere Schleife vollständig ausgeführt. *x += 10* ist die Kurzform für *x = x + 10* und bedeutet: erhöhe *x* um 10.

+ With *gbackground* you can set the color that *gclear* uses when clearing the drawing area. *sleep 0.02* puts a pause of 0.02 seconds.

+de  Mit *gbackground* kannst du die Farbe festlegen, die *gclear* beim Löschen der Zeichenfläche verwendet. *sleep 0.02* legt eine Pause von 0.02 Sekunden ein.

+ 🤔 Change the program a little to make the pattern even more beautiful.

+de 🤔 Verändere das Programm ein wenig, um das Muster noch schöner zu machen.

* Animation

*de Animation

+ A rolling ball - how does it work?

+ Draw the ball, wait briefly, clear the screen, move the position slightly, draw again, and so on. This creates the impression of movement.

+de Ein rollender Ball - wie funktioniert das?

+de Den Ball zeichnen, kurz warten, Bildschirm löschen, die Position leicht verändern, und wieder zeichnen, und so fort. So entsteht der Eindruck einer Bewegung.

gcolor 900
x = -9
while x < 120
   # clear the drawing area
   gclear
   # draw the ball at position x
   gcircle x 10 10
   # wait half a second
   sleep 0.5
   # change drawing position
   x += 5
end

+ 🤔 Try to make the animation smoother by increasing the x-position of the circle only by 1 or 0.5 each time and shortening the pause to the next frame.

+de 🤔 Versuche, die Animation flüssiger zu machen, indem du die x-Position des Kreises jedes Mal nur um 1 oder 0.5 erhöhst und die Pause zum nächsten Bild verkürzt.

-

+ Now we draw a car instead of the ball.

+de Jetzt zeichnen wir statt dem Ball ein Auto.

subr drawcar
   glinewidth 8
   gcolor 333
   gline x + 9, 14, x + 13, 14
   gcolor 900
   gline x + 4, 9, x + 18, 9
   gcolor 333
   gcircle x + 5, 3, 3.5
   gcircle x + 16, 3, 3.5
end
#
x = -25
while x < 120
   gclear
   drawcar
   sleep 0.02
   x += 0.5
end

+ With *subr* you can combine actions that can be called from different places. This is called a *subroutine*.

+de Mit *subr* können Aktionen zusammengefasst werden, die von verschiedenen Stellen aus aufgerufen werden können. Das nennt man *Unterprogramm* oder *Subroutine*.

+ A comma can be used to separate the parameters of *gline* and *gcircle*. This is not necessary, but makes the code easier to read.

+de Mit einem Komma kann man die Parameter von *gline* und *gcircle* trennen. Dies ist nicht notwendig, macht den Code aber leichter lesbar.

+ 🤔 Stop the car when it touches the right edge.

+ 🤔🤔 Let the car move back again.

+de 🤔 Halte das Auto an, wenn es die rechte Kante berührt.

+de 🤔🤔 Lass das Auto wieder zurückfahren.

+ 🤔🤔 Let the car move back and forth three times.

+de 🤔🤔 Lass das Auto dreimal hin und her fahren.

+ 🤔🤔 Draw the house from above as background.

+de 🤔🤔 Zeichne das Haus von oben als Hintergrund.

-

+ With *proc* or *func* you can also create *procedures* or *functions* with parameters and local variables. This will be discussed in more detail later.

+de Mit *proc* oder *func* kann man auch *Prozeduren* oder *Funktionen* mit Parametern und lokalen Variablen erstellen. Darauf wird später noch näher eingegangen.
`
