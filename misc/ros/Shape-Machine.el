numfmt 15 0
n = 4
while n <> prev
   prev = n
   n = (n + 3) * 0.86
   cnt += 1
.
print n & " (after " & cnt & " iterations)"
