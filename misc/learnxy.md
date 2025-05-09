---
language: Easylang
contributors:
    - ["chkas", "https://github.com/chkas"]
filename: easylang.el
---

**Easylang** is a simple programming language with built-in graphical functions and an easy-to-use and browser IDE. Its simplified syntax and semantics make it well suited as a teaching and learning programming language. You can also use it to write graphical applications that you can embed in a web page.

*Easylang* is statically typed and has as data types only strings and numbers (floating point), resizeable arrays of strings and numbers and arrays of arrays.

[The browser IDE](https://easylang.online/ide/) includes various tutorials, including one for beginners.

```
print "Hello Easylang"
#
f = 2 * pi
print "Numbers are floating point: " & f
print "and are implicitly converted to strings"
#
str$ = "Strings can"
str$ &= " grow"
print str$
#
# Blocks end with 'end' or a dot, newline is just a token seperator
#
for i = 1 to 3
   print i * i
.
func gcd a b .
   # a and b are value parameters
   while b <> 0
      # h is local, since it is first used in the function
      h = b
      b = a mod b
      a = h
   .
   return a
.
print "The greatest common divisor of 182 and 28: " & gcd 182 28
#
func gcdr a b .
   if b = 0 : return a
   return gcdr b (a mod b)
.
print "Recursively calculated: " & gcd 182 28
#
# Arrays are 1-based and can grow
#
a[] = [ 13 3.14 3 ]
a[] &= 4
for i = 1 to len a[] : write a[i] & " "
print ""
#
proc sort &data[] .
   # a reference parameter
   for i = 1 to len data[] - 1
      for j = i + 1 to len data[]
         if data[j] < data[i] : swap data[j] data[i]
      .
   .
.
sort a[]
print "Sorted: " & a[]
#
# arrays, strings and numbers are copied by value
#
b[] = a[]
a[4] = 77
print a[] & b[]
#
# array swapping ist fast
#
swap a[] b[]
print a[] & b[]
#
# for-in iterates over the elements of an array
#
fruits$[] = [ "apple" "banana" "orange" ]
for fruit$ in fruits$[] : print fruit$
#
# strings are also used for single characters
#
letters$[] = strchars "ping"
print letters$[]
letters$[2] = "o"
print strjoin letters$[] ""
#
# a 2-dimensional array is an array of arrays
#
len a[][] 3
for i = 1 to len a[][] : len a[i][] 4
a[1][2] = 99
print a[][]
#
# some builtin functions
#
if sin 90 = 1
   print "Angles are in degree"
.
print "A kibibyte: " & pow 2 10
print "Seconds since 1970: " & floor systime
print "Random between 0 and 1: " & randomf
print "A dice roll: " & random 6
#
print "Current time: " & substr timestr systime 12 5
#
print strcode "A" & " is " & strchar 65
#
# set number output format
#
numfmt 4 0
print "Square root of 2: " & sqrt 2
print "Pi: " & pi
print "10's logarithm of 999: " & log10 999
#
a$[] = strsplit "10,15,22" ","
print a$[]
print 2 * number a$[1]
print len a$[]
print len "Hello"
#
# "input" reads a string from the "input_data" section, if it exists,
# otherwise via a prompt.
#
repeat
   s$ = input
   until s$ = ""
   sum += number s$
.
print "sum: " & sum
#
input_data
10
-2
6
```

Built-in graphic primitives and event-driven programming

```
# simple drawing with the mouse
#
linewidth 4
color 900
# the colors are coded from 0 to 999, where the
# decimal digits specify the RGB components
#
on mouse_down
   down = 1
   move mouse_x mouse_y
   # moves the drawing pen to the actual mouse position
   circle 2
.
on mouse_up
   down = 0
.
on mouse_move
   if down = 1 : line mouse_x mouse_y
.
```

```
# an animated pendulum
#
ang = 45
on animate
   # The animate event occurs after each screen refresh.
   clear
   move 50 50
   circle 1
   x = 50 + 40 * sin ang
   y = 50 + 40 * cos ang
   line x y
   circle 6
   vel += sin ang / 5
   ang += vel
.
```

* [More about Easylang](https://easylang.online/apps/)

* [Source code](https://github.com/chkas/easylang/)

