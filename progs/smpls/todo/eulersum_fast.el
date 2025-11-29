n = 250
len p5[] n
len h5[] 65537
for i range n
  p5[i] = i * i * i * i * i
  h5[p5[i] mod 65537] = 1
.
func search a s . y .
  y = -1
  b = n
  while a + 1 < b
    i = (a + b) div 2
    if p5[i] > s
      b = i
    elif p5[i] < s
      a = i
    else
      a = b
      y = i
    .
  .
.
for x0 range n
  for x1 range x0
    sum1 = p5[x0] + p5[x1]
    for x2 range x1
      sum2 = p5[x2] + sum1
      for x3 range x2
        sum = p5[x3] + sum2
        if h5[sum mod 65537] = 1
          call search x0 sum y
          if y >= 0
            print x0 & " " & x1 & " " & x2 & " " & x3 & " " & y
            break 4
          .
        .
      .
    .
  .
.
print sysfunc "time"

