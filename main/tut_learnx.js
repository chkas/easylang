txt_locale = "de"
txt_tutor = String.raw`+ Learn programming II

+de Programmieren lernen II

-

+ This tutorial covers some advanced concepts such as strings, arrays, event-driven programming, and functions with local variables.

+de Dieses Tutorial behandelt einige fortgeschrittene Konzepte wie Strings, Arrays, ereignisgesteuerte Programmierung und Funktionen mit lokalen Variablen.

-

* Strings

*de Strings

+ Strings are texts enclosed in quotation marks.

+de Strings sind in Anführungszeichen eingeschlossene Texte.

print "What is your name?"
n$ = input
print "Hello " & n$

+ *input* reads a string from the keyboard.

+de *input* liest einen String von der Tastatur ein.

+ You can also store strings in variables. The variable name then ends with a *$* character. The *&* character can be used to join strings.

+de Du kannst auch Strings in Variablen speichern. Der Variablenname endet dann mit einem *$*-Zeichen. Mit dem *&*-Zeichen kann man Strings zusammenfügen.

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
elif g > n
   print " - is too high"
elif g = n
   print " - great, you guessed the number"
end
sleep 1
print "The number was " & n

+ *elif* is a combination of *else if*.

+de *elif* ist eine Kombination aus *else if*.

+ 🤔🤔 Just one try and that's it - it's no fun. You should be able to guess until you have guessed the number. For this you need .... - yeah right - a loop. Hint: *<>* stands for "not equal".

+de 🤔🤔 Nur ein Versuch und das war's - das macht keinen Spaß. Man sollte so lange raten können, bis man die Zahl erraten hat. Hierfür brauchst du .... - ja richtig - eine Schleife. Hinweis: *<>* steht für "nicht gleich".

* Starry sky

*de Sternenhimmel

+ In this *for-loop*, the inner block is run for all values for *i* from 1 to 5.

+de In dieser *for-Schleife* wird der innere Block für alle Werte für *i* von 1 bis 5 ausgeführt

for i = 1 to 5
   print i
end

+ With a *while-loop* you need more statements for this.

+de Mit einer *while-Schleife* braucht man dafür mehr Anweisungen.

i = 1
while i <= 5
   print i
   i += 1
end

+ We draw a starry sky. The position and magnitude (brightness) of the stars are generated randomly.

+de Wir zeichnen einen Sternenhimmel. Die Position und die Helligkeit der Sterne werden zufällig erzeugt.

gbackground 000
gclear
gcolor 999
for i = 1 to 50
   x = random 99
   y = random 99
   mag = random 50
   gcircle x y mag / 100
end

+ 🤔 You can create a confetti pattern by using a random color each time and drawing the circles larger.

+de 🤔 Du kannst ein Konfettimuster erstellen, indem du jedes Mal eine zufällige Farbe verwendest und die Kreise größer zeichnest.

* Array

*de Array (Feld)

+ Now let's draw a starry sky from a star map. For this we need something like a list.

+ We use an *array* for this. The field elements can be accessed using square brackets and a position specification, also called *index*. The first element is at position 1, *len* returns the number of elements in the array.

+de Jetzt wollen wir einen Sternenhimmel nach einer Sternenkarte zeichnen. Dazu brauchen wir so etwas wie eine Liste.

+de Wir verwenden dazu ein *Feld* (engl. *Array*). Auf die Feldelemente kann über eckige Klammern und eine Positionsangabe, auch *Index* genannt, zugegriffen werden. Das erste Element steht an der Position 1. *len* gibt die Anzahl der Elemente im Array zurück.

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
sysconf topleft
proc xrect x y w h .
   gline x y x + w y
   gline x + w y x + w y + h
   gline x + w y + h x y + h
   gline x y + h x y
.
gcolor 543
gtextsize 6
glinewidth 0.8
xrect 25 5 35 75
y = 10
proc dr ind v .
   gtext 31 y + 3 ind
   gtext 43 y + 3 v
   xrect 40 y 10 11
   y += 18
.
a[] = [ 3 7 2 8 ]
for i = 1 to len a[]
   dr i a[i]
.
gtextsize 9
gtext 4 10 "a[]"

+ How can we find the mean (average) of these numbers? The mean is the sum of all elements divided by the number of elements.

+ For these 4 numbers it is quite simple.

+de Wie kann man den Mittelwert (Durchschnitt) dieser Zahlen ermitteln? Der Mittelwert ist die Summe aller Elemente geteilt durch die Anzahl der Elemente.

+de Für diese 4 Zahlen ist das ganz einfach.

a[] = [ 3 7 2 8 ]
m = (a[1] + a[2] + a[3] + a[4]) / 4
print "Mean: " & m

+ 🤔 Try to find a solution that works also for arrays of other sizes.

+de 🤔 Versuche, eine Lösung zu finden, die auch für Arrays anderer Größen funktioniert.

-

+ Back to the starry sky: the X and Y positions and the magnitudes of the stars are placed in one array each.

+de Zurück zum Sternenhimmel: Die X- und Y-Positionen und die Helligkeiten der Sterne stehen in jeweils einem Feld.

x[] = [ 23 13 1 2 81 85 86 29 23 76 77 50 54 93 20 93 17 35 38 7 7 44 16 91 33 26 53 18 27 13 87 55 23 ]
#
y[] = [ 19 52 31 11 29 36 50 17 91 15 24 65 21 13 92 48 92 72 32 66 13 25 86 37 94 44 39 72 95 58 75 42 61 ]
#
mag[] = [ 33 21 26 20 37 22 36 27 33 35 33 35 22 27 20 32 33 23 23 21 55 28 32 31 22 24 25 20 28 30 22 34 23 ]
#
gbackground 000
gclear
gcolor 999
for i = 1 to len x[]
   gcircle x[i], y[i], mag[i] / 100
end

-

+ 🤔🤔 On the starry sky you can see the constellation *Big Dipper*. If you draw connected lines through the stars 10, 11, 5, 6, 7, 16, 24 and 6 (position in the array), you can make it visible. The star at position 12 is the Pole Star (Polaris).

+de 🤔🤔 Auf dem Sternenhimmel gibt es das Sternbild *Großer Wagen* zu sehen. Wenn man verbundene Linien durch die Sterne 10, 11, 5, 6, 7, 16, 24 und 6 (Position im Array) zieht, kann man es sichtbar machen. Der Stern an der Position 12 ist der Polarstern (Polaris).

+ 🤔🤔 Connect the stars of the constellation *Cassiopeia*, which can easily be recognized by its W-shape. To find the indices of the stars, output them using *gtext x y i* when drawing the star map.

+de 🤔🤔 Verbinde die Sterne des Sternbildes *Cassiopeia*, welches man leicht an seiner W-Form erkennen kann. Um die Indizes der Sterne zu ermitteln, gibst du diese beim Zeichnen der Sternkarte einfach mittels *gtext x y i* aus.

##
x[] = [ 7 81 86 76 50 55 23 77 17 23 16 93 91 13 27 44 29 93 1 53 26 38 35 23 54 85 33 87 7 13 2 20 18 ]
y[] = [ 13 29 50 15 65 42 91 24 92 19 86 48 37 58 95 25 17 13 31 39 44 32 72 61 21 36 94 75 66 52 11 92 72 ]
m[] = [ 55 37 37 36 35 34 33 33 33 33 32 32 31 30 28 28 27 27 26 25 24 23 23 23 22 22 22 22 21 21 20 20 20 ]
gbackground 000
gclear
gcolor 999
for i = 1 to len x[]
   gcircle x[i] y[i] m[i] / 100
.
gtextsize 3
gtext x[5] y[5] "Polaris"
gcolor 444
si[][] &= [ 4 8 2 26 13 12 3 26 ]
si[][] &= [ 11 9 7 15 27 ]
glinewidth 0.2
for s = 1 to len si[][]
   for i = 1 to len si[s][]
      h = si[s][i]
      if i > 1 : gline x0 y0 x[h] y[h]
      x0 = x[h]
      y0 = y[h]
   .
.

* Working with an array, sorting

*de Mit einem Array arbeiten, Sortieren

+ How can you find the smallest number in this array?

+ First take the first element as the smallest number. Then go through all the numbers and compare them to the current smallest number. If a number is smaller, it is the new smallest number.

+de Wie kann man die kleinste Zahl in diesem Array finden?

+de Nimm zuerst das erste Element als kleinste Zahl. Gehe dann alle Zahlen durch und vergleiche sie mit der aktuellen kleinsten Zahl. Wenn eine Zahl kleiner ist, ist das die neue kleinste Zahl.

a[] = [ 14 8 15 5 11 4 16 7 ]
min = a[1]
for i = 2 to len a[]
   if a[i] < min
      min = a[i]
   end
end
print min

+ 🤔 We now also want to know what the biggest number is.

+de 🤔 Wir wollen nun auch wissen, was die größte Zahl ist.

+ 🤔🤔 The brightest star in the star map is called “Vega”. Try to find it and label it - with program code, of course.

+de 🤔🤔 Der hellste Stern auf der Sternkarte heißt “Vega”. Versuche, ihn zu finden und zu beschriften - natürlich mit Programmcode.

-

+ Now we want to put the smallest number in the first position. To do this, we go through all the elements starting from the second position. And if an element is smaller than the one at the first position, we swap the two elements.

+de Nun wollen wir die kleinste Zahl an die erste Stelle setzen. Dazu gehen wir alle Elemente ab der zweiten Position durch. Und wenn ein Element kleiner ist als das an der ersten Position, vertauschen wir die beiden Elemente.

a[] = [ 14 8 15 5 11 4 16 7 ]
for i = 2 to len a[]
   if a[i] < a[1]
      tmp = a[1]
      a[1] = a[i]
      a[i] = tmp
   end
end
print a[]

+ To swap two values, you can also use *swap a b*.

+de Um zwei Werte zu tauschen, kannst du auch *swap a b* verwenden.

-

+ 🤔🤔 We can move the smallest element to the first place. With the same procedure we can move the smallest element starting from the second position to the second position. When we did that for all positions, the array is sorted.

+de 🤔🤔 Wir können das kleinste Element an die erste Stelle befördern. Mit dem gleiche Verfahren können wir das kleinste Elemente ab der zweiten Stelle an die zweite Position bringen. Wann wir das für alle Positionen gemacht haben, ist das Array sortiert.

a[] = [ 44 72 55 26 27 4 99 7 ]
for pos = 1 to len a[] - 1
   #
   # TODO: move minimum to pos starting from pos + 1
   #
end
print a[]

* Now let's do the same with strings.

*de Nun machen wir dasselbe mit Strings.

s$ = input
while s$ != ""
   a$[] &= s$
   s$ = input
end
print a$[]
#
for i = 2 to len a$[]
   if strcmp a$[i] a$[1] < 0
      swap a$[1] a$[i]
   end
end
print a$[]
#
input_data
Trudy
Bob
Thomas
Alice
Sandra

+de Mit *input_data* kann man einen beliebigen Textbereich definieren, aus dem ich dann mit *input* die Strings zeilenweise lesen kann.

+With *input_data* you can define any text area from which you can then read the strings line by line using “input.”

+de Mit *&=* kann man ein Element an ein Array anhängen.

+de Mit *strcmp* kann man zwei Zeichenfolgen lexikografisch vergleichen. Ist das Ergebnis kleiner als 0, ist die erste Zeichenfolge lexikografisch kleiner; ist es 0, sind sie gleich; andernfalls ist sie größer.

+ With *&=*, you can append an element to an array.

+ With *strcmp*, you can compare two strings lexicographically. If the result is less than 0, the first string is lexicographically smaller; if it is 0, they are equal; otherwise, it is larger.

+ 🤔🤔 Display the names in sorted order.

+de 🤔🤔 Zeige die Namen in sortierter Reihenfolge an.

* Other useful functions

*de Weitere nützliche Funktionen

+ With *gcolor3* you can set the character color more precisely. The function has the brightness of the three primary colors red, green and blue as parameters, which are specified as floating point values from 0 to 1.

+de Mit *gcolor3* kann man die Zeichenfarbe genauer einstellen. Die Funktion hat die Helligkeit der drei Grundfarben Rot, Grün und Blau als Parameter, die als Gleitkommawerte von 0 bis 1 angegeben werden.

for i = 0 to 100
   gcolor3 i / 100 0 0
   gline 0 i 100 i
end

-

+ With *randomf* you get a random floating point number between 0 and 1. This simplifies the drawing of the starry sky.

+de Mit *randomf* bekommt man eine zufälligen Gleitkommazahl zwischen 0 und 1. Das vereinfacht das Zeichnen des Sternenhimmels.

gbackground 000
gclear
gcolor 999
for i = 1 to 100
   x = randomf * 100
   y = randomf * 100
   gcircle x y randomf * 0.3
end

* Event-driven programming

*de Ereignisgesteuerte Programmierung

+ In event-driven programming, a program routine is executed when a specific event, such as pressing the mouse button, occurs.

+de Bei der ereignisgesteuerten Programmierung wird dann eine Programm-Routine ausgeführt, wenn ein bestimmtes Ereignis, wie das Drücken der Maustaste, auftritt.

+ We create a simple painting program.

+de Wir erstellen ein einfaches Malprogramm.

glinewidth 4
gcolor 900
#
on mouse_down
   down = 1
   mx = mouse_x
   my = mouse_y
   gcircle mx my 2
end
on mouse_up
   down = 0
end
on mouse_move
   if down = 1
      gline mx my mouse_x mouse_y
      mx = mouse_x
      my = mouse_y
   end
end

+ The *mouse* events are triggered after the corresponding mouse actions. *mouse_x* and *mouse_y* return the mouse position.

+de Die *mouse*-Ereignisse werden nach den entsprechenden Maus-Aktionen ausgelöst. *mouse_x* und *mouse_y* liefern die Maus-Position.

+ The computer runs an internal event loop that constantly checks whether a relevant event occurs.

+de Der Computer führt eine interne Ereignisschleife aus, die ständig überprüft, ob ein relevantes Ereignis auftritt.

-

+ You can also handle keyboard events.

+de Du kannst auch Tastatur-Ereignisse verarbeiten.

on key_down
   if keybkey = "r"
      gbackground 900
   elif keybkey = "g"
      gbackground 090
   else
      gbackground 777
   end
   gclear
   gtext 5 90 keybkey
end

+ 🤔 Use the keyboard keys to change the drawing color of the previous painting program!

+de 🤔 Verwende die Keyboard-Tasten, um die Zeichen-Farbe des vorherigen Malprogramms zu ändern!

-

+ The *animate* event occurs after each screen refresh - usually 60 times per second. Perfect for animating a bouncing ball. Oops... the ball disappears!

+de Das *animate*-Ereignis tritt nach jeder Bildschirmaktualisierung auf - normalerweise 60 mal pro Sekunde. Perfekt, um einen abprallenden Ball zu animieren. Ups... der Ball verschwindet!

x = 50
y = 50
vx = 1
vy = 0.8
gcolor 700
#
on animate
   gclear
   gcircle x y 10
   x += vx
   y += vy
   if x > 90
      vx = -vx
   end
end

+ 🤔 Let the ball bounce off all the walls.

+ 🤔 Let the car drive back and forth! The car should be able to be stopped and restarted with a mouse click.

+ 🤔🤔 Try to control the speed of the car with the keyboard keys!

+de 🤔 Lass den Ball an allen Wänden abprallen.

+de 🤔 Lass das Auto hin und her fahren! Das Auto sollte mit einem Mausklick angehalten und neu gestartet werden können.

+de 🤔🤔 Versuche mit den Keyboard-Tasten die Geschwindigkeit des Autos zu steuern!

*de Prozeduren, lokale Variablen, Parameter

* Procedures, local variables, parameters

+de Bauen wir eine Straße für unser Auto.

+ Let's build a street for our car.

gbackground 060
subr street
   gcolor 777
   grect 0 10 100 10
end
subr car
   glinewidth 8
   gcolor 333
   gline x + 9, 25, x + 13, 25
   gcolor 900
   gline x + 4, 20, x + 18, 20
   gcolor 333
   gcircle x + 5, 14, 3.5
   gcircle x + 16, 14, 3.5
end
#
x = -10
while x <= 100
   gclear
   street
   car
   sleep 0.05
   x += 1
end

+de Funktioniert wunderbar. Jetzt malen wir noch eine unterbrochene Mittellinie auf die Strasse. Das macht man am besten mit einer Schleife.

+ Works perfectly. Now let's paint a dashed center line on the street. This is best done with a loop.

gbackground 060
subr street
   gcolor 777
   grect 0 10 100 10
   # dashed centerline
   gcolor 999
   glinewidth 1
   x = 2
   while x < 110
      gline x, 15, x + 7, 15
      x += 12
   end
end
subr car
   glinewidth 8
   gcolor 333
   gline x + 9, 25, x + 13, 25
   gcolor 900
   gline x + 4, 20, x + 18, 20
   gcolor 333
   gcircle x + 5, 14, 3.5
   gcircle x + 16, 14, 3.5
end
#
x = -10
while x <= 100
   gclear
   street
   car
   sleep 0.05
   x += 1
end

+de Schön sieht sie aus, die neue Straße. Aber warum fährt das Auto nicht mehr?

+ Looks nice, the new street. But why is the car no longer driving?

+de Das Problem liegt bei der Variablen *x*. Die aktuelle Autoposition wird in dieser Variablen gespeichert. Beim Zeichnen der Mittellinie wird sie jedoch überschrieben.

+ The problem lies with the variable *x*. The current car position is stored in this variable. However, it is overwritten when the center line is drawn.

+de Mit *proc street .* kann man nun eine Prozedur definieren, in der die Variablen nur innerhalb der Prozedur gültig sind. Das bedeutet, dass die Variable *x* innerhalb von *proc* eine andere Variable ist als die Variable *x* für die Position des Autos.

+ With *proc street .* you can define a procedure in which the variables are only valid within the procedure. This means that the variable *x* within *proc* is a different variable than the variable *x* for the position of the car.

+de Wie kann man dann der Prozedur Werte liefern, wenn die Variablen nur *lokal* (innerhalb der Prozedur) gültig sind?

+ How can you then supply values to the procedure if the variables are only valid *locally* (within the procedure)?

+de Man kann dies mit Parametern tun. Die Parameter werden direkt nach dem Prozedurnamen angegeben.

+ You can do this with parameters. The parameters are specified directly after the procedure name.

gbackground 060
proc street .
   gcolor 777
   grect 0 10 100 10
   # dashed centerline
   gcolor 999
   glinewidth 1
   x = 2
   while x < 110
      gline x, 15, x + 7, 15
      x += 12
   end
end
proc car x .
   glinewidth 8
   gcolor 333
   gline x + 9, 25, x + 13, 25
   gcolor 900
   gline x + 4, 20, x + 18, 20
   gcolor 333
   gcircle x + 5, 14, 3.5
   gcircle x + 16, 14, 3.5
end
#
x = -10
while x <= 100
   gclear
   street
   car x
   sleep 0.05
   x += 1
end

+de Wir können auch einen Parameter für die y-Position der Straße und des Autos und einen für die Farbe des Autos angeben. Jetzt können wir zwei Autos mit unterschiedlichen Farben auf zwei Straßen fahren lassen.

+ We can also specify one parameter for the y-position of the street and the car and one for the color of the car. Now we can have two cars with different colors driving on two streets.

gbackground 060
proc street y .
   gcolor 777
   grect 0 y 100 10
   gcolor 999
   glinewidth 1
   x = 2
   while x < 110
      gline x, y + 5, x + 7, y + 5
      x += 12
   end
end
proc car x y col .
   glinewidth 8
   gcolor 333
   gline x + 9, y + 15, x + 13, y + 15
   gcolor col
   gline x + 4, y + 10, x + 18, y + 10
   gcolor 333
   gcircle x + 5, y + 4, 3.5
   gcircle x + 16, y + 4, 3.5
end
#
x = -10
while x <= 125
   gclear
   street 10
   street 25
   car 100 - x, 25, 990
   car x 10 900
   sleep 0.05
   x += 1
end

*de Ein Array für die Positionen vieler Autos

* An array for the positions of many cars

+de Wir wollen gleichzeitig mehrere Autos fahren lassen. Dazu wird die aktuelle Position jedes Autos in einem Array gespeichert. Außerdem werden die Fahrtrichtung und die Wagenfarbe gespeichert.

+de Autos werden mit einer bestimmten Wahrscheinlichkeit auf die Straße platziert. Es muss noch geprüft werden, ob ein anderes Auto zu nah ist.

+de Die Wagenfarbe wird zufällig aus einer Farbpalette ausgewählt.

+ Let's drive several cars at the same time. To do this, the current position of each car is stored in an array. The movement direction and the car color are also stored.

+ Cars are placed on the road with a certain probability. It is still necessary to check whether another car is too close.

+ The car color is randomly selected from a color palette.

proc draw_street y .
   gcolor 777
   grect 0 y 100 10
   gcolor 999
   glinewidth 1
   x = 2
   while x < 110
      gline x, y + 5, x + 7, y + 5
      x += 12
   end
end
proc draw_backgr .
   # meadow
   gcolor 050
   grect 0 0 100 60
   # sky
   gcolor 259
   grect 0 60 100 40
   # sun
   gcolor 995
   gcircle 75 85 6
   # streets
   draw_street 10
   draw_street 25
end
proc draw_car x y col .
   glinewidth 8
   gcolor 333
   gline x + 9, y + 15, x + 13, y + 15
   gcolor col
   gline x + 4, y + 10, x + 18, y + 10
   gcolor 333
   gcircle x + 5, y + 4, 3.5
   gcircle x + 16, y + 4, 3.5
end
#
# color palette
colors[] = [ 900 990 090 009 000 999 666 099 ]
# maximum 10 cars on the streets
n = 10
# car
len x[] n
len y[] n
len dir[] n
len col[] n
#
# the two streets
street_x[] = [ -20 100 ]
street_y[] = [ 10 25 ]
street_dir[] = [ 1 -1 ]
#
carind = 1
#
on animate
   # create a new car from time to time
   if random 1000 < 20
      # choose street
      street = random 2
      y = street_y[street]
      x = street_x[street]
      # is street free
      free = 1
      for i = 1 to n
         if y[i] = y and abs (x[i] - x) < 30
            free = 0
         end
      end
      if free = 1
         x[carind] = x
         y[carind] = y
         dir[carind] = street_dir[street]
         col[carind] = colors[random len colors[]]
         carind += 1
         if carind > n
            carind = 1
         end
      end
   end
   #
   draw_backgr
   # draw all cars
   for i = 1 to n
      if dir[i] <> 0
         # car is on the street
         draw_car x[i] y[i] col[i]
         x[i] += dir[i]
      end
   end
end
`
