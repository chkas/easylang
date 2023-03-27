n = 250
len p5[] n
for i = 0 to n - 1
  p5[i + 1] = i * i * i * i * i
.
func search a b s . y .
  y = -1
  while a + 1 < b
    i = (a + b) div 2
    if p5[i + 1] > s
      b = i
    elif p5[i + 1] < s
      a = i
    else
      y = i
      a = b
    .
  .
.
for x0 = 0 to n - 1
  for x1 = 0 to x0
    for x2 = 0 to x1
      for x3 = 0 to x2
        sum = p5[x0 + 1] + p5[x1 + 1] + p5[x2 + 1] + p5[x3 + 1]
        call search x0 n sum y
        if y >= 0
          print x0 & " " & x1 & " " & x2 & " " & x3 & " " & y
          break 4
        .
      .
    .
  .
.

