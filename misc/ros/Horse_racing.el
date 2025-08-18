global name$[] gender[] rating[] .
proc add n$ gender rating .
   name$[] &= n$
   gender[] &= gender
   rating[] &= rating
.
proc sort &d[] &wh[] .
   for i = 1 to len d[] - 1 : for j = i + 1 to len d[]
      if wh[d[j]] > wh[d[i]] : swap d[j] d[i]
   .
.
a = 100
b = a - 8 - 2 * 2
c = a + 4 - 2 * 3.5
d = a - 4 - 10 * 0.4
e = d + 7 - 2 * 1
f = d + 11 - 2 * (4 - 2)
g = a - 10 + 10 * 0.2
h = g + 6 - 2 * 1.5
i = g + 15 - 2 * 2
#
b += 4
c -= 4
h += 3
j = a - 3 + 10 * 0.2
#
b += 3
d += 3
i += 3
j += 3
#
add "A" 2 a
add "B" 1 b
add "C" 2 c
add "D" 1 d
add "E" 2 e
add "F" 2 f
add "G" 2 g
add "H" 2 h
add "I" 1 i
add "J" 1 j
#
for i to len name$[] : sorted[] &= i
sort sorted[] rating[]
numfmt 3 1
print "Race 4"
print ""
print "Pos  Horse  Weight  Dist Gender"
pos$ = ""
gender$[] = [ "filly" "colt" ]
weight$[] = [ "8.11" "9.00" ]
for i to len name$[]
   id = sorted[i]
   gnd = gender[id]
   dist = 0
   if i > 1 : dist = (rating[sorted[i - 1]] - rating[id]) * 0.5
   if i = 1 or dist > 0 : pos$ = i & " "
   print pos$ & "  " & name$[id] & "      " & weight$[gender[id]] & "   " & dist & "  " & gender$[gnd]
.
print ""
rating = rating[sorted[1]]
time = 96 - (rating - 100) / 10
print "Time: " & time div 60 & " minute " & time mod 60 & " seconds"
