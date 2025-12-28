func logn n .
   return log n 0
.
numfmt 0 5
for i = 1 to 1000
   a[] &= 1 + 0.5 * sqrt (-2 * logn randomf) * cos (360 * randomf)
.
for v in a[]
   avg += v / len a[]
.
print "Average: " & avg
for v in a[]
   s += pow (v - avg) 2
.
s = sqrt (s / len a[])
print "Std deviation: " & s
