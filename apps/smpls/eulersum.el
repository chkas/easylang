n = 250
len p5[] n
for i range n
  p5[i] = i * i * i * i * i
.
func search a b s . y .
  y = -1
  while a + 1 < b
    i = (a + b) div 2
    if p5[i] > s
      b = i
    elif p5[i] < s
      a = i
    else
      y = i
      a = b
    .
  .
.
for x0 range n
  for x1 range x0
    for x2 range x1
      for x3 range x2
        sum = p5[x0] + p5[x1] + p5[x2] + p5[x3]
        call search x0 n sum y
        if y >= 0
          print x0 & " " & x1 & " " & x2 & " " & x3 & " " & y
          break 4
        .
      .
    .
  .
.
print sysfunc "time"

